(define-module (substrate user-space root editors emacs-packages emacs-yasnippet)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-yasnippet))

(define-public emacs-yasnippet
  (let ((commit "dd570a6b22364212fff9769cbf4376bdbd7a63c5"))
    (package
      (name "emacs-yasnippet")
      (version "0.14.3")
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/joaotavora/yasnippet")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1s7zsdw83v5v7alsnzzrrr3m177qnm7x4hr8w7f84a4lamd0h6s3"))))
      (build-system emacs-build-system)
      (arguments
       (list
        #:tests? #f
        #:phases
        #~(modify-phases %standard-phases
            (add-before 'check 'set-home
              (lambda _
                (setenv "HOME" (getcwd)))))))
      (home-page "https://github.com/joaotavora/yasnippet")
      (synopsis "Yet another snippet extension for Emacs")
      (description "YASnippet is a template system for Emacs. It allows you
to type an abbreviation and automatically expand it into function templates.")
      (license license:gpl3+))))
