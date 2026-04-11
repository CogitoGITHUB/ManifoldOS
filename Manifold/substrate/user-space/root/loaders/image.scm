(define-module (substrate user-space root loaders image)
  #:use-module (substrate user-space root desktop image krita)
  #:re-export (krita)
  #:export (root-desktop-image-packages))

(define-public root-desktop-image-packages
  (list krita))
