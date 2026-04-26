(define-module (substrate user-space root loaders latex)
  #:use-module (gnu packages)
  #:export (latex-packages))

(define-public latex-packages
  (list
   (specification->package "texlive-scheme-medium")
   (specification->package "texlive-collection-latexrecommended")
   (specification->package "texlive-collection-latexextra")
   (specification->package "texlive-collection-fontsrecommended")
   (specification->package "texlive-collection-fontsextra")
   (specification->package "texlive-collection-mathscience")
   (specification->package "texlive-collection-pictures")
   (specification->package "texlive-collection-binextra")
   (specification->package "texlive-collection-fontutils")
   (specification->package "texlive-collection-xetex")))
