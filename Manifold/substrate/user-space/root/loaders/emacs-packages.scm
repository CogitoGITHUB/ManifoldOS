(define-module (substrate user-space root loaders emacs-packages)
  #:use-module (substrate user-space root editors emacs-packages emacs-arei)
  #:use-module (substrate user-space root editors emacs-packages emacs-leaf)
  #:use-module (substrate user-space root editors emacs-packages emacs-denote)
  #:use-module (substrate user-space root editors emacs-packages emacs-auctex)
  #:use-module (substrate user-space root editors emacs-packages emacs-cdlatex)
  #:use-module (substrate user-space root editors emacs-packages emacs-org-modern)
  #:use-module (substrate user-space root editors emacs-packages emacs-org-modern-indent)
  #:use-module (substrate user-space root editors emacs-packages emacs-org-tidy)
  #:use-module (substrate user-space root editors emacs-packages emacs-dash)
  #:use-module (substrate user-space root editors emacs-packages emacs-compat)
  #:use-module (substrate user-space root editors emacs-packages emacs-modus-themes)
  #:use-module (substrate user-space root editors emacs-packages emacs-yasnippet)
  #:use-module (substrate user-space root editors emacs-packages emacs-meow)
  #:use-module (substrate user-space root editors emacs-packages emacs-god-mode)
  #:use-module (substrate user-space root editors emacs-packages emacs-vertico)
  #:use-module (substrate user-space root editors emacs-packages emacs-consult)
  #:use-module (substrate user-space root editors emacs-packages emacs-marginalia)
  #:use-module (substrate user-space root editors emacs-packages emacs-embark)
  #:use-module (substrate user-space root editors emacs-packages emacs-orderless)
  #:use-module (substrate user-space root editors emacs-packages emacs-general)
  #:use-module (substrate user-space root editors emacs-packages emacs-avy)
  #:use-module (substrate user-space root editors emacs-packages emacs-corfu)
  #:use-module (substrate user-space root editors emacs-packages emacs-cape)
  #:use-module (substrate user-space root editors emacs-packages emacs-tempel)
  #:use-module (substrate user-space root editors emacs-packages emacs-wgrep)
  #:use-module (substrate user-space root editors emacs-packages emacs-nerd-icons)
  #:use-module (substrate user-space root editors emacs-packages emacs-svg-lib)
  #:use-module (substrate user-space root editors emacs-packages emacs-nano-modeline)
  #:use-module (substrate user-space root editors emacs-packages emacs-org-appear)
  #:use-module (substrate user-space root editors emacs-packages emacs-org-auto-tangle)
  #:use-module (substrate user-space root editors emacs-packages emacs-denote-explore)
  #:use-module (substrate user-space root editors emacs-packages emacs-fzf)
  #:use-module (substrate user-space root editors emacs-packages emacs-magit)
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
        emacs-dash
        emacs-compat
        emacs-modus-themes
        emacs-god-mode
        emacs-yasnippet
        emacs-meow
        emacs-general
        emacs-vertico
        emacs-consult
        emacs-consult-denote
        emacs-marginalia
        emacs-embark
        emacs-orderless
        emacs-avy
        emacs-corfu
        emacs-cape
        emacs-tempel
        emacs-wgrep
        emacs-nerd-icons
        emacs-nerd-icons-dired
        emacs-svg-lib
        emacs-nano-modeline
        emacs-org-appear
        emacs-org-auto-tangle
        emacs-denote-explore
        emacs-fzf
        emacs-magit))