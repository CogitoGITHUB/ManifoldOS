(define-module (substrate user-space root editors emacs-packages emacs-org-supertag)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-org-supertag))

(define-public emacs-org-supertag
  (package
    (name "emacs-org-supertag")
    (version "5.8.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/yibie/org-supertag/")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1hdag8kxn2zxwac0fq14c741k4pwzkwvjh5ybwsqc7220vqzhmhm"))))
    (build-system emacs-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'appease-byte-compilation
            (lambda _
              (substitute* "supertag-services-capture.el"
                (("\\(lambda \\(t\\) \\(concat \"#\" t\\)\\)")
                 "(lambda (x) (concat \"#\" x))")))))))
    (propagated-inputs
     (list emacs-gptel emacs-ht emacs-posframe))
    (home-page "https://github.com/yibie/org-supertag/")
    (synopsis "Note taking application on top of Org mode")
    (description "This package implements a knowledge manage engine as an
extension to Org mode, upgrading its tagging system.")
    (license license:gpl3+)))
