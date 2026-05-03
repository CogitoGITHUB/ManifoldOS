;;; ManifoldOS Constitution
;;; The supreme law of the system. Declares what exists, what runs, and what
;;; is collected. All substrate modules are scanned and assembled here into
;;; a single operating-system declaration.
;;;
;;; Sovereignty Principle:
;;; This system belongs entirely to ManifoldOS. No external modules, channels,
;;; or dependencies are permitted anywhere in the manifold. Every module
;;; imported by any substrate file must live under manifold-root. Any external
;;; import is a hard error — no exceptions, no exemptions, not even this file.
;;; When this loader builds clean, the system is truly yours.
;;; constitution:no-warn


(define-module (constitution)
  ;; Scanner utilities
  #:use-module (ice-9 ftw)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-11)
  ;; OS declaration
  #:use-module (gnu system)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services guix)
  #:use-module (guix packages)
  #:use-module (guix profiles)
  ;; Substrate anchors
  #:use-module (substrate kernel-space kernel-space)
  #:use-module (substrate user-space root users users)
  #:use-module (substrate user-space home home))


;;; Manifold Root
;;; The absolute path to the Manifold directory. All scanning is rooted here.
;;; Falls back to a known absolute path if current-filename is unavailable
;;; (e.g. when loaded via guix system rather than directly).

(define manifold-root
  (or (and=> (current-filename) dirname)
      "/ManifoldOS/Manifold"))


;;; Pragma Reader
;;; Reads the first 10 lines of a file and checks for constitution:no-warn.
;;; Files with this pragma have warnings suppressed but are still fully
;;; scanned and collected. Errors always halt regardless of pragma.

(define (file-no-warn? file)
  (call-with-input-file file
    (lambda (port)
      (let loop ((n 10))
        (if (zero? n)
            #f
            (let ((line (read-line port)))
              (if (eof-object? line)
                  #f
                  (if (string-contains line "constitution:no-warn")
                      #t
                      (loop (- n 1))))))))))


;;; Module Name Formatter
;;; Formats a module name list as a readable path string for error messages.
;;; Example: (substrate foo bar) -> "substrate/foo/bar"

(define (format-module-name mod-name)
  (string-join (map symbol->string mod-name) "/"))


;;; Sovereignty Enforcer
;;; Walks every import of a loaded module and verifies it resolves to a file
;;; under manifold-root. Any module resolving outside manifold-root is a hard
;;; error — no external channels, no Guix modules, no exceptions.
;;; This is what makes the system truly yours.

(define (assert-sovereign! mod file)
  (let ((imports (module-uses mod)))
    (for-each
     (lambda (dep)
       (let* ((dep-name (module-name dep))
              (dep-file (search-path %load-path
                                     (string-append
                                      (string-join (map symbol->string dep-name) "/")
                                      ".scm"))))
         (when dep-file
           (unless (string-prefix? manifold-root dep-file)
             (error (format #f "constitution: sovereignty violation in ~a — imports external module ~a at ~a — vendor it into manifold-root"
                            file
                            (format-module-name dep-name)
                            dep-file))))))
     imports)))
;;; Walks the local obarray of a single resolved module and extracts:
;;;   - Any symbol ending in "-packages" whose value is a list of packages
;;;   - Any symbol ending in "-services" (non-home) whose value is a list of services
;;;   - Any bare exported package value
;;;
;;; Uses module-obarray directly so only truly local bindings are visited —
;;; inherited bindings from #:use-module imports are never seen, making the
;;; re-export check redundant by construction.
;;;
;;; If the module has public exports but none matched any known pattern,
;;; a warning is emitted (suppressed if constitution:no-warn is set).
;;;
;;; Returns a pair: (packages . services)

(define (collect-from-module mod no-warn?)
  (let ((packages '())
        (services '())
        (matched  0)
        (exported 0))
    (hash-for-each
     (lambda (sym var)
       (when (variable-bound? var)
         (set! exported (+ exported 1))
         (let ((val (variable-ref var)))
           (cond
             ((and val (list? val)
                   (string-suffix? "-packages" (symbol->string sym))
                   (every package? val))
              (set! packages (append val packages))
              (set! matched (+ matched 1)))
             ((and val (list? val)
                   (string-suffix? "-services" (symbol->string sym))
                   (not (string-prefix? "home-" (symbol->string sym)))
                   (every service? val))
              (set! services (append val services))
              (set! matched (+ matched 1)))
             ((and val (package? val))
              (set! packages (cons val packages))
              (set! matched (+ matched 1)))
             (else #f)))))
     (module-obarray mod))
    (when (and (> exported 0) (zero? matched) (not no-warn?))
      (format (current-error-port)
              "WARNING: ~a has ~a public export(s) but contributed no packages or services — check export names~%"
              (format-module-name (module-name mod)) exported))
    (cons packages services)))


;;; Module Name Resolver
;;; Converts an absolute .scm file path to a Guile module name list.
;;; Example:
;;;   /ManifoldOS/Manifold/substrate/foo/bar.scm -> (substrate foo bar)

(define (file->module-name file root)
  (let* ((relative (substring file (+ 1 (string-length root))))
         (no-ext   (substring relative 0 (- (string-length relative) 4)))
         (parts    (string-split no-ext #\/)))
    (map string->symbol parts)))


;;; Manifold Scanner
;;; Recursively finds all .scm files under manifold-root, resolves each as a
;;; Guile module, and collects packages and services from each.
;;;
;;; Files are sorted lexicographically before processing to ensure
;;; deterministic ordering.
;;;
;;; Only files matching ^[^.]+\.scm$ are considered — backup files, dotfiles,
;;; org files, shell scripts and anything else are invisible to the scanner.
;;;
;;; If the source file is newer than its compiled .go, it is force-reloaded
;;; to ensure the scanner never operates on stale compiled modules.
;;;
;;; Every anomaly is a hard error that halts the build immediately.
;;; Returns two values: (packages services) and emits a scan summary.

(define (scan-manifold root)
  (let loop ((files    (sort (find-files root "^[^.]+\\.scm$") string<?))
             (packages '())
             (services '())
             (n-files  0))
    (if (null? files)
        (begin
          (format (current-error-port)
                  "constitution: scanned ~a files — ~a packages, ~a services~%"
                  n-files
                  (length packages)
                  (length services))
          (values (reverse packages) (reverse services)))
        (let* ((file     (car files))
               (no-warn? (file-no-warn? file))
               (mod-name (file->module-name file root))
               ;; Force reload if source is newer than compiled .go
               (_        (let* ((go   (compiled-file-name file))
                                (s-t  (stat:mtime (stat file)))
                                (g-t  (if (file-exists? go)
                                          (stat:mtime (stat go))
                                          0)))
                           (when (> s-t g-t)
                             (load file))))
               (mod      (resolve-module mod-name)))
          (unless mod
            (error (format #f "constitution: failed to load module ~a from ~a"
                           (format-module-name mod-name) file)))
          (assert-sovereign! mod file)
          (let* ((result (collect-from-module mod no-warn?))
                 (pkgs   (car result))
                 (svcs   (cdr result)))
            (loop (cdr files)
                  (append pkgs packages)
                  (append svcs services)
                  (+ n-files 1)))))))


;;; Package Deduplication
;;; Uses a hash table for O(n) duplicate name detection.
;;; Duplicate package names across different objects are a hard error.

(define (dedupe-packages pkgs)
  (let ((seen (make-hash-table)))
    (for-each
     (lambda (pkg)
       (let* ((name     (package-name pkg))
              (existing (hash-ref seen name #f)))
         (when existing
           (unless (eq? existing pkg)
             (error (format #f "constitution: duplicate package '~a' — two different definitions exist, fix your modules"
                            name))))
         (hash-set! seen name pkg)))
     pkgs))
  (delete-duplicates pkgs eq?))


;;; Service Deduplication
;;; Keeps all services and lets Guix handle merging.
;;; Warns once per duplicate pair using a hash table.

(define (dedupe-services svcs)
  (let ((seen (make-hash-table)))
    (for-each
     (lambda (svc)
       (let* ((kind (service-kind svc))
              (name (service-type-name kind)))
         (if (hash-ref seen name #f)
             (format (current-error-port)
                     "WARNING: duplicate service type '~a' — letting Guix decide~%"
                     name)
             (hash-set! seen name #t))))
     svcs))
  svcs)


;;; Regression Check
;;; If /run/current-system exists, reads the active system's package manifest
;;; and warns about any package present in the running system that is missing
;;; from the current scan. Never halts — warnings only.

(define (check-regressions new-pkgs)
  (let ((profile "/run/current-system/profile"))
    (when (file-exists? profile)
      (let* ((manifest      (profile-manifest profile))
             (current-names (map manifest-entry-name
                                 (manifest-entries manifest)))
             (new-names     (map package-name new-pkgs))
             (new-set       (make-hash-table)))
        (for-each (lambda (n) (hash-set! new-set n #t)) new-names)
        (for-each
         (lambda (name)
           (unless (hash-ref new-set name #f)
             (format (current-error-port)
                     "WARNING: '~a' was in the running system but is missing from the new scan~%"
                     name)))
         current-names)))))

(define-values (all-packages all-services)
  (let-values (((pkgs svcs) (scan-manifold manifold-root)))
    (values (dedupe-packages pkgs)
            (dedupe-services svcs))))


;;; OS Declaration
;;; The single operating-system record that guix system consumes.
;;; All bindings (kernel, file-systems, users, etc.) come from explicitly
;;; imported substrate modules. Packages and services come from the scanner.
;;;
;;; Service priority (first wins if Guix cannot merge):
;;;   1. kernel-system-services  — lowest level, hardware and kernel
;;;   2. all-services            — scanned user-space services
;;;   3. guix-home-service-type  — home environment

(define-public os
  (operating-system
    (host-name host-name)
    (timezone system-timezone)
    (locale system-locale)
    (kernel kernel)
    (kernel-arguments kernel-arguments)
    (initrd kernel-initrd)
    (firmware kernel-firmware)
    (keyboard-layout keyboard-layout)
    (bootloader system-bootloader-configuration)
    (file-systems file-systems)
    (users users)
    (groups groups)
    (sudoers-file sudoers-file)
    (setuid-programs setuid-programs)
    (packages all-packages)
    (services (delete-duplicates
               (append kernel-system-services
                       all-services
                       (list (service guix-home-service-type
                                      (list (list "aoeu" mappingos-home-environment))))
                       %base-services)
               (lambda (a b)
                 (eq? (service-kind a) (service-kind b)))))))


#|
============================================================================
ManifoldOS Sovereignty Model — Design, Implementation, and Intent
============================================================================

The Goal
--------
Most Linux systems are configurations layered on top of someone else's work.
You declare what you want, a package manager fetches it from external servers,
and your system is ultimately defined by decisions made elsewhere. You depend
on channels, mirrors, upstream maintainers, and build farms staying online and
trustworthy. ManifoldOS is built to eliminate every one of these dependencies.

The Sovereignty Principle
-------------------------
Every single thing that runs on this machine must originate from inside
/ManifoldOS/Manifold. No external Guix channels. No upstream package
definitions pulled from ci.guix.gnu.org. No #:use-module pointing outside
manifold-root. If it is not in the manifold, it does not exist on this system.

This is enforced at build time by the constitution loader itself. It is not
a convention or a guideline — it is a hard error that stops the build
immediately and tells you exactly what needs to be vendored.

How It Works
------------
The scanner (scan-manifold) loads every .scm file under manifold-root as a
Guile module. After each module loads, assert-sovereign! walks the full list
of modules that file imported via #:use-module. For each imported module it
resolves the source file path using %load-path. If that path is not under
manifold-root, the build halts with an error naming:
  - The file that contains the violation
  - The external module it tried to import
  - The path where that external module was found

This means the enforcement is structural, not textual. It does not grep for
import statements — it inspects the actual resolved module graph at runtime,
so there is no way to sneak an external dependency through an alias or an
indirect import.

The Vendoring Process
---------------------
When a sovereignty violation is reported, the fix is to vendor the offending
module. That means:
  1. Copy the external module's source into an appropriate location under
     manifold-root (e.g. substrate/guix/packages/tls.scm)
  2. Update its define-module declaration to match its new path
  3. Update the #:use-module in your substrate file to point to the vendored copy
  4. Repeat until the build is clean

Each vendored module may itself import other external modules, which will then
surface as the next sovereignty violation. You work through them one by one
until the entire dependency graph lives inside manifold-root.

This process is intentionally incremental. The system builds and runs at every
step — you vendor one module, the build gets one step closer to full
sovereignty. You never have to vendor everything at once.

What Full Sovereignty Means
---------------------------
When the constitution loader builds without any sovereignty violations, it
means every line of code that runs on this machine was put there by you. No
external actor can break your system by taking down a server, changing an API,
revoking a signing key, or pushing a malicious update. The system is frozen
in exactly the state you chose, and it will stay that way until you change it.

This is not paranoia. This is ownership.

The Regression Check
--------------------
As an additional safety net, the loader reads the package manifest of the
currently running system from /run/current-system/profile before each build.
Any package that was present in the running system but is absent from the new
scan emits a warning. This catches accidental deletions — if you remove a
substrate file or rename an export and something disappears from the system,
you are told about it before the reconfigure completes. The build never halts
on this — it is information, not an error. You decide whether the removal was
intentional.

The No-Warn Pragma
------------------
Some files legitimately export things that are not packages or services — the
constitution.scm file itself exports the `os` record, for example. These files
would trigger a spurious warning about contributing nothing to the scan. The
pragma:

  ;;; constitution:no-warn

placed anywhere in the first 10 lines of a file tells the loader to suppress
warnings for that file. It has no effect on errors — those always halt
regardless of the pragma. It has no effect on scanning — the file is still
fully loaded and collected. It only silences warnings that are known to be
intentional for that specific file.

============================================================================
|#