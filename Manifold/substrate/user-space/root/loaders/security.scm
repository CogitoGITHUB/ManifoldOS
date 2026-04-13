;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (substrate user-space root loaders security)
  #:use-module (substrate user-space root security age)
  #:use-module (substrate user-space root security gnupg)
  #:use-module (substrate user-space root security fail2ban)
  #:use-module (substrate user-space root security sshguard)
  #:re-export (age
               gnupg
               fail2ban
                sshguard)
  #:export (root-security-packages
            root-security-services))

(define-public root-security-packages

(define-public root-security-services
  '())
