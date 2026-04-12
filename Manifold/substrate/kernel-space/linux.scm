(define-module (substrate kernel-space linux)
  #:use-module (gnu packages linux)
  #:use-module (gnu services)
  #:use-module (gnu services linux)
  ;; ;; nongnu kernel disabled - no substitutes, requires nonguix channel
  ;; #:use-module (nongnu packages linux)
  ;; #:use-module (nongnu system linux-initrd)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (srfi srfi-1)
  #:export (kernel kernel-arguments kernel-modules kernel-initrd kernel-firmware))

;; Use standard GNU linux-libre kernel (has substitutes)
(define-public kernel
  (package
    (inherit linux-libre)
    (arguments
     (append
      '(#:make-flags '("V=1")
        #:parallel-build? #f)
      (or (package-arguments linux-libre) '())))))

(define-public kernel-initrd
  (lambda (system . _) #f))

(define-public kernel-firmware (list))
(define-public kernel-arguments '())

(define-public kernel-modules
  (service kernel-module-loader-service-type
           (list "uinput")))
