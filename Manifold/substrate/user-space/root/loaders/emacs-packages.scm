(define-module (substrate user-space root loaders emacs-packages)
  #:use-module (substrate user-space root editors emacs-packages emacs-arei)
  #:use-module (substrate user-space root editors emacs-packages emacs-leaf)
  #:use-module (substrate user-space root editors emacs-packages emacs-denote)
  #:use-module (substrate user-space root editors emacs-packages emacs-auctex)
  #:use-module (substrate user-space root editors emacs-packages emacs-cdlatex)
  #:use-module (substrate user-space root editors emacs-packages emacs-org-modern)
  #:use-module (substrate user-space root editors emacs-packages emacs-org-supertag)
  #:use-module (substrate user-space root editors emacs-packages emacs-org-modern-indent)
  #:use-module (substrate user-space root editors emacs-packages emacs-org-tidy)
  #:use-module (substrate user-space root editors emacs-packages emacs-dash)
  #:use-module (substrate user-space root editors emacs-packages emacs-compat)
  #:use-module (substrate user-space root editors emacs-packages emacs-modus-themes)
  #:use-module (substrate user-space root editors emacs-packages emacs-yasnippet)
  #:use-module (substrate user-space root editors emacs-packages emacs-meow)
  #:use-module (substrate user-space root editors emacs-packages emacs-god-mode)
  #:use-module (substrate user-space root editors emacs-packages emacs-general)
  #:export (root-emacs-packages))

(define-public root-emacs-packages
  (list emacs-arei
        emacs-leaf
        emacs-denote
        emacs-auctex
        emacs-cdlatex
        emacs-org-modern
        emacs-org-modern-indent
        emacs-org-tidy
	emacs-org-supertag
        emacs-dash
        emacs-compat
	emacs-modus-themes
	emacs-god-mode
	emacs-yasnippet
        emacs-meow
        emacs-general))
