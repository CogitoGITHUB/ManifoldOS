(define-module (substrate user-space root users users)
  #:use-module (substrate user-space root users aoeu)
  #:use-module (substrate user-space root users root)
  #:use-module (gnu system accounts)
  #:re-export (groups sudoers-file setuid-programs)
  #:export (users))

(define-public users
  (list root-account aoeu-account pulse-account))
