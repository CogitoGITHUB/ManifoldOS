#|
ManifoldOS — Constitution
The supreme law of the system. Every package, service, and structural OS
binding lives inside this repository — nothing is fetched from external
channels. Drop a .scm file anywhere under the Manifold and it is part of
the system on the next reconfigure. No wiring, no boilerplate, no exceptions.
Module files are self-contained: define-public your packages and services,
the constitution scans, injects the prelude, enforces sovereignty, and
assembles the final OS declaration automatically.
Substrate symbols (kernel, file-systems, host-name, …) are picked up by
name — define-public the symbol in any file and it fills the OS field.
The prelude is built dynamically from the imports found across all module
files — add or remove a #:use-module in any file and it propagates
automatically. No external prelude.scm needed.
constitution:no-warn
|#
(define-module (constitution)
  #:declarative? #f
  #:use-module (ice-9 popen)
  #:use-module (ice-9 rdelim)
  #:use-module (ice-9 textual-ports)
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

;; ── Module Registry ───────────────────────────────────────────────────────────
(define (module-tree-set! name mod)
  (let ((root (resolve-module '() #f #f #:ensure #t)))
    (nested-define-module! root name mod)))

;; ── File Collection ───────────────────────────────────────────────────────────
(define (collect-scm-files root)
  (let* ((port  (open-input-pipe
                 (string-append "find " root
                                " -name '*.scm' ! -name '.*' | sort")))
         (files (let loop ((line (read-line port)) (acc '()))
                  (if (eof-object? line)
                      (begin (close-pipe port) (reverse acc))
                      (loop (read-line port)
                            (if (string-null? line) acc (cons line acc)))))))
    files))

;; ── Module Name Derivation ────────────────────────────────────────────────────
(define (file->module-name file root)
  (let* ((relative (substring file (+ 1 (string-length root))))
         (no-ext   (substring relative 0 (- (string-length relative) 4))))
    (map string->symbol (string-split no-ext #\/))))

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
     (filter-map normalise-mod-spec (cdr form)))
    ((and (pair? form) (eq? (car form) 'define-module))
     (let loop ((tail (cddr form)) (acc '()))
       (cond
         ((null? tail) acc)
         ((and (eq? (car tail) '#:use-module) (pair? (cdr tail)))
          (let ((spec (normalise-mod-spec (cadr tail))))
            (loop (cddr tail) (if spec (cons spec acc) acc))))
         (else (loop (cdr tail) acc)))))
    (else '())))

(define (normalise-mod-spec spec)
  (cond
    ((and (list? spec) (every symbol? spec)) spec)
    ((and (pair? spec) (list? (car spec)) (every symbol? (car spec))) (car spec))
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
         (all-specs (append-map extract-use-modules-from-file files))
         (unique    (delete-duplicates all-specs equal?))
         ;; Prelude is manifold-internal only — strip constitution, prelude,
         ;; and every module that is not itself a manifold file.
         ;; External Guix/system modules are loaded exclusively by the
         ;; constitution's own define-module and arrive via inject-prelude!
         ;; carrying the constitution's already-resolved interfaces.
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
    ;; Pull the constitution's own interfaces into the prelude so every
    ;; manifold module sees all Guix/system symbols without importing them.
    (for-each (lambda (iface)
                (module-use! mod iface))
              (module-uses (current-module)))
    ;; Now layer in each manifold module's own interface.
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
      (let loop ((n 10))
        (if (zero? n) #f
            (let ((line (read-line port)))
              (if (eof-object? line) #f
                  (if (string-contains line "constitution:no-warn") #t
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
;; Access the unexported RTD directly from (gnu system) via @@.
;; record-type-fields returns the list of field name symbols.
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
                   (every package? val))
              (for-each assert-local-source! val)
              (set! packages (append val packages))
              (set! matched (+ matched 1)))
             ((and val (list? val)
                   (string-suffix? "-services" (symbol->string sym))
                   (not (string-prefix? "home-" (symbol->string sym)))
                   (every service? val))
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
                   ;; Drop define-module entirely — no #:use-module from any
                   ;; substrate file is permitted. All symbols arrive via the
                   ;; prelude which is seeded exclusively from the constitution.
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
    (let loop ((files files) (packages '()) (services '()) (n 0))
      (if (null? files)
          (begin
            (format (current-error-port)
                    "constitution: scanned ~a files — ~a packages, ~a services, ~a substrate bindings~%"
                    n (length packages) (length services)
                    (hash-count (const #t) substrate))
            (values (reverse packages) (reverse services) substrate))
          (let* ((file     (car files))
                 (no-warn? (file-no-warn? file))
                 (mod-name (file->module-name file root))
                 (skip?    (member mod-name '((constitution) (prelude)))))
            (if skip?
                (loop (cdr files) packages services n)
                (let* ((mod    (load-module-file file mod-name))
                       (result (begin (assert-sovereign! mod file)
                                      (collect-from-module mod no-warn? substrate)))
                       (pkgs   (car result))
                       (svcs   (cdr result)))
                  (loop (cdr files)
                        (append pkgs packages)
                        (append svcs services)
                        (+ n 1)))))))))

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
  (delete-duplicates pkgs eq?))

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

(define-values (all-packages all-services substrate)
  (let-values (((pkgs svcs sub) (scan-manifold manifold-root all-scm-files)))
    (check-regressions pkgs)
    (values (dedupe-packages pkgs)
            (dedupe-services svcs)
            sub)))

(define-public os
  (let* ((blank  (operating-system))
         (fields (record-type-fields (record-type-descriptor <operating-system>)))
         (based  (fold (lambda (field os)
                         (let* ((sym (record-field-name field))
                                (val (hash-ref substrate sym #f)))
                           (if val
                               ((record-field-modifier field) os val)
                               os)))
                       blank
                       fields)))
    (operating-system
      (inherit based)
      (packages all-packages)
      (services (delete-duplicates
                 (append (substrate-ref substrate 'kernel-system-services)
                         all-services
                         (list (service guix-home-service-type
                                        (list (list "aoeu"
                                                    (substrate-ref substrate 'mappingos-home-environment))))))
                 (lambda (a b)
                   (eq? (service-kind a) (service-kind b))))))))
