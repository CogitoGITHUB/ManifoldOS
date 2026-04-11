(define-module (core-system user-space root root)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services guix)
  #:use-module (gnu services ssh)
  #:use-module (gnu services networking)
  #:use-module (gnu services docker)
  #:use-module (gnu services audio)
  #:use-module (gnu services virtualization)
  #:use-module (gnu services mcron)
  #:use-module (gnu services databases)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages admin)
  #:use-module (core-system user-space root services greetd)
  #:use-module (core-system user-space root users users)
  #:use-module (core-system user-space root networking tailscale)
  ;; All loaders disabled for channel build
  #:re-export (users groups sudoers-file setuid-programs)
  #:export (root-system-packages root-system-services))

(define-public root-system-packages
  '())

(define-public root-system-services
  (append
    (list
     (service openssh-service-type)
     (service network-manager-service-type)
     (service wpa-supplicant-service-type)
     (service greetd-service-type
              (greetd-configuration
               (command "Hyprland --config /home/aoeu/.config/lock-screen/config/greeter.hyprland.conf")
               (user "greeter")))
     (service config-tailscaled-service-type))
    (list (service libvirt-service-type)
          (service virtlog-service-type)
          (service mcron-service-type))
    (list (service postgresql-service-type
                   (postgresql-configuration
                    (postgresql postgresql))))
    %base-services))