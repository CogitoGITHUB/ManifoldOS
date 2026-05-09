#|
ManifoldOS — Constitution
The supreme law of the system. Every package, service, and structural OS
binding lives inside this repository — nothing is fetched from external
channels. Drop a .scm file anywhere under the Manifold and it is part of
the system on the next reconfigure. No wiring, no boilerplate, no exceptions.

Module files are self-contained: define-public your packages and services,
the constitution scans, injects the prelude, enforces sovereignty, and
assembles the final OS declaration automatically.

Substrate symbols (kernel, file-systems, host-name, ...) are picked up by
name — define-public the symbol in any file and it fills the OS field.

The prelude is built dynamically from the imports found across all module
files — add or remove a #:use-module in any file and it propagates
automatically. No external prelude.scm needed.

Module files must contain only a bare (define-module ...) declaration with
no #:use-module, #:select, #:prefix, or any other import clause. All symbols
arrive exclusively through the prelude which is seeded from the constitution.
External modules, aliases, and prefixed imports are sovereignty violations and
will cause the build to fail. Every symbol you need must already exist inside
the Manifold or be added to the constitution's own define-module.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SUBSTRATE LAYOUT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

substrate/ is the vendored foundation of the entire system. Nothing is pulled
from the Guix store or external channels at build time — everything resolves
to a file inside this repo.

  substrate/guile/          — vendored Guile stdlib (srfi, ice-9, system/base)
  substrate/gnu/            — full vendored copy of gnu/* from guix-1.5.0
  substrate/guix/           — full vendored copy of guix/* from guix-1.5.0
  substrate/kernel-space/   — ManifoldOS kernel, bootloader, filesystem, etc.
  substrate/user-space/     — ManifoldOS packages and services

The gnu/ and guix/ subtrees were copied wholesale from:
  /gnu/store/ganla421f3g1p9rh3r68zj9djc9b807m-guix-1.5.0/share/guile/site/3.0/

They are NOT modified — they keep their define-module declarations intact
because they are loaded through the normal Guile module system, not through
the constitution's prelude injector. The %load-path injection below ensures
they shadow the store copies at load time.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CARVING OUT MODULES FROM substrate/gnu/ AND substrate/guix/
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

substrate/gnu/ and substrate/guix/ are flat copies of upstream. Over time you
will want to pull individual files out of them, patch them, and reorganise them
under substrate/kernel-space/ or substrate/user-space/ with your own structure.

PROCESS for carving out a module (e.g. gnu/bootloader/grub.scm):

  1. Copy the file to your preferred location:
       cp substrate/gnu/bootloader/grub.scm substrate/kernel-space/bootloader/grub.scm

  2. The file keeps its (define-module (gnu bootloader grub) ...) declaration —
     do NOT strip it. The module name must stay the same so existing imports
     resolve correctly.

  3. Delete the original from substrate/gnu/:
       rm substrate/gnu/bootloader/grub.scm

  4. Because substrate/ comes before substrate/gnu/ on %load-path (see below),
     Guile will find your carved-out copy first. You now own it.

  5. Patch it however you like. Chase its dependencies the same way if needed.

  6. Over time substrate/gnu/ and substrate/guix/ will empty out as everything
     gets carved into intentional locations. When they are empty, delete them.

constitution:no-warn
|#

;; ── Substrate Load Path ───────────────────────────────────────────────────────
;; This MUST run before define-module. It prepends substrate/ paths so that
;; every (gnu *) and (guix *) import resolves to our vendored copies first,
;; never to the store.
(eval-when (expand load eval)
  (let ((root (or (and=> (current-filename) dirname)
                  "/ManifoldOS/Manifold")))
    (set! %load-path
      (append
        (list
          (string-append root "/substrate")          ;; carved-out modules land here
          (string-append root "/substrate/gnu")      ;; vendored gnu/* bulk copy
          (string-append root "/substrate/guix"))    ;; vendored guix/* bulk copy
        %load-path))))

(define-module (constitution)
  #:declarative? #f
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-11)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system)
  #:use-module (gnu services)
  #:use-module (guix packages)
  #:use-module (guix profiles))

(define manifold-root
  (or (and=> (current-filename) dirname)
      "/ManifoldOS/Manifold"))

;; ── Pure Guile String Utilities ───────────────────────────────────────────────
(define (string-split* str ch)
  (let loop ((chars (string->list str)) (current '()) (acc '()))
    (cond
      ((null? chars)
       (reverse (cons (list->string (reverse current)) acc)))
      ((char=? (car chars) ch)
       (loop (cdr chars) '() (cons (list->string (reverse current)) acc)))
      (else
       (loop (cdr chars) (cons (car chars) current) acc)))))

(define (string-contains* haystack needle)
  (let* ((hlen (string-length haystack))
         (nlen (string-length needle)))
    (let loop ((i 0))
      (cond
        ((> (+ i nlen) hlen) #f)
        ((string=? (substring haystack i (+ i nlen)) needle) i)
        (else (loop (+ i 1)))))))

;; ── Constitution Sovereignty Check ───────────────────────────────────────────
;; Runs at load time. Errors immediately if constitution imports anything
;; that has a .scm file outside manifold-root.
(for-each
 (lambda (iface)
   (let* ((name (module-name iface))
          (rel  (and name (string-join (map symbol->string name) "/")))
          (scm  (and rel (search-path %load-path (string-append rel ".scm")))))
     (when (and scm (not (string-prefix? manifold-root scm)))
       (error (format #f "constitution: SELF-SOVEREIGNTY VIOLATION — constitution imports external module ~a at ~a — vendor it into manifold-root"
                      (string-join (map symbol->string name) "/") scm)))))
 (module-uses (current-module)))

;; ── Module Registry ───────────────────────────────────────────────────────────
(define (module-tree-set! name mod)
  (let ((root (resolve-module '() #f #f #:ensure #t)))
    (nested-define-module! root name mod)))

;; ── File Collection ───────────────────────────────────────────────────────────
;; Pure Guile — opendir/readdir/stat are raw primitives, no imports needed.
;; substrate/gnu/ and substrate/guix/ are vendored Guix source loaded via
;; %load-path — they are NOT ManifoldOS modules and must not be scanned.
(define (collect-scm-files root)
  (let ((skip (list (string-append root "/substrate/gnu")
                    (string-append root "/substrate/guix"))))
    (let loop ((dirs (list root)) (acc '()))
      (if (null? dirs)
          (sort acc string<?)
          (let* ((dir (car dirs))
                 (rest (cdr dirs))
                 (dp (opendir dir)))
            (let dir-loop ((dirs rest) (acc acc))
              (let ((entry (readdir dp)))
                (if (eof-object? entry)
                    (begin (closedir dp) (loop dirs acc))
                    (if (string-prefix? "." entry)
                        (dir-loop dirs acc)
                        (let ((path (string-append dir "/" entry)))
                          (let ((st (stat path #f)))
                            (cond
                              ((not st)
                               (dir-loop dirs acc))
                              ((and (equal? (stat:type st) 'directory)
                                    (member path skip))
                               (dir-loop dirs acc))
                              ((equal? (stat:type st) 'directory)
                               (dir-loop (cons path dirs) acc))
                              ((string-suffix? ".scm" entry)
                               (dir-loop dirs (cons path acc)))
                              (else
                               (dir-loop dirs acc))))))))))))))

;; ── Module Name Derivation ────────────────────────────────────────────────────
(define (file->module-name file root)
  (let* ((relative (substring file (+ 1 (string-length root))))
         (no-ext   (substring relative 0 (- (string-length relative) 4))))
    (map string->symbol (string-split* no-ext #\/))))

;; ── Dynamic Prelude Builder ───────────────────────────────────────────────────
(define (extract-use-modules-from-file file)
  (call-with-input-file file
    (lambda (port)
      (let loop ((acc '()))
        (let ((form (catch #t
                      (lambda () (read port))
                      (lambda _ (read-char port) '()))))
          (if (eof-object? form)
              acc
              (loop (append acc (extract-modules-from-form form)))))))))

(define (extract-modules-from-form form)
  (cond
    ((and (pair? form) (eq? (car form) 'use-modules))
     (filter (lambda (x) x) (map normalise-mod-spec (cdr form))))
    ((and (pair? form) (eq? (car form) 'define-module))
     (let loop ((tail (cddr form)) (acc '()))
       (cond
         ((null? tail) acc)
         ((and (eq? (car tail) '#:use-module) (pair? (cdr tail)))
          (let ((spec (normalise-mod-spec (cadr tail))))
            (loop (cddr tail) (if spec (cons spec acc) acc))))
         (else (loop (cdr tail) acc)))))
    (else '())))

(define (all-satisfy? pred lst)
  (or (null? lst) (and (pred (car lst)) (all-satisfy? pred (cdr lst)))))

(define (normalise-mod-spec spec)
  (cond
    ((and (list? spec) (all-satisfy? symbol? spec)) spec)
    ((and (pair? spec) (list? (car spec)) (all-satisfy? symbol? (car spec))) (car spec))
    ((and (pair? spec) (list? (car spec))) (car spec))
    (else #f)))

(define (loadable-external-module? mod-name manifold-names)
  (and (not (hash-ref manifold-names
                      (string-join (map symbol->string mod-name) "/")
                      #f))
       (let* ((rel (string-join (map symbol->string mod-name) "/"))
              (scm (search-path %load-path (string-append rel ".scm")))
              (go  (search-path %load-compiled-path (string-append rel ".go"))))
         (and (or scm go)
              (not (string-prefix? manifold-root (or scm go)))))))

(define (build-dynamic-prelude files)
  (let* ((manifold-names (let ((h (make-hash-table 31)))
                           (for-each (lambda (f)
                                       (hash-set! h
                                         (string-join (map symbol->string
                                                           (file->module-name f manifold-root))
                                                      "/")
                                         #t))
                                     files)
                           h))
         (all-specs (apply append (map extract-use-modules-from-file files)))
         (unique    (let ((seen (make-hash-table)))
                      (let loop ((lst all-specs) (acc '()))
                        (if (null? lst)
                            (reverse acc)
                            (let ((key (string-join (map symbol->string (car lst)) "/")))
                              (if (hash-ref seen key #f)
                                  (loop (cdr lst) acc)
                                  (begin
                                    (hash-set! seen key #t)
                                    (loop (cdr lst) (cons (car lst) acc)))))))))
         (manifold-only (filter (lambda (s)
                                  (and (not (member s '((constitution) (prelude))))
                                       (hash-ref manifold-names
                                                 (string-join (map symbol->string s) "/")
                                                 #f)))
                                unique))
         (mod (make-module)))
    (set-module-name! mod '(prelude))
    (beautify-user-module! mod)
    (set-module-public-interface! mod mod)
    (for-each (lambda (iface)
                (module-use! mod iface))
              (module-uses (current-module)))
    (for-each
     (lambda (mod-name)
       (catch #t
         (lambda ()
           (let ((m (resolve-module mod-name #f #f #:ensure #f)))
             (when m (module-use! mod m))))
         (lambda (key . args)
           (format (current-error-port)
                   "constitution: prelude could not add manifold module ~a — ~a~%"
                   mod-name args))))
     manifold-only)
    (module-tree-set! '(prelude) mod)
    mod))

;; ── Bootstrap ────────────────────────────────────────────────────────────────
(define all-scm-files (collect-scm-files manifold-root))
(define prelude-module (build-dynamic-prelude all-scm-files))
(define (inject-prelude! mod) (module-use! mod prelude-module))

;; ── Helpers ───────────────────────────────────────────────────────────────────
(define (file-no-warn? file)
  (call-with-input-file file
    (lambda (port)
      (define (read-line* port)
        (let loop ((chars '()))
          (let ((c (read-char port)))
            (cond
              ((eof-object? c) (if (null? chars) c (list->string (reverse chars))))
              ((char=? c #\newline) (list->string (reverse chars)))
              (else (loop (cons c chars)))))))
      (let loop ((n 10))
        (if (zero? n) #f
            (let ((line (read-line* port)))
              (if (eof-object? line) #f
                  (if (string-contains* line "constitution:no-warn") #t
                      (loop (- n 1))))))))))

(define (format-module-name mod-name)
  (string-join (map symbol->string mod-name) "/"))

;; ── Sovereignty Enforcer ──────────────────────────────────────────────────────
(define (make-module-set modules)
  (let ((h (make-hash-table 31)))
    (for-each (lambda (m) (hash-set! h m #t)) modules)
    h))

(define (assert-sovereign! mod file)
  (let ((prelude-deps (make-module-set (module-uses prelude-module))))
    (for-each
     (lambda (dep)
       (unless (or (eq? dep prelude-module)
                   (hash-ref prelude-deps dep #f))
         (let* ((dep-name (module-name dep))
                (dep-file (search-path %load-path
                            (string-append
                             (string-join (map symbol->string dep-name) "/")
                             ".scm"))))
           (when dep-file
             (unless (string-prefix? manifold-root dep-file)
               (error (format #f "constitution: sovereignty violation in ~a — imports external module ~a at ~a — vendor it into manifold-root"
                              file (format-module-name dep-name) dep-file)))))))
     (module-uses mod))))

;; ── Substrate Symbols ─────────────────────────────────────────────────────────
(define %os-rtd
  (@@ (gnu system) <operating-system>))

(define %substrate-symbols
  (record-type-fields %os-rtd))

;; ── Source Enforcer ───────────────────────────────────────────────────────────
(define (assert-local-source! pkg)
  (let ((src (package-source pkg)))
    (when src
      (let ((loc (and (origin? src)
                      (origin-uri src))))
        (when (and loc (string? loc)
                   (not (string-prefix? manifold-root loc)))
          (error (format #f "constitution: package '~a' source is not inside manifold-root/sources/ — use local-file pointing into sources/"
                         (package-name pkg))))))))

(define (collect-from-module mod no-warn? substrate)
  (let ((packages '()) (services '()) (matched 0) (exported 0))
    (hash-for-each
     (lambda (sym var)
       (when (variable-bound? var)
         (set! exported (+ exported 1))
         (let ((val (variable-ref var)))
           (cond
             ((memq sym %substrate-symbols)
              (hash-set! substrate sym val)
              (set! matched (+ matched 1)))
             ((and val (list? val)
                   (string-suffix? "-packages" (symbol->string sym))
                   (all-satisfy? package? val))
              (for-each assert-local-source! val)
              (set! packages (append val packages))
              (set! matched (+ matched 1)))
             ((and val (list? val)
                   (string-suffix? "-services" (symbol->string sym))
                   (not (string-prefix? "home-" (symbol->string sym)))
                   (all-satisfy? service? val))
              (set! services (append val services))
              (set! matched (+ matched 1)))
             ((and val (package? val))
              (assert-local-source! val)
              (set! packages (cons val packages))
              (set! matched (+ matched 1)))
             ((and val (service? val))
              (set! services (cons val services))
              (set! matched (+ matched 1)))
             (else #f)))))
     (module-obarray mod))
    (when (and (> exported 0) (zero? matched) (not no-warn?))
      (format (current-error-port)
              "WARNING: ~a has ~a public export(s) but contributed no packages, services, or substrate bindings — check export names~%"
              (format-module-name (module-name mod)) exported))
    (cons packages services)))

;; ── Module Loader ─────────────────────────────────────────────────────────────
(define (make-fresh-module mod-name)
  (let ((mod (make-module)))
    (set-module-name! mod mod-name)
    (beautify-user-module! mod)
    (set-module-public-interface! mod mod)
    (module-tree-set! mod-name mod)
    mod))

(define (load-module-file file mod-name)
  (let ((mod (or (and=> (resolve-module mod-name #f #f #:ensure #f)
                        (lambda (m)
                          (and (memq prelude-module (module-uses m)) m)))
                 (make-fresh-module mod-name))))
    (inject-prelude! mod)
    (let ((prev (current-module)))
      (set-current-module mod)
      (call-with-input-file file
        (lambda (port)
          (let loop ()
            (let ((form (read port)))
              (unless (eof-object? form)
                (cond
                  ((and (pair? form) (eq? (car form) 'define-module))
                   #f)
                  (else
                   (catch 'unbound-variable
                     (lambda () (eval form mod))
                     (lambda (key subr msg args . rest)
                       (let ((sym (and (pair? args) (car args))))
                         (error (format #f "constitution: unbound symbol '~a' in ~a\n  → add its source module to the constitution define-module"
                                        sym file)))))))
                (loop))))))
      (set-current-module prev))
    mod))

;; ── Scanner ───────────────────────────────────────────────────────────────────
(define (scan-manifold root files)
  (let ((substrate (make-hash-table)))
    (define (try-load-file file)
      (let* ((no-warn? (file-no-warn? file))
             (mod-name (file->module-name file root))
             (skip?    (member mod-name '((constitution) (prelude)))))
        (if skip?
            (cons 'skip #f)
            (catch #t
              (lambda ()
                (let* ((mod    (load-module-file file mod-name))
                       (result (begin (assert-sovereign! mod file)
                                      (collect-from-module mod no-warn? substrate))))
                  (cons 'ok result)))
              (lambda (key . args)
                (let ((msg (and (pair? args) (string? (car args)) (car args))))
                  (if (and msg (string-contains* msg "unbound symbol"))
                      (cons 'defer (cons key args))
                      (apply throw key args))))))))
    (let round ((pending files) (packages '()) (services '()) (n 0))
      (if (null? pending)
          (begin
            (format (current-error-port)
                    "constitution: scanned ~a files — ~a packages, ~a services, ~a substrate bindings~%"
                    n (length packages) (length services)
                    (hash-count (const #t) substrate))
            (values (reverse packages) (reverse services) substrate))
          (let pass ((todo pending) (deferred '()) (packages packages) (services services) (n n) (progress #f))
            (if (null? todo)
                (if (null? deferred)
                    (round '() packages services n)
                    (if progress
                        (round (reverse deferred) packages services n)
                        (let* ((file     (car (reverse deferred)))
                               (mod-name (file->module-name file root)))
                          (load-module-file file mod-name)
                          (error "constitution: unresolvable dependencies, stuck on" deferred))))
                (let* ((file   (car todo))
                       (result (try-load-file file)))
                  (cond
                    ((eq? (car result) 'skip)
                     (pass (cdr todo) deferred packages services n progress))
                    ((eq? (car result) 'ok)
                     (let ((pkgs (cadr result))
                           (svcs (cddr result)))
                       (pass (cdr todo)
                             deferred
                             (append pkgs packages)
                             (append svcs services)
                             (+ n 1)
                             #t)))
                    ((eq? (car result) 'defer)
                     (pass (cdr todo) (cons file deferred) packages services n progress))))))))))

;; ── Dedup + Regression ────────────────────────────────────────────────────────
(define (dedupe-packages pkgs)
  (let ((seen (make-hash-table)))
    (for-each
     (lambda (pkg)
       (let* ((name     (package-name pkg))
              (existing (hash-ref seen name #f)))
         (when existing
           (unless (eq? existing pkg)
             (error (format #f "constitution: duplicate package '~a' — two different definitions exist, fix your modules" name))))
         (hash-set! seen name pkg)))
     pkgs))
  (let ((seen (make-hash-table)))
    (let loop ((lst pkgs) (acc '()))
      (if (null? lst)
          (reverse acc)
          (let ((pkg (car lst)))
            (if (hash-ref seen (eq-hash pkg) #f)
                (loop (cdr lst) acc)
                (begin
                  (hash-set! seen (eq-hash pkg) #t)
                  (loop (cdr lst) (cons pkg acc)))))))))

(define (dedupe-services svcs)
  (let ((seen (make-hash-table)))
    (for-each
     (lambda (svc)
       (let ((name (service-type-name (service-kind svc))))
         (if (hash-ref seen name #f)
             (format (current-error-port)
                     "WARNING: duplicate service type '~a' — letting Guix decide~%" name)
             (hash-set! seen name #t))))
     svcs))
  svcs)

(define (check-regressions new-pkgs)
  (let ((profile "/run/current-system/profile"))
    (when (file-exists? profile)
      (let* ((manifest      (profile-manifest profile))
             (current-names (map manifest-entry-name (manifest-entries manifest)))
             (new-set       (make-hash-table)))
        (for-each (lambda (n) (hash-set! new-set n #t)) (map package-name new-pkgs))
        (for-each
         (lambda (name)
           (unless (hash-ref new-set name #f)
             (format (current-error-port)
                     "WARNING: '~a' was in the running system but is missing from the new scan~%" name)))
         current-names)))))

;; ── Assembly ──────────────────────────────────────────────────────────────────
(define (substrate-ref substrate sym)
  (or (hash-ref substrate sym #f)
      (error (format #f "constitution: missing substrate binding '~a' — define-public it in a substrate module" sym))))

(define all-packages #f)
(define all-services #f)
(define substrate #f)
(call-with-values
  (lambda () (scan-manifold manifold-root all-scm-files))
  (lambda (pkgs svcs sub)
    (check-regressions pkgs)
    (set! all-packages (dedupe-packages pkgs))
    (set! all-services (dedupe-services svcs))
    (set! substrate sub)))

(define-public os
  (let* ((blank  (operating-system))
         (fields (record-type-fields (record-type-descriptor <operating-system>)))
         (based  (let loop ((fields fields) (os blank))
                   (if (null? fields)
                       os
                       (let* ((field (car fields))
                              (sym   (record-field-name field))
                              (val   (hash-ref substrate sym #f)))
                         (loop (cdr fields)
                               (if val
                                   ((record-field-modifier field) os val)
                                   os))))))
         (all-svcs (append (substrate-ref substrate 'kernel-system-services)
                           all-services
                           (list (service guix-home-service-type
                                          (list (list "aoeu"
                                                      (substrate-ref substrate 'mappingos-home-environment)))))))
         (deduped-svcs (let ((seen (make-hash-table)))
                         (let loop ((lst all-svcs) (acc '()))
                           (if (null? lst)
                               (reverse acc)
                               (let* ((svc  (car lst))
                                      (kind (service-kind svc)))
                                 (if (hash-ref seen kind #f)
                                     (loop (cdr lst) acc)
                                     (begin
                                       (hash-set! seen kind #t)
                                       (loop (cdr lst) (cons svc acc))))))))))
    (operating-system
      (inherit based)
      (packages all-packages)
      (services deduped-svcs)))))
