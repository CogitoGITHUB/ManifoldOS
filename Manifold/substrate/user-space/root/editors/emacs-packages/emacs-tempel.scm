(define-module (substrate user-space root editors emacs-packages emacs-tempel)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages texinfo)
  #:use-module (substrate user-space root editors emacs-packages emacs-compat)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-tempel))

(define-public emacs-tempel
  (package
    (name "emacs-tempel")
    (version "1.11")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/minad/tempel")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "08d1qd5k63y24sm082bkvyj48svggbryczz42kwjv6nyw9m3kwid"))))
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
    (home-page "https://github.com/minad/tempel")
    (synopsis "Simple templates for Emacs")
    (description "Tempel is a tiny template package for Emacs using the
syntax of the Emacs Tempo library.")
    (license license:gpl3+)))