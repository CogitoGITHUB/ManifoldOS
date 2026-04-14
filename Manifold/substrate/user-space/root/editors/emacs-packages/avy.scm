(define-module (substrate user-space root editors emacs-packages avy)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-avy))

(define-public emacs-avy
  (package
    (name "emacs-avy")
    (version "0.5.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/abo-abo/avy")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "09qdni1s74i5pv8741szl5g4ynj8fxn0x65qmwa9rmfkbimnc0fs"))))
    (build-system emacs-build-system)
    (arguments '(#:tests? #f))
    (home-page "https://github.com/abo-abo/avy")
    (synopsis "Tree-based completion for Emacs")
    (description "This package provides a generic completion method based on building a balanced decision tree with each candidate being a leaf.")
    (license license:gpl3+)))

