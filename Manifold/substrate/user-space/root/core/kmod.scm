(define-module (substrate user-space root core kmod)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages pkg-config)
  #:use-module (guix utils)
  #:export (kmod))

(define-public kmod
  (package
    (name "kmod")
    (version "29")
    (source (origin
              (method url-fetch)
              (uri
               (string-append "mirror://kernel.org/linux/utils/kernel/kmod/"
                              "kmod-" version ".tar.xz"))
              (sha256
               (base32
                "0am54mi5rk72g5q7k6l6f36gw3r9vwgjmyna43ywcjhqmakyx00b"))))
    (build-system gnu-build-system)
    (arguments
     (list #:configure-flags #~(list "--with-xz" "--with-zlib" "--with-zstd"
                                     "--disable-test-modules")
           #:phases
           #~(modify-phases %standard-phases
               (add-after 'unpack 'disable-tests
                 (lambda _
                   (substitute* "Makefile.in"
                     (("testsuite/test-modprobe") "")
                     (("testsuite/test-depmod") "")
                     (("testsuite/test-blacklist") ""))))
               (add-after 'install 'install-modprobe&co
                 (lambda _
                   (for-each (lambda (tool)
                               (symlink "kmod"
                                        (string-append #$output "/bin/" tool)))
                             '("insmod" "rmmod" "lsmod" "modprobe"
                               "modinfo" "depmod")))))))
    (native-inputs (list pkg-config zstd))
    (inputs (list xz zlib `(,zstd "lib")))
    (home-page "https://www.kernel.org/")
    (synopsis "Kernel module tools")
    (description "Kmod is a set of tools to handle common tasks with Linux
kernel modules like insert, remove, list, check properties, resolve
dependencies and aliases.")
    (license license:gpl2+)))
