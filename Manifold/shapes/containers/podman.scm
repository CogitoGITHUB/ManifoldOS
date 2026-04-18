(define-module (shapes containers podman)
  #:use-module (guix gexp)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (gnu services containers)
  #:use-module ((gnu packages containers) #:select (podman))
  #:export (podman-packages podman-service podman-etc-files))

(define-public podman-packages
  (list podman))

(define-public podman-service
  (service rootless-podman-service-type
           (rootless-podman-configuration
            (podman podman))))

(define-public podman-etc-files
  `(("subuid" ,(plain-file "subuid" "aoeu:100000:65536\n"))
    ("subgid" ,(plain-file "subgid" "aoeu:100000:65536\n"))))
