(define-module (substrate user-space root networking bluetooth)
  #:use-module (gnu packages linux)
  #:use-module (gnu services)
  #:use-module (gnu services desktop)
  #:re-export (bluez)
  #:export (networking-bluetooth-services))

(define-public networking-bluetooth-services
  (list (service bluetooth-service-type
                 (bluetooth-configuration
                  (auto-enable? #t)))))
