(define-module (substrate user-space root editors emacs-packages emacs-cape)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages texinfo)
  #:use-module (substrate user-space root editors emacs-packages emacs-compat)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-cape))

(define-public emacs-cape
  (package
    (name "emacs-cape")
    (version "2.6")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/minad/cape")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "18pdm8dlvzjry7xxx3yyka7rmrx94cvwkhwiagxcfprk6yinx21z"))))
    (build-system emacs-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (add-after (quote unpack) (quote makeinfo)
            (lambda _ (emacs-makeinfo))))))
    (native-inputs (list texinfo))
    (propagated-inputs (list emacs-compat))
    (home-page "https://github.com/minad/cape")
    (synopsis "Completion at point extensions for Emacs")
    (description "Cape provides Completion At Point Extensions for use
with Corfu or the default completion UI.")
    (license license:gpl3+)))