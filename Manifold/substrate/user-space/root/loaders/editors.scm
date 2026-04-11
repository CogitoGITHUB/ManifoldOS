(define-module (substrate user-space root loaders editors)
  #:use-module (substrate user-space root editors emacs)
  #:use-module (substrate user-space root editors neovim)
  #:use-module (substrate user-space root editors emacs-packages)
  #:re-export (emacs neovim)
  #:export (root-editors-packages))

(define-public root-editors-packages
  (append (list emacs neovim) root-emacs-packages))