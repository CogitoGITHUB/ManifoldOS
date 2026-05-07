(define-module (substrate user-space root editors emacs-packages emacs-nerd-icons)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-nerd-icons emacs-nerd-icons-dired))

(define-public emacs-nerd-icons
  (let ((commit "d41902fe68a94fcf4394f25a89ba2d510bec4461")
        (revision "2"))
    (package
      (name "emacs-nerd-icons")
      (version (git-version "0.1.0" revision commit))
      (home-page "https://github.com/rainstormstudio/nerd-icons.el")
      (source
       (origin
         (method git-fetch)
         (uri (git-reference (url home-page) (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "08j8sw8ik55pd0jw1nar90016nnd5bicd5mhrm202xzigqmx2bxl"))))
      (build-system emacs-build-system)
      (arguments
       (list
        #:include #~(cons "^data\\/" %default-include)
        #:tests? #f
        #:phases
        #~(modify-phases %standard-phases
            (add-after (quote unpack) (quote disable-font-installer)
              (lambda _
                (emacs-batch-edit-file "nerd-icons.el"
                  (quote (progn
                    (search-forward "(defun nerd-icons-install-fonts")
                    (beginning-of-line)
                    (kill-sexp)
                    (insert "(defun nerd-icons-install-fonts (&optional pfx)
  (interactive \"P\")
  (message \"Install font-nerd-symbols via guix.\"))")
                    (basic-save-buffer)))))))))
      (synopsis "Library for easily using nerd font icons inside Emacs")
      (description "Nerd-icons works on both GUI and terminal.")
      (license license:gpl3+))))

(define-public emacs-nerd-icons-dired
  (let ((commit "adf9a2bb5f3f13be7a676923639337f3fcc5d8c3")
        (revision "0"))
    (package
      (name "emacs-nerd-icons-dired")
      (version (git-version "0.0.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/rainstormstudio/nerd-icons-dired")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0x1xmwlfjgbk5kk4bxvgz4ykwwgiwmdbzhgsw49kpzz678a3qzrp"))))
      (build-system emacs-build-system)
      (arguments (list #:tests? #f))
      (propagated-inputs (list emacs-nerd-icons))
      (home-page "https://github.com/rainstormstudio/nerd-icons-dired")
      (synopsis "Icons for Dired via Nerd Icons")
      (description "Adds icons to Dired using nerd-icons.")
      (license license:gpl3+))))