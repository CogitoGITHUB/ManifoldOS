(define-module (substrate user-space home home)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu home services sound)
  #:use-module (gnu packages emacs)
  #:use-module (guix gexp)
  #:use-module (substrate user-space home loaders audio)
  #:export (mappingos-home-environment))

(define emacs-shepherd-service
  (shepherd-service
    (provision '(emacs-daemon))
    (documentation "Emacs daemon — Control Center")
    (start #~(make-forkexec-constructor
              (list #$(file-append emacs-no-x "/bin/emacs") "--fg-daemon")))
    (stop #~(make-kill-destructor))
    (auto-start? #t)))

(define-public mappingos-home-environment
  (home-environment
    (packages (list (@ (gnu packages pulseaudio) pulsemixer)))
    (services
     (append
      home-audio-services
      (list (simple-service 'emacs-daemon
                            home-shepherd-service-type
                            (list emacs-shepherd-service))
            (simple-service 'home-packages
                            home-profile-service-type
                            (list)))))))
