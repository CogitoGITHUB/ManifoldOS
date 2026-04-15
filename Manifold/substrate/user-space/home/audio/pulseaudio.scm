;; PulseAudio autostart service
(define-module (substrate user-space home audio pulseaudio)
  #:use-module (gnu home services shepherd)
  #:use-module (guix gexp)
  #:export (home-pulseaudio-service))

(define-public home-pulseaudio-service
  (service
   home-shepherd-service-type
   (shepherd-service
    (documentation "Restart PulseAudio to ensure ALSA cards are detected")
    (start #~(lambda _
               (system* "pulseaudio" "-k")
               (sleep 1)
               (system* "pulseaudio" "--start")))
    (stop #~#f)
    (provision '(pulseaudio-restart))
    (respawn? #f))))
