(define-module (substrate user-space home loaders emacs)
  #:use-module (substrate user-space home emacs daemon)
  #:export (home-emacs-services))

(define-public home-emacs-services
  home-emacs-daemon-service)
