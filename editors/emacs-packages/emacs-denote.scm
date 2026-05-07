(define-module (substrate user-space root editors emacs-packages emacs-denote)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages texinfo)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-denote))

(define-public emacs-denote
  (package
    (name "emacs-denote")
    (version "4.1.3")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/protesilaos/denote")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "157hmdxndj26987lscwiygsz2w9fdllw5imk7m15qla30yp9q5f4"))))
    (build-system emacs-build-system)
    (arguments '(#:tests? #f))
    (native-inputs (list texinfo))
    (home-page "https://protesilaos.com/emacs/denote/")
    (synopsis "Simple notes for Emacs")
    (description "Denote is a simple note-taking tool for Emacs.  It is based
on the idea that notes should follow a predictable and descriptive file-naming
scheme.  Denote basically streamlines the creation of such files while
providing facilities to link between them.")
    (license license:gpl3+)))
