(define-module (substrate user-space root editors emacs-packages emacs-marginalia)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages texinfo)
  #:use-module (substrate user-space root editors emacs-packages emacs-compat)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-marginalia))

(define-public emacs-marginalia
  (package
    (name "emacs-marginalia")
    (version "2.10")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/minad/marginalia")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "12gz095kmlj5xvx6709jl388x16724hivnncan9s52yf8rfjnlbm"))))
    (build-system emacs-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (add-before (quote install) (quote makeinfo)
            (lambda _ (emacs-makeinfo))))))
    (native-inputs (list texinfo))
    (propagated-inputs (list emacs-compat))
    (home-page "https://github.com/minad/marginalia")
    (synopsis "Marginalia in the minibuffer completions")
    (description "This package provides Marginalia mode which adds marginalia
to the minibuffer completions.")
    (license license:gpl3+)))