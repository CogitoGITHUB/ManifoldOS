(define-module (substrate user-space home home)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services guix)
  #:use-module (gnu home services xdg)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu home services sound)
  #:use-module (gnu services guix)
  #:use-module (guix gexp)
  #:use-module (substrate user-space root editors emacs)
  #:use-module (substrate user-space home loaders audio)
  #:export (mappingos-home-environment))

(define-public mappingos-home-environment
  (home-environment
    (packages (list))
    (services
      (append
       home-audio-services
       (list emacs-daemon-service
             (simple-service 'pulseaudio-restart
                            home-shepherd-service-type
                            (list (shepherd-service
                                   (documentation "Restart PulseAudio and set Bluetooth sink")
                                   (start #~(lambda (proc)
                                              (system* "pulseaudio" "-k")
                                              (sleep 1)
                                              (system* "pulseaudio" "--start")
                                              (sleep 1)
                                              (system* "pactl" "set-default-sink" "bluez_sink.FC_58_FA_C8_10_F5.a2dp_sink")
                                              #t))
                                   (stop #~#f)
                                   (provision '(pulseaudio-restart))
                                   (respawn? #f))))
             (simple-service 'home-packages
                            home-profile-service-type
                            (list)))))))