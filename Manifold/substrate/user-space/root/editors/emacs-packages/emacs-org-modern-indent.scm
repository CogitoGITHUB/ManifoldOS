(define-module (substrate user-space root editors emacs-packages emacs-org-modern-indent)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (substrate user-space root editors emacs-packages emacs-compat)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-org-modern-indent))

(define-public emacs-org-modern-indent
  (package
    (name "emacs-org-modern-indent")
    (version "0.5.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/jdtsmith/org-modern-indent")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "09bg1shw06ddlxq678abr9q6g9wfc6b483xi0iwldxk4qbgzgpdj"))))
    (build-system emacs-build-system)
    (arguments (list #:tests? #f))
    (propagated-inputs (list emacs-compat))
    (home-page "https://github.com/jdtsmith/org-modern-indent")
    (synopsis "Modern block styling with Org Indent mode")
    (description "Org Modern mode cannot style various Org blocks properly
when used in conjunction with Org Indent mode. This small package
approximately reproduces the block styling of Org Modern mode when using
Org Indent mode.")
    (license license:gpl3+)))
