(define-module (substrate user-space root editors emacs-packages emacs-consult)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages texinfo)
  #:use-module (substrate user-space root editors emacs-packages emacs-compat)
  #:use-module (substrate user-space root editors emacs-packages emacs-denote)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-consult emacs-consult-denote))

(define-public emacs-consult
  (package
    (name "emacs-consult")
    (version "3.4")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/minad/consult")
             (commit version)))
       (sha256
        (base32 "0la70jnf14aqaa23ym5phamjay4l4fy3vmizplljli63q8jf89qk"))
       (file-name (git-file-name name version))))
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
    (home-page "https://github.com/minad/consult")
    (synopsis "Consulting completing-read")
    (description "This package provides various handy commands based on the
Emacs completion function completing-read.")
    (license license:gpl3+)))

(define-public emacs-consult-denote
  (package
    (name "emacs-consult-denote")
    (version "0.4.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/protesilaos/consult-denote/")
             (commit version)))
       (sha256
        (base32 "0lc16scxbxc79zsxmsb0kf8lkhpz16v3vcyfzm00zl5pmn5yy7x8"))))
    (build-system emacs-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (add-before (quote install) (quote makeinfo)
            (lambda _ (emacs-makeinfo))))))
    (native-inputs (list texinfo))
    (propagated-inputs (list emacs-consult emacs-denote))
    (home-page "https://github.com/protesilaos/consult-denote")
    (synopsis "Consult interface for Denote")
    (description "Consult Denote provides commands to interact with Emacs
Denote using a Completing Read interface.")
    (license license:gpl3+)))