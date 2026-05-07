(define-immutable-record-type <keyboard-layout>
  (%keyboard-layout name variant model options)
  keyboard-layout?
  (name    keyboard-layout-name)
  (variant keyboard-layout-variant)
  (model   keyboard-layout-model)
  (options keyboard-layout-options))

(define* (keyboard-layout name #:optional variant
                          #:key model (options '()))
  (%keyboard-layout name variant model options))

(define-public keyboard-layout
  (keyboard-layout "us" "dvorak"
    #:options '("caps:backspace")))
