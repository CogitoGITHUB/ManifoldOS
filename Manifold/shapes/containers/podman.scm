(define-module (shapes containers podman)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (gnu services containers)
  #:use-module ((gnu packages containers) #:select (podman))
  #:export (podman-packages podman-service))

(define-public podman-packages
  (list podman))

(define-public podman-service
  (service rootless-podman-service-type
          (rootless-podman-configuration
           (podman podman))))