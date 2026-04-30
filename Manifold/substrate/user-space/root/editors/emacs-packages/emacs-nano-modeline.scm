(define-module (substrate user-space root editors emacs-packages emacs-nano-modeline)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-nano-modeline))

(define-public emacs-nano-modeline
  (let ((commit "04676d57a1e602123a593836745a744d1b2028fb"))
    (package
      (name "emacs-nano-modeline")
      (version "1.1.0")
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/rougier/nano-modeline")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1q10zd8aiq5xm7p4sm1mrfmw0sfgfyznyk4lvh2rl9pqh9kh700a"))))
      (build-system emacs-build-system)
      (arguments (list #:tests? #f))
      (home-page "https://github.com/rougier/nano-modeline")
      (synopsis "Emacs minor mode controlling mode line")
      (description "Nano modeline is a minor mode for Emacs that modifies
the mode line.")
      (license license:gpl3+))))