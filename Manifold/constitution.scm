#|
ManifoldOS — Constitution

What is this file?

  This is the supreme law of ManifoldOS — a custom GNU Guix Linux system
  built on a single radical principle: the owner of the machine controls
  every single line of code that runs on it. No exceptions.

  In a standard Guix system, your configuration imports packages and
  services from external channels maintained by others. Your system is
  ultimately defined by decisions made elsewhere, by people you don't know,
  on servers you don't control. If those servers go down, change their API,
  push a bad update, or get compromised — your system is affected.

  ManifoldOS eliminates this entirely. Every package definition, every
  service, every build instruction lives inside this repository under
  /ManifoldOS/Manifold. Nothing is fetched from external channels. Nothing
  depends on a third party staying online or trustworthy. The system is
  yours — completely, permanently, unconditionally.

What does this file do?

  This file is the entry point that Guix reads when you run:

    sudo guix system reconfigure system.scm

  It does four things:

    1. SCAN    — Walks every .scm file under /ManifoldOS/Manifold and
                 automatically discovers all package and service definitions.
                 No manual wiring needed. Drop a file in, it's part of the
                 system on the next reconfigure.

    2. INJECT  — Loads a prelude module first and injects its bindings into
                 every scanned module automatically. Individual module files
                 need zero import boilerplate — they just declare what they define.

    3. ENFORCE — After each module loads, verifies that it imports nothing
                 from outside /ManifoldOS/Manifold. Any external import is a
                 hard build error that names exactly what needs to be vendored.
                 This is what makes sovereignty structural rather than a convention.

    4. ASSEMBLE — Deduplicates all discovered packages and services, runs
                 a regression check against the currently running system,
                 and produces the final operating-system declaration that Guix builds.

What is the Manifold?

  The Manifold is the directory at /ManifoldOS/Manifold. It contains:

    constitution.scm         — this file
    prelude.scm              — shared bindings injected into all modules
    substrate/kernel-space/  — kernel, bootloader, filesystem, hardware
    substrate/user-space/    — all packages, services, and user config
    declarations/            — vendored package definitions (no external deps)

  Every .scm file in the Manifold is automatically discovered by the scanner.
  Files contribute packages and services by defining public symbols ending in
  -packages or -services, or bare package values.

What is vendoring?

  Vendoring means copying an external dependency's source code into your own
  repository so you own it permanently. In ManifoldOS, every package definition
  that would normally come from a Guix channel is instead copied into
  declarations/ and owned by you. The sovereignty enforcer in this file makes
  vendoring mandatory — it will not let the system build until every dependency
  lives inside the Manifold.

What is the prelude?

  The prelude.scm file is the single place where external imports are permitted
  during the vendoring process. It aggregates all shared bindings — build
  systems, package primitives, common dependencies — and the constitution
  injects it into every module automatically. As vendoring progresses, the
  prelude's external imports shrink. When vendoring is complete, the prelude
  itself becomes fully sovereign.

What does "sovereignty violation" mean?

  If any module imports something from outside the Manifold, the build stops
  immediately with an error like:

    constitution: sovereignty violation in substrate/shell/atuin.scm
    — imports external module gnu/packages/base at /gnu/store/.../base.scm
    — vendor it into manifold-root

  The fix is to copy that module's definition into declarations/ and update
  the import to point there instead.

constitution:no-warn
|#


(define-module (constitution)
  #:use-module (ice-9 ftw)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-11)
  #:use-module (gnu system)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services guix)
  #:use-module (guix packages)
  #:use-module (guix profiles)
  #:use-module (substrate kernel-space kernel-space)
  #:use-module (substrate user-space root users users)
  #:use-module (substrate user-space home home))


#|
Manifold Root

The absolute path to the Manifold directory. Every file path in this loader
is derived from this root. Falls back to a hardcoded absolute path when
current-filename is unavailable — for example when loaded directly via
guix system reconfigure rather than guix repl.
|#

(define manifold-root
  (or (and=> (current-filename) dirname)
      "/ManifoldOS/Manifold"))


#|
Prelude Loader

The prelude is a special module that aggregates all shared bindings — build
systems, package primitives, licenses, common inputs — into one place.
Instead of every module file repeating the same #:use-module declarations,
the constitution loads the prelude once and injects it into every scanned
module automatically via Guile's module-use!.

The result: individual module files need zero import boilerplate. They just
define their packages and services. The constitution handles the rest.

The prelude is the single declared sovereignty boundary — the only file
allowed to import from outside the Manifold during the vendoring phase.
As vendoring progresses and more definitions move into declarations/, the
prelude's external imports shrink. When complete, it imports nothing external.

If prelude.scm does not exist, injection is silently skipped and modules
fall back to declaring their own imports normally.
|#

(define prelude-module
  (let ((prelude-file (string-append manifold-root "/prelude.scm")))
    (if (file-exists? prelude-file)
        (begin
          (load prelude-file)
          (resolve-module '(prelude)))
        #f)))

(define (inject-prelude! mod)
  #|
  Injects the prelude module into MOD's use list via module-use! so that all
  prelude-exported symbols are visible inside MOD without any explicit import
  statement in the module file itself.

  Called AFTER each module loads — not before — because Guile's define-module
  resets the module's use list when it executes. Injecting after load means
  the injection is never wiped by define-module.
  |#
  (when prelude-module
    (module-use! mod prelude-module)))


#|
Pragma Reader

Some files in the Manifold legitimately export things that are not packages
or services — this file exports the os record, for example. Without a way
to silence them, these files would trigger spurious collector warnings.

Any file containing the string constitution:no-warn anywhere in its first
10 lines will have collector warnings suppressed. Errors always halt
regardless of the pragma. Scanning and collection still run normally.
|#

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


#|
Module Name Formatter

Converts a Guile module name list to a human-readable path string.
Used exclusively in error messages so violations are easy to locate.

Example:
  (substrate user-space root shell atuin) -> "substrate/user-space/root/shell/atuin"
|#

(define (format-module-name mod-name)
  (string-join (map symbol->string mod-name) "/"))


#|
Sovereignty Enforcer

After each module loads, walks its full import list and checks that every
imported module resolves to a file inside manifold-root. If any import
resolves outside — a Guix channel module, an upstream package definition,
anything external — the build halts immediately with an error that names:

  - The file containing the violation
  - The external module it tried to import
  - The exact path where that external module was found on disk

The prelude module is the only exception. It is the declared sovereignty
boundary and is explicitly excluded from this check. All other modules
must be fully sovereign — no exceptions, no exemptions.

The fix for any violation is always the same: copy the external module's
definition into the appropriate location under manifold-root, update the
import to point there, and rebuild.
|#

(define (assert-sovereign! mod file)
  (let ((imports (module-uses mod)))
    (for-each
     (lambda (dep)
       (unless (eq? dep prelude-module)
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
                              dep-file)))))))
     imports)))


#|
Module Collector

After a module loads and passes sovereignty enforcement, extracts its
contributions to the system — packages and services.

Walks the module's local obarray directly, which means it only sees
bindings defined in that file itself. Inherited bindings from #:use-module
imports are invisible here, so re-exports are never double-counted.

A binding is collected if it matches one of these patterns:
  - A symbol ending in -packages whose value is a list of packages
  - A symbol ending in -services (excluding home- prefix) whose value
    is a list of services
  - Any bare package value regardless of symbol name

If a module exports public bindings but none match any pattern, a warning
is emitted. This catches typos like -package instead of -packages before
they silently drop something from the system. Suppressed by no-warn pragma.

Returns a pair: (packages . services)
|#

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


#|
Module Name Resolver

Converts an absolute .scm file path into the Guile module name list that
Guile uses to load and resolve that module.

Example:
  /ManifoldOS/Manifold/substrate/shell/atuin.scm -> (substrate shell atuin)
|#

(define (file->module-name file root)
  (let* ((relative (substring file (+ 1 (string-length root))))
         (no-ext   (substring relative 0 (- (string-length relative) 4)))
         (parts    (string-split no-ext #\/)))
    (map string->symbol parts)))


#|
Manifold Scanner

The heart of the constitution. Recursively walks every .scm file under
manifold-root and processes each one in order. For every file it:

  1. Skips prelude.scm — loaded separately before scanning began
  2. Reloads the file if its source is newer than its compiled .go cache,
     ensuring the scanner never operates on stale compiled output
  3. Resolves the module by name — hard error if it cannot be found
  4. Injects the prelude into the module via module-use!
  5. Asserts sovereignty — hard error if any external import is found
  6. Collects packages and services from the module's local obarray
  7. Accumulates results and moves to the next file

Files are sorted lexicographically for deterministic build order.
Only files matching ^[^.]+\.scm$ are considered — dotfiles, backup files,
org files, shell scripts and everything else is invisible to the scanner.

At the end, prints to stderr:
  constitution: scanned N files — P packages, S services

Returns two values: (packages services)
|#

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
               (prelude? (equal? mod-name '(prelude))))
          (if prelude?
              (loop (cdr files) packages services n-files)
              (let* ((_   (let* ((go  (compiled-file-name file))
                                 (s-t (stat:mtime (stat file)))
                                 (g-t (if (file-exists? go)
                                          (stat:mtime (stat go))
                                          0)))
                            (when (> s-t g-t)
                              (load file))))
                     (mod (resolve-module mod-name)))
                (unless mod
                  (error (format #f "constitution: failed to load module ~a from ~a"
                                 (format-module-name mod-name) file)))
                (inject-prelude! mod)
                (assert-sovereign! mod file)
                (let* ((result (collect-from-module mod no-warn?))
                       (pkgs   (car result))
                       (svcs   (cdr result)))
                  (loop (cdr files)
                        (append pkgs packages)
                        (append svcs services)
                        (+ n-files 1)))))))))


#|
Package Deduplication

Two references to the exact same package object are silently collapsed.
Two different package objects with the same name are a hard build error —
this means two files defined the same package differently, which is always
a mistake that must be fixed before the system can be built.
|#

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


#|
Service Deduplication

Services are deduplicated more leniently than packages. If two modules
contribute a service of the same type, a warning is emitted but the build
continues — Guix itself handles the merge and decides the winner. This is
intentional because some service types are legitimately extended by multiple
modules, and halting on every duplicate would be too aggressive.
|#

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


#|
Regression Check

Reads the package manifest of the currently running system and compares it
against the packages just discovered by the scanner. Any package that was
in the running system but is absent from the new scan triggers a warning.

This catches accidental deletions — if a module file is removed, renamed,
or an export is misspelled, the package silently disappears from the next
system. The regression check surfaces this before reconfigure completes so
you can decide whether the removal was intentional or a mistake.

Never halts the build. Silently skipped on a fresh install where
/run/current-system does not yet exist.
|#

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


#|
Scan + Deduplicate + Regression Check

Runs the full pipeline: scan every file, deduplicate results, check for
regressions against the running system. Produces the two values consumed
by the OS declaration below.
|#

(define-values (all-packages all-services)
  (let-values (((pkgs svcs) (scan-manifold manifold-root)))
    (check-regressions pkgs)
    (values (dedupe-packages pkgs)
            (dedupe-services svcs))))


#|
OS Declaration

The final operating-system record that Guix builds. Every structural
binding — host-name, kernel, file-systems, users, bootloader — comes from
the explicitly imported substrate modules at the top of this file.
Packages and services come entirely from the scanner output.

Service assembly order (first wins when Guix cannot merge):
  1. kernel-system-services — hardware, kernel modules, lowest level
  2. all-services           — everything scanned from user-space modules
  3. guix-home-service-type — home environment for user aoeu
  4. %base-services         — Guix baseline every system needs
|#

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
