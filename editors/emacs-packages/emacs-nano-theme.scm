(define-module (substrate user-space root editors emacs-packages emacs-nano-theme)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-nano-theme))

(define-public emacs-nano-theme
  (let ((commit "ffe414c8af9c673caf8b8b05ba89a229cb9ad48b")
        (revision "0"))
    (package
      (name "emacs-nano-theme")
      (version (git-version "0.3.4" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/rougier/nano-theme")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0wi5snsakpag7lcdndz10x5fxb0yrnignqdx3v4fm5drbk0d7hkr"))))
      (build-system emacs-build-system)
      (arguments (list #:tests? #f))
      (home-page "https://github.com/rougier/nano-theme")
      (synopsis "GNU Emacs / N Λ N O Theme")
      (description "Nano is a consistent theme for GNU Emacs.")
      (license license:gpl3+))))