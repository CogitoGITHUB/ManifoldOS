(define-module (substrate user-space root editors emacs-packages emacs-org-appear)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-org-appear))

(define-public emacs-org-appear
  (package
    (name "emacs-org-appear")
    (version "0.3.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/awth13/org-appear")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1hfhnzhmbxrw4kz977s48x4nbq86vda5dvj00s2ima2i22b8l2z4"))))
    (build-system emacs-build-system)
    (arguments (list #:tests? #f))
    (home-page "https://github.com/awth13/org-appear")
    (synopsis "Make invisible parts of Org fragments appear visible")
    (description "Enables automatic visibility toggling of org-mode elements
depending on cursor position.")
    (license license:expat)))