(define-public network-manager gnome:network-manager)

(define-public networking-manager-services
  (list (service network-manager-service-type
                 (network-manager-configuration
                  (shepherd-requirement '(wpa-supplicant))))
        (service wpa-supplicant-service-type)))
