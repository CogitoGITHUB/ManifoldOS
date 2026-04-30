(define-module (substrate kernel-space kernel-space)
  #:use-module (substrate kernel-space linux)
  #:use-module (substrate kernel-space keyboard)
  #:use-module (substrate kernel-space bootloader)
  #:use-module (substrate kernel-space filesystem)
  #:use-module (substrate kernel-space hostname)
  #:use-module (substrate kernel-space locale)
  #:use-module (substrate kernel-space elogind)
  #:use-module (substrate kernel-space udev)
  #:use-module (substrate kernel-space kmod)
  #:use-module (gnu services)
  #:use-module (gnu services linux)
  #:use-module (gnu services sysctl)
  #:re-export (kernel kernel-arguments kernel-modules kernel-initrd kernel-firmware
    keyboard-layout system-bootloader-configuration file-systems host-name
    system-locale system-timezone elogind-service udev-rules udev-service-type
    udev-configuration uinput-group-service)
  #:export (kernel-system-services kernel-system-packages))

(define sysctl-tuning-service
  (simple-service 'network-sysctl-tuning
    sysctl-service-type
    '(("net.core.netdev_budget"       . "600")
      ("net.core.netdev_budget_usecs" . "8000")
      ("net.ipv4.udp_rmem_min"        . "8192")
      ("net.ipv4.udp_wmem_min"        . "8192"))))

(define kernel-system-services
  (list elogind-service
        uinput-group-service
        kernel-modules
        sysctl-tuning-service))

(define kernel-system-packages kernel-firmware)
