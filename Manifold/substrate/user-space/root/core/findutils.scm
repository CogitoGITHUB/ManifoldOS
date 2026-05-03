(define-module (substrate user-space root core findutils)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (findutils))

(define-public findutils
  (package
    (name "findutils")
    (version "4.10.0")
    (source (origin
              (method url-fetch)
              (uri (string-append "mirror://gnu/findutils/findutils-"
                                  version ".tar.xz"))
              (sha256
               (base32
                "1xd4y24qfsdfp3ndz7d5j49lkhbhpzgr13wrvsmx4izjgyvf11qk"))
              (snippet
               #~(substitute* "locate/Makefile.in"
                   (("mkinstalldirs \\$\\(localstatedir\\).*") "")
                   ((".*\\$\\(MKDIR_P\\).*localstatedir.*") "")))))
    (build-system gnu-build-system)
    (arguments
     `(#:configure-flags (list
                          ,@(if (target-hurd32?)
                                '("--disable-year2038")
                                '())
                          "--localstatedir=/var")
       #:phases (modify-phases %standard-phases
                  (add-before 'check 'adjust-test-shebangs
                    (lambda _
                      (substitute* '("tests/xargs/verbose-quote.sh"
                                     "tests/find/exec-plus-last-file.sh")
                        (("#!/bin/sh")
                         (string-append "#!" (which "sh"))))))
                  ,@(if (system-hurd?)
                        '((add-after 'unpack 'skip-tests
                            (lambda _
                              (substitute*
                                  "gnulib-tests/test-strerror_r.c"
                                (("(^| )main *\\(.*" all)
                                 (string-append all "{\n  exit (77);//"))))))
                        '()))))
    (synopsis "Operating on files matching given criteria")
    (description
     "Findutils supplies the basic file directory searching utilities of the
GNU system.  It consists of two primary searching utilities: \"find\"
recursively searches for files in a directory according to given criteria and
\"locate\" lists files in a database that match a query.  Two auxiliary tools
are included: \"updatedb\" updates the file name database and \"xargs\" may be
used to apply commands with arbitrarily long arguments.")
    (license license:gpl3+)
    (home-page "https://www.gnu.org/software/findutils/")))
