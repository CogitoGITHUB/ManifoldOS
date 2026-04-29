(define-module (substrate user-space root editors emacs-packages emacs-embark)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages texinfo)
  #:use-module (substrate user-space root editors emacs-packages emacs-consult)
  #:use-module (substrate user-space root editors emacs-packages avy)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-embark))

(define-public emacs-embark
  (package
    (name "emacs-embark")
    (version "1.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/oantolin/embark")
             (commit version)))
       (sha256
        (base32 "1y97kibzz36wrzcjv997qp5pliikda0dhsm9461pin3q5gv8y6kq"))
       (file-name (git-file-name name version))))
    (build-system emacs-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (add-before (quote install) (quote makeinfo)
            (lambda _ (emacs-makeinfo))))))
    (native-inputs (list texinfo))
    (propagated-inputs (list emacs-avy emacs-consult))
    (home-page "https://github.com/oantolin/embark")
    (synopsis "Emacs mini-buffer actions rooted in keymaps")
    (description "This package provides a sort of right-click contextual menu
for Emacs offering relevant actions to use on a target determined by context.")
    (license license:gpl3+)))