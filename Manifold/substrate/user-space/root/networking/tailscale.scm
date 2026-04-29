(define-module (substrate user-space root networking tailscale)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (gnu packages compression)
  #:use-module (guix gexp)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages base)
  #:use-module (gnu services)
  #:use-module (gnu services shepherd)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (tailscale config-tailscaled-service-type))

(define-public tailscale
  (package
    (name "tailscale")
    (version "1.96.2")
    (source
      (origin
        (method url-fetch)
        (uri "https://pkgs.tailscale.com/stable/tailscale_1.96.2_amd64.tgz")
        (sha256 (base32 "00blgy5j5x0zp45xvy421mpkg5bdvzf2gnbywil3rnspxhysz8na"))))
    (build-system trivial-build-system)
    (inputs (list tar gzip))
    (arguments
      (list #:modules '((guix build utils))
            #:builder
            #~(begin
                (use-modules (guix build utils))
                (let* ((out  (assoc-ref %outputs "out"))
                       (src  (assoc-ref %build-inputs "source"))
                       (tar  (string-append (assoc-ref %build-inputs "tar") "/bin/tar"))
                       (gzip (string-append (assoc-ref %build-inputs "gzip") "/bin")))
                  (setenv "PATH" gzip)
                  (mkdir-p (string-append out "/bin"))
                  (invoke tar "-xzf" src
                          "--strip-components=1"
                          "-C" (string-append out "/bin")
                          "tailscale_1.96.2_amd64/tailscale"
                          "tailscale_1.96.2_amd64/tailscaled")))))
    (home-page "https://tailscale.com/")
    (synopsis "Tailscale VPN")
    (description "Tailscale is a zero-config VPN.")
    (license license:bsd-3)))

(define tailscale-state-dir "/var/lib/tailscale")
(define tailscale-run-dir   "/var/run/tailscale")
(define tailscale-socket    "/var/run/tailscale/tailscaled.sock")
(define tailscale-state     "/var/lib/tailscale/tailscaled.state")

(define tailscale-activation
  (with-imported-modules '((guix build utils))
    #~(begin
        (use-modules (guix build utils))
        (mkdir-p #$tailscale-state-dir)
        (mkdir-p #$tailscale-run-dir)
        (chmod #$tailscale-state-dir #o700)
        (chmod #$tailscale-run-dir   #o755))))

(define (tailscale-shepherd-service config)
  (let ((tailscaled (file-append tailscale "/bin/tailscaled")))
    (list
     (shepherd-service
      (documentation "Run the Tailscale daemon (tailscaled)")
      (provision '(tailscaled tailscale))
      (requirement '(user-processes networking))
      (start #~(make-forkexec-constructor
                (list #$tailscaled
                      "--state"  #$tailscale-state
                      "--socket" #$tailscale-socket
                      "--port"   "41641")
                #:log-file "/var/log/tailscaled.log"))
      (stop  #~(make-kill-destructor))
      (respawn? #t)))))

(define-public config-tailscaled-service-type
  (service-type
   (name 'config-tailscaled)
   (extensions
    (list
     (service-extension shepherd-root-service-type
                        tailscale-shepherd-service)
     (service-extension activation-service-type
                        (const tailscale-activation))))
   (default-value '())
   (description "Run the Tailscale daemon and create required state directories.")))
