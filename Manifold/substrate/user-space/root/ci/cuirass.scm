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
