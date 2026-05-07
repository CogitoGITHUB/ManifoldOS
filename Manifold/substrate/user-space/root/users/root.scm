
(define-public root-account
  (user-account
   (name "root")
   (uid 0)
   (group "root")
   (home-directory "/root")
   (shell (file-append nushell "/bin/nu"))))
