(define-module (constitution)
  #:use-module (gnu system)
  #:use-module (gnu services)
  #:use-module (gnu services containers)
  #:use-module (substrate substrate)
  #:use-module (substrate substrate-containerized)
  #:use-module (shapes shapes)
  #:export (manifold-os))

(define manifold-os
  (operating-system
    (inherit os)
    (services (modify-services (operating-system-user-services os)
                (oci-service-type config =>
                                  (oci-configuration
                                    (inherit config)
                                    (containers
                                      (list (oci-container-configuration
                                              (image manifoldos-image))))))))))
