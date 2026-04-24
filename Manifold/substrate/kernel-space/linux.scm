(define-module (substrate kernel-space linux)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (gnu services)
  #:use-module (gnu services linux)
  #:export (kernel kernel-arguments kernel-modules kernel-initrd kernel-firmware))

(define-public kernel linux)
(define-public kernel-initrd microcode-initrd)
(define-public kernel-firmware (list linux-firmware))
(define-public kernel-arguments '("pci=noaer" "rtw88_core.disable_lps_deep=1"))
(define-public kernel-modules
  (service kernel-module-loader-service-type
           (list "uinput")))
