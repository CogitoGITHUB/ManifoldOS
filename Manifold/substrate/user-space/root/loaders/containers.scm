(define-module (shapes containers containers)
  #:use-module (gnu system)
  #:use-module (substrate substrate)
  #:use-module (shapes containers podman)
  #:export (container-packages container-services container-os))

(define-public container-packages
  podman-packages)

(define-public container-services
  (list podman-service))

(define-public container-os
  (operating-system
    (inherit os)
    (packages (append (operating-system-packages os)
                      container-packages))
    (services (append (operating-system-services os)
                      container-services))))
