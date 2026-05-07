(define-module (substrate user-space root editors emacs-packages emacs-meow)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-meow))

(define-public emacs-meow
  (package
    (name "emacs-meow")
    (version "1.5.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/meow-edit/meow")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1gfvqzp00vwbhxgp2wdcm4waba0r280dx0qbb7vpzyx93bqiplig"))))
    (build-system emacs-build-system)
    (home-page "https://github.com/meow-edit/meow")
    (synopsis "Yet another modal editing on Emacs")
    (description "Meow is yet another modal editing mode for Emacs.  It aims
to blend modal editing into Emacs with minimum interface with its original
key-bindings, avoiding most if not all the hassle introduced by key-binding
conflicts.")
    (license license:gpl3+)))
