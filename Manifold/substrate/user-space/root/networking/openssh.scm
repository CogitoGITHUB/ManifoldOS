(define-module (substrate user-space root networking openssh)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages groff)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages libedit)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages kerberos)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages security)
  #:use-module (gnu packages xorg)
  #:use-module (gnu services)
  #:use-module (gnu services ssh)
  #:use-module (substrate user-space root shell archive zlib)
  #:export (openssh openssh-service networking-openssh-services))

(define openssh
  (package
    (name "openssh")
    (version "10.2p1")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "mirror://openbsd/OpenSSH/portable/"
                           "openssh-" version ".tar.gz"))
       (sha256
        (base32 "1clqyxh6mrbwjg964df0hjwmd361mxnx3nx17wk5jyck3422ri6c"))))
    (build-system gnu-build-system)
    (arguments
     (list
      #:test-target "tests"
      #:parallel-tests? #f
      #:make-flags
      #~(list "REGRESSTMP=\"$${BUILDDIR}/regress\"")
      #:configure-flags
      #~(append
         (list "--sysconfdir=/etc/ssh"
               "--with-default-path=/run/current-system/profile/bin"
               (string-append "--with-kerberos5="
                              #$(this-package-input "mit-krb5")
                              "/bin")
               "--with-libedit")
         (if #$(target-hurd?)
             '()
             (list "--with-pam"
                   "--with-security-key-builtin"))
         (if #$(%current-target-system)
             (list "--disable-strip")
             '()))
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'configure 'set-store-location
            (lambda _
              (substitute* "misc.c"
                (("@STORE_DIRECTORY@")
                 (string-append "\"" (%store-directory) "/\"")))))
          (add-before 'check 'patch-tests
            (lambda _
              (substitute* "regress/test-exec.sh"
                (("/bin/sh") (which "sh")))
              (substitute* (list "Makefile"
                                 "regress/Makefile")
                (("^(tests:.*) t-exec(.*)" all pre post)
                 (string-append pre post)))))
          (replace 'install
            (lambda* (#:key (make-flags '()) #:allow-other-keys)
              (substitute* "Makefile"
                ((".*MKDIR_P.*PRIVSEP_PATH.*") ""))
              (apply invoke "make" "install-nosysconf" make-flags)
              (with-directory-excursion "contrib"
                (chmod "ssh-copy-id" #o555)
                (install-file "ssh-copy-id"
                              (string-append #$output "/bin/"))
                (install-file "ssh-copy-id.1"
                              (string-append #$output "/share/man/man1/"))))))))
    (native-inputs (list groff pkg-config))
    (inputs
     (cons* libedit
            openssl
            mit-krb5
            zlib
            xauth
            (if (target-hurd?)
                '()
                (list linux-pam
                      libfido2))))
    (synopsis "Client and server for the secure shell (ssh) protocol")
    (description
     "The SSH2 protocol implemented in OpenSSH is standardised by the
IETF secsh working group and is specified in several RFCs and drafts.
It is composed of three layered components:

The transport layer provides algorithm negotiation and a key exchange.
The key exchange includes server authentication and results in a
cryptographically secured connection: it provides integrity, confidentiality
and optional compression.

The user authentication layer uses the established connection and relies on
the services provided by the transport layer.  It provides several mechanisms
for user authentication.  These include traditional password authentication
as well as public-key or host-based authentication mechanisms.

The connection layer multiplexes many different concurrent channels over the
authenticated connection and allows tunneling of login sessions and
TCP-forwarding.  It provides a flow control service for these channels.
Additionally, various channel-specific options can be negotiated.")
    (license (license:non-copyleft "file://LICENSE"
                                   "See LICENSE in the distribution."))
    (properties
     '((release-monitoring-url . "https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/")))
    (home-page "https://www.openssh.com/")))

(define-public openssh-service
  (service openssh-service-type
           (openssh-configuration
            (openssh openssh)
            (permit-root-login #t)
            (password-authentication? #t))))

(define-public networking-openssh-services
  (list openssh-service))
