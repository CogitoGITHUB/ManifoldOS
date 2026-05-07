(define-module (substrate user-space root editors emacs-packages emacs-corfu)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages texinfo)
  #:use-module (substrate user-space root editors emacs-packages emacs-compat)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-corfu))

(define-public emacs-corfu
  (package
    (name "emacs-corfu")
    (version "2.9")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/minad/corfu")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0hb9ycq6v28nkx0qbczfks4hz26g1d1bdb48ylxb9pd26irxb9pm"))))
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
          (add-after (quote unpack) (quote makeinfo)
            (lambda _ (emacs-makeinfo))))))
    (native-inputs (list texinfo))
    (propagated-inputs (list emacs-compat))
    (home-page "https://github.com/minad/corfu")
    (synopsis "Completion overlay region function")
    (description "Corfu enhances the default completion in region function
with a completion overlay.")
    (license license:gpl3+)))