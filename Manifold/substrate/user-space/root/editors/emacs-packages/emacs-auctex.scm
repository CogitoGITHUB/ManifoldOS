(define-module (substrate user-space root editors emacs-packages emacs-auctex)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages perl)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-auctex))

(define-public emacs-auctex
  (package
    (name "emacs-auctex")
    (version "14.1.2")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://elpa.gnu.org/packages/"
                           "auctex-" version ".tar"))
       (sha256
        (base32 "0dp95siam576ji9ccznd7abclrxv14xbcmbkqaawf73q2rmfjwip"))))
    (build-system emacs-build-system)
    (arguments
     (list
      #:emacs emacs
      #:include #~(cons* "^images/" "^latex/" %default-include)
      #:exclude #~(cons "^latex/README" %default-exclude)
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'configure
            (lambda* (#:key inputs #:allow-other-keys)
              (emacs-substitute-variables "preview.el"
                ("preview-gs-command"
                 (search-input-file inputs "/bin/gs")))
              (substitute* "preview.el"
                (("\"pdf2dsc ")
                 (let ((pdf2dsc (search-input-file inputs "/bin/pdf2dsc")))
                   (string-append "\"" pdf2dsc " "))))))
          (add-after 'install 'install-doc
            (lambda _
              (let ((doc-dir (string-append #$output "/share/doc/"
                                            #$name "-" #$version)))
                (with-directory-excursion "doc"
                  (setenv "HOME" (getenv "TMPDIR"))
                  (invoke "pdftex" "tex-ref")
                  (install-file "tex-ref.pdf" doc-dir))))))))
    (native-inputs
     (list perl (texlive-local-tree)))
    (inputs
     (list ghostscript))
    (home-page "https://www.gnu.org/software/auctex/")
    (synopsis "Integrated environment for TeX")
    (description "AUCTeX is a comprehensive customizable integrated environment
for writing input files for TeX, LaTeX, ConTeXt, Texinfo, and docTeX using
Emacs or XEmacs.")
    (license license:gpl3+)))
