(define-module (substrate user-space root editors emacs-packages emacs-fzf)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages shellutils)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-fzf))

(define-public emacs-fzf
  (let ((commit "641aef33c88df3733f13d559bcb2acc548a4a0c3")
        (revision "1"))
    (package
      (name "emacs-fzf")
      (version (git-version "0.2" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/bling/fzf.el")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1nyvam5jg4gih0x2rvwr4jn97lyhaic3adpdxpdfx682ckj1k2vp"))))
      (build-system emacs-build-system)
      (arguments
       (list
        #:tests? #f
        #:phases
        #~(modify-phases %standard-phases
            (add-after (quote unpack) (quote patch-fzf-executable)
              (lambda* (#:key inputs #:allow-other-keys)
                (emacs-substitute-variables "fzf.el"
                  ("fzf/executable" (search-input-file inputs "/bin/fzf"))))))))
      (inputs (list fzf))
      (home-page "https://github.com/bling/fzf.el")
      (synopsis "Emacs front-end for Fzf finder")
      (description "This package provides an Emacs front-end for Fzf.")
      (license license:gpl3+))))
