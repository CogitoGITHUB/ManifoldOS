(define-module (substrate user-space root editors emacs-packages emacs-wgrep)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-wgrep))

(define-public emacs-wgrep
  (package
    (name "emacs-wgrep")
    (version "3.0.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/mhayashi1120/Emacs-wgrep")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "16qg5dpg7hms5dmh92ksnjahf6010pw97ggi7sb0mfafd6iwps0a"))))
    (build-system emacs-build-system)
    (arguments (list #:tests? #f))
    (home-page "https://github.com/mhayashi1120/Emacs-wgrep")
    (synopsis "Edit a grep buffer and apply those changes to the files")
    (description "Emacs wgrep allows you to edit a grep buffer and apply
those changes to the file buffer.")
    (license license:gpl3+)))