(define-module (substrate user-space root editors emacs-packages emacs-orderless)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages texinfo)
  #:use-module (substrate user-space root editors emacs-packages emacs-compat)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-orderless))

(define-public emacs-orderless
  (package
    (name "emacs-orderless")
    (version "1.6")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/oantolin/orderless")
             (commit version)))
       (sha256
        (base32 "1r6sbyz8f3nkq5pr7iq3mm0q2dq3nq28xycf0x6xys7nsq2nink5"))
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
    (propagated-inputs (list emacs-compat))
    (home-page "https://github.com/oantoin/orderless")
    (synopsis "Emacs completion style that matches multiple regexps in any order")
    (description "This package provides an orderless completion style that
divides the pattern into space-separated components, and matches candidates
that match all of the components in any order.")
    (license license:gpl3+)))