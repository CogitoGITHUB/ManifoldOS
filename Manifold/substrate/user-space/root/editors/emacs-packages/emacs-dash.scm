(define-module (substrate user-space root editors emacs-packages emacs-dash)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-dash))

(define-public emacs-dash
  (package
    (name "emacs-dash")
    (version "2.20.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/magnars/dash.el")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "092kf61bi6dwl42yng69g3y55ni8afycqbpaqx9wzf8frx9myg6m"))))
    (build-system emacs-build-system)
    (arguments
     (list #:phases
           #~(modify-phases %standard-phases
               (add-after 'unpack 'disable-byte-compile-error-on-warn
                 (lambda _
                   (substitute* "Makefile"
                     (("\\(setq byte-compile-error-on-warn t\\)")
                      "(setq byte-compile-error-on-warn nil)")))))))
    (home-page "https://github.com/magnars/dash.el")
    (synopsis "Modern list library for Emacs")
    (description "This package provides a modern list API library for Emacs.")
    (license license:gpl3+)))
