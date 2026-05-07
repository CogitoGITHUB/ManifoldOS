(define-module (substrate user-space root editors emacs-packages emacs-org-modern)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages texinfo)
  #:use-module (substrate user-space root editors emacs-packages emacs-compat)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-org-modern))

(define-public emacs-org-modern
  (package
    (name "emacs-org-modern")
    (version "1.5")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://github.com/minad/org-modern/archive/refs/tags/"
                           version ".tar.gz"))
       (sha256
        (base32 "1bcd69y6ggmsbjs38yihs4w25wky87z9fmldc0k7kbd2qy85m0nw"))))
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
