(define-module (substrate user-space root editors emacs-packages emacs-svg-lib)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-svg-lib))

(define-public emacs-svg-lib
  (let ((commit "f62279a4edbe2f67faf573d09b211653acea9668"))
    (package
      (name "emacs-svg-lib")
      (version "0.3")
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/rougier/svg-lib")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "09l1hkif5pc4yskr1by5s4kmgx0k0ximk5p5fvcdvryrh687gwm4"))))
      (build-system emacs-build-system)
      (arguments (list #:tests? #f))
      (home-page "https://github.com/rougier/svg-lib")
      (synopsis "Emacs SVG library for creating tags, icons and bars")
      (description "Small Emacs library to create and display SVG objects.")
      (license license:gpl3+))))