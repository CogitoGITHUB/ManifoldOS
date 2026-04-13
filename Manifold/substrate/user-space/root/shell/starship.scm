(define-module (substrate user-space root shell starship)
  #:use-module (guix packages)
  #:use-module (gnu packages shellutils)
  #:export (starship))

(define-public starship starship)