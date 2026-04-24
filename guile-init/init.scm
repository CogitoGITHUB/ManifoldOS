;; /ManifoldOS/guile-init/init.scm
;; Suppress Guile/Guix startup hints by silencing common printing functions
(define original-display display)
(define original-newline newline)
(define original-write write)

(define (silent . args) #f)

;; Temporarily override functions used by init scripts
(set! display silent)
(set! newline silent)
(set! write silent)

;; Restore originals immediately after init completes
(call-with-values
(lambda ()
(lambda ()
(set! display original-display)
(set! newline original-newline)
(set! write original-write)))
(lambda (restore) (restore)))
