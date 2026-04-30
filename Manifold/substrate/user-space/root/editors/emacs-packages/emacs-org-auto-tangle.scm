(define-module (substrate user-space root editors emacs-packages emacs-org-auto-tangle)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-org-auto-tangle))

(define-public emacs-org-auto-tangle
  (package
    (name "emacs-org-auto-tangle")
    (version "0.7.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/yilkalargaw/org-auto-tangle")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1wv1ih2w4w93pfr0mqpi6fqpsk0170qzhqhr039hblif8bwxmb71"))))
    (build-system emacs-build-system)
    (arguments (list #:tests? #f))
    (propagated-inputs (list emacs-async))
    (home-page "https://github.com/yilkalargaw/org-auto-tangle")
    (synopsis "Automatically tangle code blocks on save")
    (description "Allows automatically tangling code blocks whenever saving
an org-mode file.")
    (license license:bsd-2)))