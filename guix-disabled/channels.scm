(define-module (substrate user-space root guix channels)
  #:use-module (guix channels)
  #:export (system-channels))

(define-public system-channels
  (list
    (channel
      (name 'guix)
      (url "https://git.guix.gnu.org/guix.git")
      (branch "master")
      (introduction
        (make-channel-introduction
         "9edb3f696b1a3b6545b61c8c9e89e3a4ab5d9e2b"
         (openpgp-fingerprint
          "BBB4 1592 5AE8 14BF A9EB  40A8 B3C8 3834 4746 9AF5"))))))
