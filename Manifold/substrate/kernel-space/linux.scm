(define-module (substrate kernel-space linux)
  #:use-module (gnu packages linux)
  #:use-module (gnu services)
  #:use-module (gnu services linux)
  #:use-module (gnu system linux-initrd)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages python)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages xz)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages bison)
  #:export (kernel kernel-arguments kernel-modules kernel-initrd kernel-firmware custom-kernel))

(define (kernel-config)
  (local-file "/ManifoldOS/current-kernel-config"))

(define-public custom-kernel
  (package
    (name "linux-manifold")
    (version "6.18.22")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/torvalds/linux")
             (commit "v6.18.22")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0v9c8h7j6k5l4m3n2b1x0c9v8u7t6s5r4q3w2e1d0p9o8i7h6g5f4e3d2"))))
    (build-system gnu-build-system)
    (inputs
     (list kmod perl python-3 pkg-config xz bc elfutils flex bison))
    (arguments
     `(,#:configure-flags
       (list (string-append "KCONFIG_CONFIG=" #+(kernel-config))
             "ARCH=x86_64"
             "CROSS_COMPILE=x86_64-linux-gnu-")
       ,#:phases
       (modify-phases %standard-phases
         (replace 'build
           (lambda _
             (invoke "make" "-j" (number->string (parallel-job-count)) "bzImage" "modules")))
         (replace 'install
           (lambda _
             (invoke "make" "INSTALL_MOD_PATH=/tmp/modules" "modules_install")
             (invoke "cp" "arch/x86_64/boot/bzImage" "/boot/vmlinuz-6.18.22-manifold"))))))
    (supported-systems '("x86_64-linux"))
    (home-page "https://www.kernel.org/")
    (synopsis "Linux kernel")
    (description "The Linux kernel")
    (license license:gpl2)))

(define-public kernel linux-libre)
(define-public kernel-initrd base-initrd)
(define-public kernel-firmware (list))
(define-public kernel-arguments '())
(define-public kernel-modules
  (service kernel-module-loader-service-type
           (list "uinput")))