(define-module (substrate substrate)
  #:use-module (gnu system)
  #:use-module (gnu services)
  #:use-module (gnu services guix)
  #:use-module (gnu home)
  #:use-module (substrate kernel-space kernel-space)
  #:use-module (substrate user-space root root)
  #:use-module (substrate user-space home home)
  #:export (os)
  #:re-export (host-name system-timezone system-locale kernel kernel-arguments
               kernel-initrd kernel-firmware keyboard-layout
               system-bootloader-configuration file-systems users groups
               sudoers-file setuid-programs root-system-packages
               kernel-system-services root-system-services
               mappingos-home-environment manifoldos-image))

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
    (packages root-system-packages)
    (services (append kernel-system-services
                      root-system-services
                      (list (service guix-home-service-type
                                     (list (list "aoeu" mappingos-home-environment))))))))
