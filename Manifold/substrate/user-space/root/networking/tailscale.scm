(define-module (substrate user-space root networking tailscale)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (gnu packages compression)
  #:use-module (guix gexp)
  #:use-module (guix build-system trivial)
  #:use-module (guix build-system go)
  #:use-module (gnu packages base)
  #:use-module (gnu packages golang)
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

;; (define tailscale-cli-vendor
;;   (origin
;;     (method url-fetch)
;;     (uri "file:///tmp/tailscale-cli/tailscale-cli-vendor.tar.gz")
;;     (sha256 (base32 "1rdjjabg318nwf2da184n6cc6rllymg5smmcmxir9kr22qwvij24"))))
;;
;; (define-public tailscale-cli
;;   (package
;;     (name "tailscale-cli")
;;     (version "0.1.0")
;;     (source
;;       (origin
;;         (method git-fetch)
;;         (uri (git-reference
;;                (url "https://github.com/dimer47/tailscale-cli.git")
;;                (commit "c100ae7dd633753303a9bc617719e698550756eb")))
;;         (file-name (git-file-name name version))
;;         (sha256 (base32 "1gxzava7q7vjj8miy9hhqdcas6bpyvn86fimrgpnqa2bks3y4gl3"))))
;;     (build-system go-build-system)
;;     (arguments
;;       (list
;;         #:import-path "github.com/dimer47/tailscale-cli"
;;         #:install-source? #f
;;         #:phases
;;         #~(modify-phases %standard-phases
;;             (add-after 'unpack 'unpack-vendor
;;               (lambda* (#:key import-path #:allow-other-keys)
;;                 (let ((vendor-tar (assoc-ref %build-inputs "vendor")))
;;                   (with-directory-excursion (string-append "src/" import-path)
;;                     (invoke "tar" "-xzf" vendor-tar)))))
;;             (add-after 'unpack-vendor 'patch-go-mod
;;               (lambda* (#:key import-path #:allow-other-keys)
;;                 (with-directory-excursion (string-append "src/" import-path)
;;                   (substitute* "go.mod"
;;                     (("^go 1\\.25.*") "go 1.24\n")
;;                     (("^toolchain.*\n") "")))))
;;             (replace 'build
;;               (lambda* (#:key import-path outputs #:allow-other-keys)
;;                 (setenv "GOTOOLCHAIN" "local")
;;                 (setenv "GO111MODULE" "on")
;;                 (with-directory-excursion (string-append "src/" import-path)
;;                   (invoke "go" "build"
;;                           "-v" "-trimpath"
;;                           "-mod=vendor"
;;                           "-ldflags=-s -w"
;;                           "-o" (string-append (assoc-ref outputs "out") "/bin/tailscale-cli")
;;                           ".")))))))
;;     (native-inputs
;;       `(("vendor" ,tailscale-cli-vendor)
;;         ("go" ,go)
;;         ("tar" ,tar)))
;;     (home-page "https://github.com/dimer47/tailscale-cli")
;;     (synopsis "CLI for Tailscale API v2")
;;     (description
;;       "A command-line interface tool for the Tailscale API v2 that allows you to
;; manage devices, ACLs, DNS, keys, users, webhooks and more from the terminal.
;; Includes an MCP server (39 tools) for Claude Code and AI assistants.")
;;     (license license:bsd-3)))

(define tailscale-state-dir "/var/lib/tailscale")
(define tailscale-run-dir   "/var/run/tailscale")
(define tailscale-socket    "/var/run/tailscale/tailscaled.sock")

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
                      "--statedir" #$tailscale-state-dir
                      "--socket"   #$tailscale-socket
                      "--port"     "41641"
                      "--verbose"  "1")
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
   (default-value #f)
   (description "Run the Tailscale daemon.")))
