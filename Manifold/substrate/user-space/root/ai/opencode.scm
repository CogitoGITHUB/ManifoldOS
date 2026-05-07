(define-public opencode
  (package
    (name "opencode")
    (version "1.14.17")
    (source
      (origin
        (method url-fetch)
        (uri (string-append
              "https://github.com/anomalyco/opencode/releases/download/v" version
              "/opencode-linux-x64.tar.gz"))
        (sha256 (base32 "1mj1h3ikk1c9mz62d6p4wd905wm6ld9amhck9kp2hn8abr5vgrys"))))
    (build-system trivial-build-system)
    (inputs (list tar gzip patchelf glibc gcc))
    (propagated-inputs (list gcc glibc))
    (arguments
     (list #:modules (quote ((guix build utils)))
           #:builder
       (quasiquote (begin
         (use-modules (guix build utils))
         (let* ((out (assoc-ref %outputs "out"))
                (src (assoc-ref %build-inputs "source"))
                (tar (string-append (assoc-ref %build-inputs "tar") "/bin/tar"))
                (gzip (string-append (assoc-ref %build-inputs "gzip") "/bin"))
                (patchelf (string-append (assoc-ref %build-inputs "patchelf") "/bin/patchelf"))
                (interp (string-append (assoc-ref %build-inputs "glibc") "/lib/ld-linux-x86-64.so.2"))
                (opencode-real (string-append out "/bin/opencode-real"))
                (opencode-bin (string-append out "/bin/opencode")))
           (setenv "PATH" gzip)
           (mkdir-p (string-append out "/bin"))
           (invoke tar "-xzf" src "-C" (string-append out "/bin"))
           (rename-file opencode-bin opencode-real)
           (invoke patchelf "--set-interpreter" interp opencode-real)
            (call-with-output-file opencode-bin
              (lambda (port)
                (let ((gcc (assoc-ref %build-inputs "gcc"))
                      (glibc (assoc-ref %build-inputs "glibc")))
                  (format port "#!/bin/sh\nexport LD_LIBRARY_PATH=~a/lib:~a/lib:$LD_LIBRARY_PATH\nOPENCODE_EXPERIMENTAL_MARKDOWN=0 exec ~a \"$@\"\n" 
                          gcc glibc opencode-real))))
           (chmod opencode-bin #o555))))))
    (home-page "https://opencode.ai")
    (synopsis "The open source AI coding agent")
    (description "OpenCode is an AI coding agent built for the terminal.")
     (license license:expat)))

