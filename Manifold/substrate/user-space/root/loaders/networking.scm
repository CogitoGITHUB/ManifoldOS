(define-module (substrate user-space root loaders networking)

  ;; ── Standard library ────────────────────────────────────────────────────────
  #:use-module (gnu packages curl)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages nss)
  #:use-module ((gnu packages version-control) #:select (git))

  ;; ── Services ────────────────────────────────────────────────────────────────
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services desktop)
  #:use-module (gnu services networking)
  #:use-module (gnu services shepherd)
  #:use-module (guix gexp)

  ;; ── Substrate ───────────────────────────────────────────────────────────────
  #:use-module (substrate user-space root networking bluetooth)
  #:use-module (substrate user-space root networking bluetuith)
  #:use-module (substrate user-space root networking gazelle-tui)
  #:use-module (substrate user-space root networking network-manager)
  #:use-module (substrate user-space root networking openssh)
  #:use-module (substrate user-space root networking tailscale)
  #:use-module (substrate user-space root networking tools)
  #:use-module (substrate user-space root networking version-control github-cli)
  #:use-module (substrate user-space root networking version-control lazygit)
  #:use-module (substrate user-space root networking yt-dlp)

  ;; ── Exports ─────────────────────────────────────────────────────────────────
  #:re-export (yt-dlp
               gazelle-tui
               bluez
               bluetuith
               config-tailscaled-service-type
               nmap
               wireshark
               bind-dns
               iperf
               iproute
               nss-certs
               openssh-service)

  #:export (root-networking-packages
            root-networking-services))


;; ── Packages ──────────────────────────────────────────────────────────────────

(define-public root-networking-packages
  (list
   ;; VCS
   git
   github-cli
   lazygit
   ;; Network tools
   curl
   nss-certs
   nmap
   wireshark
   bind-dns
   iperf
   iproute
   ;; Applications
   yt-dlp
   gazelle-tui
   network-manager
   ;; Bluetooth
   bluez
   bluetuith
   ;; VPN
   tailscale))


;; ── Services ──────────────────────────────────────────────────────────────────

(define-public root-networking-services
  (list
   (service network-manager-service-type
            (network-manager-configuration
             (shepherd-requirement '(wpa-supplicant))))
   (service wpa-supplicant-service-type)
   (service bluetooth-service-type
            (bluetooth-configuration
             (auto-enable? #t)))
   (service config-tailscaled-service-type)
   openssh-service))
