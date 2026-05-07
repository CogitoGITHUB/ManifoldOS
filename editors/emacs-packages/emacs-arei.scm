(define-module (substrate user-space root editors emacs-packages emacs-arei)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-arei))

(define-public emacs-arei
  (package
    (name "emacs-arei")
    (version "0.9.6")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://git.sr.ht/~abcdw/emacs-arei")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "1m8ic5pcshz2y2maxvbgg70n4k2kgxvj98zisqal15j7djz0hzji"))))
    (build-system emacs-build-system)
    (arguments (list #:tests? #f))
    (propagated-inputs (list emacs-eros emacs-sesman emacs-queue))
    (home-page "https://git.sr.ht/~abcdw/emacs-arei")
    (synopsis "Asynchronous Reliable Extensible IDE")
    (description "Sleek Guile IDE for Emacs.")
    (license license:gpl3+)))
