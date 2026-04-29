(define-module (substrate user-space root editors emacs-packages emacs-vertico)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages texinfo)
  #:use-module (substrate user-space root editors emacs-packages emacs-compat)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-vertico))

(define-public emacs-vertico
  (package
    (name "emacs-vertico")
    (version "2.8")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/minad/vertico")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0kia499sijkmpj5l9r0r3pwc1kjyvbfxc15k85dyfq9dvc4z1drr"))))
    (build-system emacs-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (add-after (quote unpack) (quote move-source-files)
            (lambda _
              (let ((el-files (find-files "./extensions" ".*\\.el$")))
                (for-each (lambda (f)
                            (rename-file f (basename f)))
                          el-files))))
          (add-after (quote move-source-files) (quote makeinfo)
            (lambda _ (emacs-makeinfo))))))
    (native-inputs (list texinfo))
    (propagated-inputs (list emacs-compat))
    (home-page "https://github.com/minad/vertico")
    (synopsis "Vertical interactive completion")
    (description "Vertico provides a minimalistic vertical completion UI
based on Emacs default completion system.")
    (license license:gpl3+)))