(define-module (constitution)
  #:use-module (gnu system)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services guix)
  #:use-module (substrate substrate)
  #:use-module (shapes shapes))

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
  (packages (append root-system-packages container-packages))
  (services (append kernel-system-services
                    root-system-services
                    container-services
                    (list (service guix-home-service-type
                                   (list (list "aoeu" mappingos-home-environment)))
                          (simple-service 'podman-subids
                                          etc-service-type
                                          container-etc-files)))))
