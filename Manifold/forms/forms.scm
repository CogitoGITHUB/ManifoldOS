(define-module (forms forms)
  #:use-module (forms osint osint)
  #:use-module (forms web-master web-master)
  #:re-export (quien osint-packages
               caddy caddy-service-type web-master-packages web-master-services)
  #:export (forms-system-packages forms-system-services))

(define-public forms-system-packages
  (append osint-packages
          web-master-packages))

(define-public forms-system-services
  (append web-master-services))
