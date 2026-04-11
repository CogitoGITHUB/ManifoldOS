(define-module (substrate user-space root loaders wayland)
  #:use-module (substrate user-space root desktop wayland wl-clipboard)
  #:use-module (substrate user-space root desktop wayland grim)
  #:use-module (substrate user-space root desktop wayland slurp)
  #:use-module (substrate user-space root desktop wayland swaylock)
  #:use-module (substrate user-space root desktop wayland wlogout)
  #:use-module (substrate user-space root desktop wayland grimblast)
  #:use-module (substrate user-space root desktop wayland swappy)
  #:re-export (wl-clipboard grim slurp swaylock wlogout grimblast swappy)
  #:export (root-desktop-wayland-packages))

(define-public root-desktop-wayland-packages
  (list wl-clipboard grim slurp swaylock wlogout grimblast swappy))
