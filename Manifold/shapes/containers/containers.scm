(define-module (shapes containers containers)
  #:use-module (shapes containers podman)
  #:export (container-packages container-services container-etc-files))

(define-public container-packages
  podman-packages)

(define-public container-services
  (list podman-service))

(define-public container-etc-files
  podman-etc-files)
