(define-module (substrate user-space root editors emacs-packages emacs-denote-explore)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages texinfo)
  #:use-module (substrate user-space root editors emacs-packages emacs-denote)
  #:use-module (substrate user-space root editors emacs-packages emacs-dash)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-denote-explore))

(define-public emacs-denote-explore
  (package
    (name "emacs-denote-explore")
    (version "4.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/pprevos/denote-explore")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "04lc5fw11wixbjdkzbl63g03rdybv6q4mh1dc6c9y322g8qq3r0k"))))
    (build-system emacs-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (add-after (quote unpack) (quote build-info-manual)
            (lambda* (#:key outputs #:allow-other-keys)
              (invoke "emacs"
                      "--batch"
                      "--eval=(require (quote ox-texinfo))"
                      "--eval=(find-file \"denote-explore.org\")"
                      "--eval=(org-texinfo-export-to-info)"))))))
    (native-inputs (list texinfo))
    (propagated-inputs (list emacs-denote emacs-dash))
    (home-page "https://github.com/pprevos/denote-explore")
    (synopsis "Analyse and visualise a collection of Denote notes")
    (description "Provides auxiliary functions to maintain and explore your
collection of Denote files.")
    (license license:gpl3+)))