(add-to-load-path "/ManifoldOS/Manifold")

(use-modules (substrate substrate) (shapes shapes))

(define base-os os)

(define os
  (operating-system
    (inherit base-os)
    (packages (append (operating-system-packages base-os)
                    container-packages))
    (services (append (operating-system-services base-os)
                    container-services))))