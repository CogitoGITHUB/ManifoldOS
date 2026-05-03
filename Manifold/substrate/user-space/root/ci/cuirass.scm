(define-module (substrate user-space root ci cuirass)
  #:use-module (guix gexp)
  #:use-module (guix channels)
  #:use-module (gnu packages databases)
  #:use-module (gnu services)
  #:use-module (gnu services cuirass)
  #:use-module (gnu services databases)
  #:export (cuirass-service root-ci-services))

(define %cuirass-specs
  #~(list (specification
            (name "manifoldos")
            (build '(systems "system.scm"))
            (channels (list (channel
                              (name 'manifold)
                              (url "file:///ManifoldOS")))))))

(define-public cuirass-service
  (service cuirass-service-type
           (cuirass-configuration
            (specifications %cuirass-specs))))

(define-public root-ci-services
  (list (service postgresql-service-type
                 (postgresql-configuration
                  (postgresql postgresql)))
        cuirass-service))
