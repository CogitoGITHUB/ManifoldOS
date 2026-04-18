(define-module (substrate user-space root loaders ci)
  #:use-module (substrate user-space root ci cuirass)
  #:re-export (cuirass-service)
  #:export (root-ci-packages
            root-ci-services))

(define-public root-ci-packages
  '())

(define-public root-ci-services
  (list cuirass-service))
