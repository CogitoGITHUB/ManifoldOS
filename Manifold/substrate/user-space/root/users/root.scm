(define-module (substrate user-space root users root)
  #:use-module (gnu system accounts)
  #:use-module (gnu packages nushell)
  #:export (root-account))

(define-public root-account
  (user-account
   (name "root")
   (uid 0)
   (group "root")
   (home-directory "/root")
   (shell (file-append nushell "/bin/nu"))))
