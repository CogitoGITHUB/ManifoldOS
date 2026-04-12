(define-module (forms containers containers)
  #:use-module (gnu services)
  #:use-module (forms containers core-container)
  #:use-module (forms containers devsecops)
  #:re-export (container-service devsecops-service)
  #:export (all-container-services))

(define-public all-container-services
  (list container-service
        devsecops-service))
