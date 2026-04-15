;; Audio packages and services
(define-module (substrate user-space root loaders audio)
  #:use-module (substrate user-space root audio music mpd)
  #:use-module (substrate user-space root audio music rmpc)
  #:use-module (substrate user-space root audio music cava)
  #:use-module (substrate user-space root audio alsa)
  #:use-module (substrate user-space root audio wireplumber)
  #:export (root-audio-packages root-audio-services))

(define-public root-audio-packages
  (list mpd rmpc cava wireplumber (@ (gnu packages linux) pipewire)))

(define-public root-audio-services
  (list mpd-service alsa-service))