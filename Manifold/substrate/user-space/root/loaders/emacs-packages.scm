(define-module (substrate user-space root loaders emacs-packages)
  #:use-module (substrate user-space root editors emacs-packages emacs-leaf)
  #:use-module (substrate user-space root editors emacs-packages emacs-denote)
  #:use-module (substrate user-space root editors emacs-packages emacs-auctex)
  #:use-module (substrate user-space root editors emacs-packages emacs-cdlatex)
  #:export (root-emacs-packages))

(define-public root-emacs-packages
  (list emacs-leaf
        emacs-denote
        emacs-auctex
        emacs-cdlatex))
