(define-module (substrate user-space root editors emacs-packages emacs-compat)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-compat))

(define-public emacs-compat
  (package
    (name "emacs-compat")
    (version "30.1.0.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/emacs-compat/compat")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "04kzp2m5qs1jyrj50yjz5l8azciyqkgkf4cbifcz4gngvxvgxdm4"))))
    (build-system emacs-build-system)
    (home-page "https://elpa.gnu.org/packages/compat.html")
    (synopsis "Emacs Lisp compatibility library")
    (description "Compatibility library for Emacs Lisp.")
    (license license:gpl3+)))
