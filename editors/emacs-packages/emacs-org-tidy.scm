(define-module (substrate user-space root editors emacs-packages emacs-org-tidy)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system emacs)
  #:use-module (substrate user-space root editors emacs-packages emacs-dash)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-org-tidy))

(define-public emacs-org-tidy
  (package
    (name "emacs-org-tidy")
    (version "0.1")
    (source
     (origin
       (method url-fetch)
       (uri "https://github.com/jxq0/org-tidy/archive/refs/heads/main.tar.gz")
       (sha256
        (base32 "0jm4anl64xqv43zq8hh9q14ka040az7hbwvg2qcp5ics3sdjknfx"))))
    (build-system emacs-build-system)
    (arguments '(#:tests? #f))
    (propagated-inputs (list emacs-dash))
    (home-page "https://github.com/jxq0/org-tidy")
    (synopsis "Automatically tidy Org mode property drawers")
    (description "Org-tidy is an Emacs minor mode to automatically tidy
org-mode property drawers. After org-tidy mode is turned on, property
drawers are hidden and a symbol is appended after the headline.")
    (license license:gpl3+)))
