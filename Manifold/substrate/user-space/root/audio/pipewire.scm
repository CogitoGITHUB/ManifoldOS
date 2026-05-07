(define-public root-audio-packages
  (list mpd rmpc cava wireplumber pipewire))

(define-public root-audio-services
  (list mpd-service
        alsa-service
        (service pipewire-service-type)))
