(define-module (substrate user-space root loaders keyboard)
  #:use-module (substrate user-space root keyboard keyd)
  #:use-module (substrate user-space root keyboard kanata)
  #:re-export (keyd kanata)
  #:export (root-keyboard-packages root-keyboard-services))

(define-public root-keyboard-packages
  (list keyd kanata))

(define-public root-keyboard-services
  (list kanata-service))