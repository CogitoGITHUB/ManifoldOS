(define-module (core-system kernel-space linux)
  #:use-module (gnu packages linux)
  #:use-module (gnu services)
  #:use-module (gnu services linux)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (srfi srfi-1)
  #:export (kernel kernel-arguments kernel-modules kernel-initrd kernel-firmware))

;; Override linux to build with -j1 (single job) to prevent OOM on 4-core 8GB systems
(define-public kernel
  (package
    (inherit linux)
    (arguments
     (append
      '(#:make-flags '("V=1")  ;; verbose for debugging
        #:parallel-build? #f)  ;; NO parallel build - prevents OOM
      (or (package-arguments linux) '())))))

(define-public kernel-initrd
  (lambda (kernels) #f))

(define-public kernel-firmware (list))
(define-public kernel-arguments '())

(define-public kernel-modules
  (service kernel-module-loader-service-type
           (list "uinput")))
