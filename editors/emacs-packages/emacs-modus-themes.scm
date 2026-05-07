(define-module (substrate user-space root editors emacs-packages emacs-modus-themes)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages texinfo)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-modus-themes))

(define-public emacs-modus-themes
  (package
    (name "emacs-modus-themes")
    (version "5.2.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/protesilaos/modus-themes")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1iqbi71h9xajsw4330157dfs10npfi1z2ads99vr7n5pll7060rc"))))
    (build-system emacs-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'install 'makeinfo
            (lambda _ (emacs-makeinfo))))))
    (native-inputs (list texinfo))
    (home-page "https://protesilaos.com/modus-themes/")
    (synopsis "Accessible themes for Emacs (WCAG AAA standard)")
    (description "The Modus themes are designed for accessible readability.
They conform with the highest standard for color contrast between any given
combination of background and foreground values.")
    (license (list license:gpl3+
                   license:fdl1.3+))))
