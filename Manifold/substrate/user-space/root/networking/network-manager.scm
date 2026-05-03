(define-module (substrate user-space root networking network-manager)
  #:use-module ((gnu packages gnome) #:prefix gnome:)
  #:use-module (gnu services)
  #:use-module (gnu services networking)
  #:use-module (gnu services desktop)
  #:export (network-manager networking-manager-services))

(define-public network-manager gnome:network-manager)

(define-public networking-manager-services
  (list (service network-manager-service-type
                 (network-manager-configuration
                  (shepherd-requirement '(wpa-supplicant))))
        (service wpa-supplicant-service-type)))
