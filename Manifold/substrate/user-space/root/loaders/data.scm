;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (substrate user-space root loaders data)
  #:use-module (substrate user-space root data postgresql)
  #:use-module (substrate user-space root data sqlit)
  #:re-export (postgresql
              python-sqlit-tui)
  #:export (root-data-packages))

(define-public root-data-packages
  (list postgresql python-sqlit-tui))
