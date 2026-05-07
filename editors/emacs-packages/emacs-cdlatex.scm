(define-module (substrate user-space root editors emacs-packages emacs-cdlatex)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (substrate user-space root editors emacs-packages emacs-auctex)
  #:export (emacs-cdlatex))

(define-public emacs-cdlatex
  (let ((commit "fac070f0164ac9f5859cb4cccba7d29a65c337f3"))
    (package
      (name "emacs-cdlatex")
      (version "4.18.5")
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cdominik/cdlatex")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1851nf6bghgzh9nbv8x92yzgdc9rl2jiiwqw2kpninr5myk7fh9y"))))
      (build-system emacs-build-system)
      (arguments (list #:tests? #f))
      (propagated-inputs
       (list emacs-auctex))
      (home-page "https://github.com/cdominik/cdlatex")
      (synopsis "Fast Emacs input methods for LaTeX environments and math")
      (description "CDLaTeX is an Emacs minor mode supporting fast insertion
of environment templates and math in LaTeX.  Similar commands are also offered
as part of the AUCTeX package, but CDLaTeX focuses on speediness for inserting
LaTeX constructs.")
      (license license:gpl3+))))
