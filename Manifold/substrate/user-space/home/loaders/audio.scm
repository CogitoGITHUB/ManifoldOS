;; Audio home services
(define-module (substrate user-space home loaders audio)
  #:use-module (substrate user-space home audio pipewire)
  #:export (home-audio-services))

(define-public home-audio-services
  (list home-dbus-service
        home-pipewire-service))
