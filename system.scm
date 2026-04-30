;; SSH SETUP FOR NEW MACHINES (e.g. Termux):
;; 1. Install sshpass: pkg install sshpass
;; 2. Add to Termux usr/etc/bash.bashrc for auto-connect:
;;    if [ -z "$SSH_CONNECTION" ]; then
;;      sshpass -p "PASSWORD" ssh USER@SERVER || echo "Could not connect to server, dropping to local shell..."
;;    fi

(add-to-load-path "/ManifoldOS/Manifold")
(use-modules (constitution))

os
