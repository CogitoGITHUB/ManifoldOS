(define sysctl-tuning-service
  (simple-service 'network-sysctl-tuning
    sysctl-service-type
    '(("net.core.netdev_budget"       . "600")
      ("net.core.netdev_budget_usecs" . "8000")
      ("net.ipv4.udp_rmem_min"        . "8192")
      ("net.ipv4.udp_wmem_min"        . "8192"))))

(define kernel-system-services
  (list elogind-service
        uinput-group-service
        kernel-modules
        sysctl-tuning-service))

(define kernel-system-packages kernel-firmware)
