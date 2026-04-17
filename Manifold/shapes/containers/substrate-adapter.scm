(define-module (forms containers core-container)
  #:use-module (gnu services)
  #:use-module (gnu services containers)
  #:export (container-service))

(define-public container-service
  (service rootless-podman-service-type))
