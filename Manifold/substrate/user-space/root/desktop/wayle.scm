(define-module (substrate user-space root desktop wayle)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module ((substrate user-space root desktop rust-crates) #:select (lookup-cargo-inputs))
  #:use-module (guix build-system cargo)
  
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages linux)
  #:use-module (guix licenses)
  #:export (wayle))

(define-public wayle
  (package
    (name "wayle")
    (version "0.4.1")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/wayle-rs/wayle")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256 (base32 "08m126zgywc82mg8553b5k878lx2lrax8884v7x3ixxk6isg605f"))))
    (build-system cargo-build-system)
    (native-inputs (list clang cmake pkg-config git))
    (arguments
      (list #:install-source? #f))
    (inputs (cons* gtk gtksourceview pulseaudio fftw pipewire eudev
                   (lookup-cargo-inputs 'wayle)))
    (home-page "https://wayle.app")
    (synopsis "Configurable desktop shell for Wayland")
    (description "Wayle is a Wayland desktop shell for Hyprland.")
    (license expat)))
