(define-module (substrate user-space root loaders guix)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (guix gexp)
  #:use-module (substrate user-space root guix guix-profile)
  #:export (guix-services))

(define-public guix-services
  (list (extra-special-file "/etc/guix/channels.scm" guix-channels-file)
        (extra-special-file "/root/.config/guix/channels.scm" guix-channels-file)
        (extra-special-file "/home/aoeu/.config/guix/channels.scm" guix-channels-file)))
