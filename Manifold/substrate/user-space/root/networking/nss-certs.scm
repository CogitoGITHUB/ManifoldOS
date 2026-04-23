(define-module (substrate user-space root networking nss-certs)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (rnrs io ports)
  #:use-module (srfi srfi-26)
  #:use-module (gnu packages tls)
  #:use-module (substrate user-space root networking nss)
  #:export (nss-certs certdata2pem))

(define-public certdata2pem
  (let ((revision "1")
        (commit "4c576f350f44186d439179f63d5be19f710a73f5"))
    (package
      (name "certdata2pem")
      (version "0.0.0")
      (source (origin
                (method url-fetch)
                (uri (string-append
                      "https://raw.githubusercontent.com/sabotage-linux/sabotage/"
                      commit "/KEEP/certdata2pem.c"))
                (sha256
                 (base32
                   "1rywp29q4l1cs2baplkbcravxqs4kw2cys4yifhfznbc210pskq6"))))
      (build-system gnu-build-system)
      (arguments
       (list #:phases
             #~(modify-phases %standard-phases
                 (delete 'configure)
                 (add-before 'build 'fix-extension
                   (lambda _
                     (substitute* "certdata2pem.c"
                       (("\\.crt") ".pem"))))
                 (replace 'build
                   (lambda _
                     (invoke "gcc" "certdata2pem.c" "-o" "certdata2pem")))
                 (delete 'check)
                 (replace 'install
                   (lambda* (#:key outputs #:allow-other-keys)
                     (let ((out (assoc-ref outputs "out")))
                       (install-file "certdata2pem" (string-append out "/bin"))))))))
      (home-page "https://github.com/sabotage-linux/")
      (synopsis "Utility to split TLS certificates data into multiple PEM files")
      (description "This is a C version of the certdata2pem Python utility.")
      (license license:isc))))

(define-public nss-certs
  (package
    (inherit nss)
    (name "nss-certs")
    (build-system gnu-build-system)
    (outputs '("out"))
    (native-inputs (list certdata2pem openssl))
    (inputs '())
    (propagated-inputs '())
    (arguments
     (list #:modules '((guix build gnu-build-system)
                       (guix build utils)
                       (rnrs io ports)
                       (srfi srfi-26))
           #:phases
           #~(modify-phases %standard-phases
               (delete 'configure)
               (delete 'build)
               (delete 'check)
               (add-after 'unpack 'install
                 (lambda _
                   (let ((certsdir (string-append #$output "/etc/ssl/certs/")))
                     (with-directory-excursion "nss/lib/ckfw/builtins/"
                       (unless (file-exists? "blacklist.txt")
                         (call-with-output-file "blacklist.txt" (lambda (_) #f)))
                       (invoke "certdata2pem")
                       (for-each (cut install-file <> certsdir)
                         (find-files "." "\\.pem$")))
                     (invoke "openssl" "rehash" certsdir)))))))
    (synopsis "CA certificates from Mozilla")
    (description "This package provides certificates for Certification Authorities.")
    (home-page "https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS")
    (license license:mpl2.0)))