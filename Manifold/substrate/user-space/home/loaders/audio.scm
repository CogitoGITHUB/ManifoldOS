(define-module (substrate user-space home loaders audio)
  #:use-module (substrate user-space home audio pipewire)
  #:re-export (home-pipewire-service home-dbus-service)
  #:export (home-audio-services))

(define-public home-audio-services
  (list home-dbus-service home-pipewire-service))