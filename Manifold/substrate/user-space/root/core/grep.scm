(define-public grep
  (package
    (name "grep")
    (version "3.11")
    (source (origin
              (method url-fetch)
              (uri (string-append "mirror://gnu/grep/grep-"
                                  version ".tar.xz"))
              (sha256
               (base32
                "1avf4x8skxbqrjp5j2qr9sp5vlf8jkw2i5bdn51fl3cxx3fsxchx"))))
    (build-system gnu-build-system)
    (native-inputs (list perl))
    (inputs (list pcre2))
    (arguments
     (list #:configure-flags #~(list "--enable-perl-regexp")
           #:phases
           #~(modify-phases %standard-phases
               (add-after 'install 'fix-egrep-and-fgrep
                 (lambda* (#:key outputs #:allow-other-keys)
                   (let* ((out (assoc-ref outputs "out"))
                          (bin (string-append out "/bin")))
                     (substitute* (list (string-append bin "/egrep")
                                        (string-append bin "/fgrep"))
                       (("^exec grep")
                        (string-append "exec " bin "/grep"))))))
               #$@(if (target-hurd64?)
                      #~((add-after 'unpack 'patch-sigsegv
                           (lambda _
                             (substitute* "lib/sigsegv.in.h"
                               (("__GNU__") "__XGNU__")))))
                      #~())
               #$@(if (target-hurd32?)
                      #~((add-after 'unpack 'skip-year2038-test
                           (lambda _
                             (substitute* "gnulib-tests/test-year2038.c"
                               (("(^| )main *\\(.*" all)
                                (string-append all "{\n  return 77;//"))))))
                      #~())
               #$@(if (system-hurd?)
                      #~((add-before 'check 'skip-test
                           (lambda _
                             (substitute*
                                 '("tests/hash-collision-perf"
                                   "tests/file")
                               (("^#!.*" all)
                                (string-append all "exit 77;\n"))))))
                      #~())
               #$@(if (system-hurd64?)
                      #~((add-before 'check 'skip-test
                           (lambda _
                             (substitute* "tests/stack-overflow"
                               (("^#!.*" all)
                                (string-append all "exit 77;\n"))))))
                      #~()))))
    (synopsis "Print lines matching a pattern")
    (description
     "grep is a tool for finding text inside files.  Text is found by
matching a pattern provided by the user in one or many files.  The pattern
may be provided as a basic or extended regular expression, or as fixed
strings.  By default, the matching text is simply printed to the screen,
however the output can be greatly customized to include, for example, line
numbers.  GNU grep offers many extensions over the standard utility,
including, for example, recursive directory searching.")
    (license license:gpl3+)
    (home-page "https://www.gnu.org/software/grep/")))
