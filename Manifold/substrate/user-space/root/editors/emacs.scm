(define-module (substrate user-space root editors emacs)
  #:use-module (gnu packages emacs)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu home services)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:re-export (emacs)
  #:export (emacs-daemon-service emacs-shepherd-service))

(define (emacs-shepherd-service config)
  (list (shepherd-service
          (provision '(emacs-daemon))
          (documentation "Emacs daemon")
          (start #~(make-forkexec-constructor
                    (list #$(file-append emacs "/bin/emacs") "--fg-daemon")))
          (stop #~(make-kill-destructor)))))

(define emacs-daemon-service-type
  (service-type
    (name 'emacs-daemon)
    (extensions
      (list (service-extension
              home-shepherd-service-type
              emacs-shepherd-service)))
    (default-value #f)
    (description "Run Emacs as a daemon using Shepherd")))

(define-public emacs-daemon-service
  (service emacs-daemon-service-type))
