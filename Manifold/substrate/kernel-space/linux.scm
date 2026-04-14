(define-module (substrate kernel-space linux)
  #:use-module (gnu packages linux)
  #:use-module (gnu services)
  #:use-module (gnu services linux)
  #:use-module (gnu system linux-initrd)
  #:export (kernel kernel-arguments kernel-modules kernel-initrd kernel-firmware))

(define-public kernel linux)
(define-public kernel-initrd base-initrd)
(define-public kernel-firmware (list))
(define-public kernel-arguments '())
(define-public kernel-modules
  (service kernel-module-loader-service-type
           (list "uinput")))