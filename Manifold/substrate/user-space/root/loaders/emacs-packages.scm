(define-module (substrate user-space root loaders emacs-packages)
  #:use-module (substrate user-space root editors emacs-packages emacs-leaf)
  #:use-module (substrate user-space root editors emacs-packages emacs-denote)
  #:use-module (substrate user-space root editors emacs-packages emacs-auctex)
  #:use-module (substrate user-space root editors emacs-packages emacs-cdlatex)
  #:use-module (substrate user-space root editors emacs-packages emacs-org-modern)
  #:use-module (substrate user-space root editors emacs-packages emacs-org-modern-indent)
  #:use-module (substrate user-space root editors emacs-packages emacs-org-tidy)
  #:use-module (substrate user-space root editors emacs-packages emacs-dash)
  #:use-module (substrate user-space root editors emacs-packages emacs-org)
  #:use-module (substrate user-space root editors emacs-packages emacs-compat)
  #:export (root-emacs-packages))

(define-public root-emacs-packages
  (list emacs-leaf
        emacs-denote
        emacs-auctex
        emacs-cdlatex
        emacs-org
        emacs-org-modern
        emacs-org-modern-indent
        emacs-org-tidy
        emacs-compat
	))
