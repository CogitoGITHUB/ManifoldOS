(define-module (substrate user-space home home)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services guix)
  #:use-module (gnu home services xdg)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu services guix)
  #:use-module (guix gexp)
  #:use-module (substrate user-space root editors emacs)
  #:use-module (substrate user-space home loaders audio)
  #:export (mappingos-home-environment))

(define-public mappingos-home-environment
  (home-environment
    (services
      (append
        home-audio-services
        (list emacs-daemon-service)
        (list
          (simple-service 'home-packages
                          home-profile-service-type
                          (list))
          (simple-service 'wireplumber-config
                          home-xdg-configuration-files-service-type
                          (list (list "wireplumber/wireplumber.conf.d/disable-logind.conf"
                                     (plain-file "disable-logind.conf"
                                                 "wireplumber.profiles = {
   main = {
     monitor.bluez.seat-monitoring = disabled
   }
}"))))))))