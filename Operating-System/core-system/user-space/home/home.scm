(define-module (core-system user-space home home)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services guix)
  #:use-module (gnu home services xdg)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu services guix)
  #:use-module (guix gexp)
  ;; All home loaders disabled for channel build
  #:export (mappingos-home-environment))

(define-public mappingos-home-environment
  (home-environment
    (services
     (list
      (simple-service 'wireplumber-config
                      home-xdg-configuration-files-service-type
                      (list (list "wireplumber/wireplumber.conf.d/disable-logind.conf"
                                 (plain-file "disable-logind.conf"
                                             "wireplumber.profiles = {
  main = {
    monitor.bluez.seat-monitoring = disabled
  }
}"))))))))