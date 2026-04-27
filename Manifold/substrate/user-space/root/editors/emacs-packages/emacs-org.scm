(define-module (substrate user-space root editors emacs-packages emacs-org)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages base)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-org))

(define-public emacs-org
  (package
    (name "emacs-org")
    (version "9.7.39")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://git.savannah.gnu.org/git/emacs/org-mode")
             (commit (string-append "release_" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1bq4k37iax3zyhr6g335g9p9ja316yhj9a2jbh2d1mfw3rykfy2b"))))
    (build-system emacs-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (replace 'expand-load-path
            (lambda args
              (with-directory-excursion "lisp"
                (apply (assoc-ref %standard-phases 'expand-load-path) args))))
          (add-after 'expand-load-path 'bootstrap
            (lambda _
              (invoke "make" "autoloads")))
          (replace 'build
            (lambda args
              (with-directory-excursion "lisp"
                (apply (assoc-ref %standard-phases 'build) args))))
          (replace 'install
            (lambda _
              (let ((elpa (elpa-directory #$output))
                    (info (string-append #$output "/share/info")))
                (substitute* "local.mk"
                  (("^lispdir.*") (string-append "lispdir = " elpa))
                  (("^datadir.*") (string-append "datadir = " elpa "/etc"))
                  (("^infodir.*") (string-append "infodir = " info)))
                (invoke "make" "install"
                        (string-append "ORGVERSION=" #$version)))))
          (add-after 'install 'install-org-news
            (lambda _
              (install-file "etc/ORG-NEWS"
                            (string-append #$output "/share/doc/"
                                           #$name "-" #$version)))))))
    (native-inputs (list texinfo tzdata))
    (home-page "https://orgmode.org/")
    (synopsis "Outline-based notes management and organizer")
    (description "Org is an Emacs mode for keeping notes, maintaining TODO
lists, and project planning with a fast and effective lightweight markup
language.")
    (license license:gpl3+)))
