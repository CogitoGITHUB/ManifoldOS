(define-module (forms containers)
  #:use-module (gnu services)
  #:use-module (gnu services containers)
  #:use-module ((gnu packages containers) #:select (podman))
  #:use-module (forms containers core-container)
  #:use-module (forms containers loaders devsecops)
  #:re-export (container-service devsecops-service)
  #:export (all-container-services all-container-packages))

(define-public all-container-packages
  (list podman))

(define-public all-container-services
  (list container-service
        devsecops-service))
