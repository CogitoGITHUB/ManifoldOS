;; /ManifoldOS/guile-init/init.scm
(when (isatty? (current-input-port))
  (cond
    ((false-if-exception (resolve-interface '(ice-9 readline)))
     => (lambda (m) ((module-ref m 'activate-readline))))
    (else #f))
  (cond
    ((false-if-exception (resolve-interface '(ice-9 colorized)))
     => (lambda (m) ((module-ref m 'activate-colorized))))
    (else #f)))
