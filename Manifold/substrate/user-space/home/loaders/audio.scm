;; Audio home services
(define-module (substrate user-space home loaders audio)
  #:use-module (gnu home services shepherd)
  #:export (home-audio-services))

(define-public home-audio-services
  (list home-dbus-service))