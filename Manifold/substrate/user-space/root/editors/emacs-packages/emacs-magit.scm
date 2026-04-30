(define-module (substrate user-space root editors emacs-packages emacs-magit)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (substrate user-space root editors emacs-packages emacs-compat)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-magit))


(define-public emacs-magit
  (package
    (name "emacs-magit")
    (version "4.5.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/magit/magit")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "04yxjkv5h3arcj1s0nq9kyh3l1z4c9wml35vb67jvv1h7mslwz55"))))
    (build-system emacs-build-system)
    (arguments
     (list
      #:lisp-directory "lisp"
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (add-after (quote unpack) (quote build-info-manual)
            (lambda _
              (invoke "make" "-C" ".." "info")
              (for-each (lambda (file)
                          (install-file file "../lisp"))
                        (find-files "../docs" "\\.info"))))
          (add-after (quote unpack) (quote patch-version-executables)
            (lambda* (#:key inputs #:allow-other-keys)
              (emacs-substitute-variables "magit.el"
                ("magit-version" #$version))
              (emacs-substitute-variables "magit-git.el"
                ("magit-git-executable"
                 (search-input-file inputs "/bin/git")))
              (emacs-substitute-variables "magit-sequence.el"
                ("magit-perl-executable"
                 (search-input-file inputs "/bin/perl"))))))))
    (native-inputs (list texinfo))
    (inputs (list git perl))
    (propagated-inputs
     (list emacs-compat
           emacs-cond-let
           emacs-llama
           emacs-transient
           emacs-with-editor))
    (home-page "https://magit.vc/")
    (synopsis "Emacs interface for the Git version control system")
    (description "With Magit, you can inspect and modify your Git repositories
with Emacs.")
    (license license:gpl3+)))
