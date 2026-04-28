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
              (list #$(file-append emacs-minimal "/bin/emacs") "--fg-daemon")))
    (stop #~(make-kill-destructor))
    (auto-start? #t)))

(define ares-nrepl-shepherd-service
  (shepherd-service
    (provision '(ares-nrepl))
    (documentation "Guile Ares RS nREPL server for Arei")
    (start #~(make-forkexec-constructor
              (list #$(file-append (@ (gnu packages guile) guile-3.0) "/bin/guile")
                    "-L" #$(file-append (@ (gnu packages guile-xyz) guile-ares-rs)
                                        "/share/guile/site/3.0")
                    "-L" #$(file-append (@ (gnu packages guile-xyz) guile-fibers)
                                        "/share/guile/site/3.0")
                    "-c"
                    "((@ (ares server) run-nrepl-server))")
              #:environment-variables
              (list (string-append "GUILE_LOAD_COMPILED_PATH="
                                   #$(file-append (@ (gnu packages guile-xyz) guile-ares-rs)
                                                  "/lib/guile/3.0/site-ccache")
                                   ":"
                                   #$(file-append (@ (gnu packages guile-xyz) guile-fibers)
                                                  "/lib/guile/3.0/site-ccache")))))
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
            (simple-service 'ares-nrepl
                            home-shepherd-service-type
                            (list ares-nrepl-shepherd-service))
            (simple-service 'home-packages
                            home-profile-service-type
                            (list)))))))
