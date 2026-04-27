(define-module (substrate user-space root editors emacs-packages emacs-org-modern)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages emacs-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (substrate user-space root editors emacs-packages emacs-compat)
  #:export (emacs-org-modern))

(define-public emacs-org-modern
  (package
    (name "emacs-org-modern")
    (version "1.13")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/minad/org-modern")
             (commit version)))
       (sha256
        (base32 "16i1nwdilhpjlphpbwi8vjfwfb721gm0mm37hjx570wx4sskvg30"))
       (file-name (git-file-name name version))))
    (build-system emacs-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (add-before 'install 'makeinfo
            (lambda _ (emacs-makeinfo))))))
    (propagated-inputs (list emacs-compat))
    (native-inputs (list texinfo))
    (home-page "https://github.com/minad/org-modern")
    (synopsis "Modern Org style")
    (description "Org Modern implements a modern style for your Org buffers
using font locking and text properties. The package styles headlines,
keywords, tables and source blocks.")
    (license license:gpl3+)))
