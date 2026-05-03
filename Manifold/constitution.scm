(define-module (constitution)
  #:use-module (ice-9 ftw)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-11)
  #:use-module (guix build utils)
  #:use-module (gnu system)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services desktop)
  #:use-module (gnu services guix)
  #:use-module (guix packages)
  #:use-module (substrate kernel-space kernel-space)
  #:use-module (substrate user-space root users users)
  #:use-module (substrate user-space home home))


;; ── Scanner ───────────────────────────────────────────────────────────────────

(define manifold-root
  (or (and=> (current-filename) dirname)
      "/ManifoldOS/Manifold"))

(define (collect-from-module mod)
  (fold (lambda (sym acc)
          (let ((val (false-if-exception (module-ref mod sym))))
            (cond
              ;; Named list exports: *-packages or *-services
              ((and val (list? val)
                    (string-suffix? "-packages" (symbol->string sym))
                    (every package? val))
               (cons (append val (car acc)) (cdr acc)))
              ((and val (list? val)
                    (string-suffix? "-services" (symbol->string sym))
                    (not (string-prefix? "home-" (symbol->string sym)))
                    (every service? val))
               (cons (car acc) (append val (cdr acc))))
              ;; Bare single package — skip kernel packages
              ((and val (package? val)
                    (not (string=? "linux" (package-name val))))
               (cons (cons val (car acc)) (cdr acc)))
              ;; Bare single service — skip, must be in a *-services list
              (else acc))))
        (cons '() '())
        (module-map (lambda (sym _) sym) mod)))

(define (file->module-name file root)
  ;; Convert /ManifoldOS/Manifold/substrate/foo/bar.scm -> (substrate foo bar)
  (let* ((relative (substring file (+ 1 (string-length root))))
         (no-ext   (substring relative 0 (- (string-length relative) 4)))
         (parts    (string-split no-ext #\/)))
    (map string->symbol parts)))

(define (scan-manifold root)
  (let loop ((files (find-files root "\\.scm$"))
             (packages '())
             (services '()))
    (cond
      ((null? files)
       (values packages services))
      ((string-suffix? ".scm~" (car files))
       (loop (cdr files) packages services))
      (else
       (let* ((mod-name (file->module-name (car files) root))
              (mod      (false-if-exception (resolve-module mod-name)))
              (result   (if mod (collect-from-module mod) (cons '() '())))
              (pkgs     (car result))
              (svcs     (cdr result)))
         (loop (cdr files)
               (append packages pkgs)
               (append services svcs)))))))

(define (dedupe-packages pkgs)
  (delete-duplicates pkgs eq?))

(define (dedupe-services svcs)
  (delete-duplicates svcs
                     (lambda (a b)
                       (eq? (service-kind a) (service-kind b)))))

(define all-packages '())
(define all-services '())

(let-values (((pkgs svcs) (scan-manifold manifold-root)))
  (set! all-packages (dedupe-packages pkgs))
  (set! all-services (dedupe-services svcs)))


;; ── OS Declaration ────────────────────────────────────────────────────────────

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
    (services (append
               (delete-duplicates
                (append kernel-system-services
                        all-services
                        (list (service guix-home-service-type
                                       (list (list "aoeu" mappingos-home-environment)))))
                (lambda (a b)
                  (eq? (service-kind a) (service-kind b))))
               %base-services))))
