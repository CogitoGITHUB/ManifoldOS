(define-module (substrate user-space root guix guix-profile)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:export (guix-channels-file))

(define-public guix-channels-file
  (plain-file "channels.scm"
              "(list (channel
  (name 'manifold)
  (url \"file:///ManifoldOS\")
  (branch \"master\")))"))
