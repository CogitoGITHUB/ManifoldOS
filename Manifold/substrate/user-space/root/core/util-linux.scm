(define-module (substrate user-space root core util-linux)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix gexp)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages file)
  #:use-module (gnu packages base)
  #:export (util-linux))

(define-public util-linux
  (package
    (name "util-linux")
    (version "2.40.4")
    (source (origin
              (method url-fetch)
              (uri (string-append "mirror://kernel.org/linux/utils/"
                                  "util-linux/v" (version-major+minor version) "/"
                                  "util-linux-" version ".tar.xz"))
              (sha256
               (base32
                "0ygvflcr7v7x2rmr9h5mi07yx00i9368ggf3znd8bs847drsy7aw"))
              (modules '((guix build utils)))
              (snippet
               '(begin
                  (substitute* "configure"
                    (("build_nologin=yes") "build_nologin=no")
                    (("build_logger=yes") "build_logger=no")
                    (("build_kill=yes") "build_kill=no"))))))
    (build-system gnu-build-system)
    (outputs '("out"
               "lib"
               "static"))
    (arguments
     (list #:configure-flags
           #~(list "--disable-use-tty-group"
                   (string-append
                    "--enable-fs-paths-default="
                    "/run/setuid-programs"
                    ":/run/current-system/profile/sbin")
                   "--disable-makeinstall-chown"
                   "--localstatedir=/var"
                   (string-append "--localedir=" #$output:lib
                                  "/share/locale")
                   (string-append "--with-bashcompletiondir=" #$output
                                  "/etc/bash_completion.d")
                   #$@(if (target-hurd32?)
                          '("--disable-year2038")
                          '()))
           #:tests? #f
           #:phases
           #~(modify-phases %standard-phases
               (add-before 'configure 'patch-build-scripts
                 (lambda _
                   (substitute* "configure"
                     (("usrlib_execdir='\\$\\{exec_prefix\\}'\\$libdir")
                      "usrlib_execdir=$libdir"))))
               (add-before 'build 'set-umount-file-name
                 (lambda _
                   (substitute* "sys-utils/eject.c"
                     (("\"/bin/umount\"")
                      (string-append "\"" #$output "/bin/umount\"")))))
               (add-before 'check 'pre-check
                 (lambda* (#:key native-inputs inputs #:allow-other-keys)
                   (let ((services (search-input-file (or native-inputs inputs)
                                                      "etc/services")))
                     (substitute* "tests/ts/misc/mcookie"
                       (("/etc/services")
                        services))
                     (substitute* "tests/helpers/test_mkfds.c"
                       (("/etc/fstab")
                        (which "sh")))
                     (substitute* "tests/helpers/test_enosys.c"
                       (("/bin/false")
                        (which "false"))))))
               (add-before 'check 'disable-setarch-test
                 (lambda _
                   (substitute* "tests/ts/misc/setarch"
                     (("ts_init_subtest.*" all)
                      (string-append
                       all "\n"
                       "ts_skip \"setarch tests are unreliable under QEMU\"")))))
               (add-before 'check 'disable-lsns-test
                 (lambda _
                   (delete-file "tests/ts/lsns/ioctl_ns")))
               #$@(if (target-ppc32?)
                      #~((add-before 'check 'disable-enosys-ioctl
                           (lambda _
                             (substitute* "tests/ts/misc/enosys"
                               (("ts_init_subtest ioctl")
                                (string-append
                                 "ts_init_subtest ioctl\n\n"
                                 "ts_skip \"unexplained failure on powerpc\"\n"))))))
                      #~())
               (add-after 'install 'move-static-libraries
                 (lambda _
                   (let ((lib    #$output:lib)
                         (static #$output:static))
                     (mkdir-p (string-append static "/lib"))
                     (with-directory-excursion lib
                       (for-each (lambda (file)
                                   (rename-file file
                                                (string-append static "/"
                                                               file)))
                                 (find-files "lib" "\\.a$"))
                       (substitute* (find-files "lib" "\\.la$")
                         (("old_library=.*") "old_library=''\n"))))))
               (add-after 'install 'adjust-pkg-config-files
                 (lambda _
                   (substitute* (find-files (string-append #$output:lib
                                                           "/lib/pkgconfig")
                                            "\\.pc$")
                     (("^(exec_)?prefix=.*") "")))))))
    (inputs
     (list file
           ncurses
           sqlite
           zlib))
    (native-inputs
     (list net-base
           perl
           pkg-config))
    (home-page "https://www.kernel.org/pub/linux/utils/util-linux/")
    (synopsis "Collection of utilities for the Linux kernel")
    (description "Util-linux is a diverse collection of Linux kernel
utilities.  It provides dmesg and includes tools for working with file systems,
block devices, UUIDs, TTYs, and many other tools.")
    (properties '((upstream-name . "util-linux")))
    (license (list license:gpl3+ license:gpl2+ license:gpl2 license:lgpl2.0+
                   license:bsd-4 license:public-domain))))
