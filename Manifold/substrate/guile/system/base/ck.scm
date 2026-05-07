(define-syntax ck
  (syntax-rules (quote)
    ((ck () 'v) v)
    ((ck (((op ...) ea ...) . s) 'v)
     (ck-arg s (op ... 'v) ea ...))
    ((ck s (op ea ...))
     (ck-arg s (op) ea ...))))

(define-syntax ck-arg
  (syntax-rules (quote)
    ((ck-arg s (op va ...))
     (op s va ...))
    ((ck-arg s (op ...) 'v ea1 ...)
     (ck-arg s (op ... 'v) ea1 ...))
    ((ck-arg s (op ...) ea ea1 ...)
     (ck (((op ...) ea1 ...) . s) ea))))