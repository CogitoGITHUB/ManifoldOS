(define-public system-bootloader-configuration
  (bootloader-configuration
    (bootloader grub-efi-bootloader)
    (targets '("/boot/efi"))
    (keyboard-layout keyboard-layout)))  ; just reference the symbol from keyboard.scm
