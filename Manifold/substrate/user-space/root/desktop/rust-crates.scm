(define-module (substrate user-space root desktop rust-crates)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system cargo)
  #:use-module (guix licenses)
  #:export (lookup-cargo-inputs))

(define (lookup-cargo-inputs name)
  (case name
    ((wayle) (list rust-adler2-2.0.1
                             rust-ahash-0.8.12
                             rust-aho-corasick-1.1.4
                             rust-allocator-api2-0.2.21
                             rust-android-system-properties-0.1.5
                             rust-anstream-0.6.21
                             rust-anstyle-1.0.13
                             rust-anstyle-parse-0.2.7
                             rust-anstyle-query-1.1.5
                             rust-anstyle-wincon-3.0.11
                             rust-approx-0.5.1
                             rust-arc-swap-1.8.0
                             rust-arrayref-0.3.9
                             rust-arrayvec-0.7.6
                             rust-async-broadcast-0.7.2
                             rust-async-recursion-1.1.1
                             rust-async-stream-0.3.6
                             rust-async-stream-impl-0.3.6
                             rust-async-trait-0.1.89
                             rust-atomic-waker-1.1.2
                             rust-autocfg-1.5.0
                             rust-aws-lc-rs-1.15.3
                             rust-aws-lc-sys-0.36.0
                             rust-base64-0.22.1
                             rust-basic-toml-0.1.10
                             rust-bindgen-0.72.1
                             rust-bitflags-1.3.2
                             rust-bitflags-2.10.0
                             rust-bitvec-1.0.1
                             rust-block-buffer-0.10.4
                             rust-bumpalo-3.19.1
                             rust-by-address-1.2.1
                             rust-bytemuck-1.24.0
                             rust-bytemuck-derive-1.10.2
                             rust-bytes-1.11.0
                             rust-bytesize-2.3.1
                             rust-cairo-rs-0.22.0
                             rust-cairo-sys-rs-0.22.0
                             rust-calloop-0.14.3
                             rust-calloop-wayland-source-0.4.1
                             rust-cc-1.2.53
                             rust-cesu8-1.1.0
                             rust-cexpr-0.6.0
                             rust-cfg-expr-0.20.5
                             rust-cfg-if-1.0.4
                             rust-cfg-aliases-0.2.1
                             rust-chrono-0.4.43
                             rust-clang-sys-1.8.1
                             rust-clap-4.5.54
                             rust-clap-builder-4.5.54
                             rust-clap-complete-4.6.0
                             rust-clap-derive-4.5.49
                             rust-clap-lex-0.7.7
                             rust-cmake-0.1.57
                             rust-codemap-0.1.3
                             rust-colorchoice-1.0.4
                             rust-combine-4.6.7
                             rust-concurrent-queue-2.5.0
                             rust-console-0.16.2
                             rust-core-foundation-0.10.1
                             rust-core-foundation-sys-0.8.7
                             rust-core-maths-0.1.1
                             rust-cpufeatures-0.2.17
                             rust-crc32fast-1.5.0
                             rust-crossbeam-channel-0.5.15
                             rust-crossbeam-utils-0.8.21
                             rust-crypto-common-0.1.7
                             rust-cursor-icon-1.2.0
                             rust-data-url-0.3.2
                             rust-deranged-0.5.5
                             rust-derive-more-2.1.1
                             rust-derive-more-impl-2.1.1
                             rust-digest-0.10.7
                             rust-displaydoc-0.2.5
                             rust-dotenvy-0.15.7
                             rust-downcast-rs-1.2.1
                             rust-dunce-1.0.5
                             rust-dyn-clone-1.0.20
                             rust-either-1.15.0
                             rust-encode-unicode-1.0.0
                             rust-encoding-rs-0.8.35
                             rust-endi-1.1.1
                             rust-enumflags2-0.7.12
                             rust-enumflags2-derive-0.7.12
                             rust-equivalent-1.0.2
                             rust-errno-0.3.14
                             rust-euclid-0.22.13
                             rust-evdev-0.13.2
                             rust-event-listener-5.4.1
                             rust-event-listener-strategy-0.5.4
                             rust-fallible-iterator-0.3.0
                             rust-fallible-streaming-iterator-0.1.9
                             rust-fast-srgb8-1.0.0
                             rust-fastrand-2.3.0
                             rust-fdeflate-0.3.7
                             rust-field-offset-0.3.6
                             rust-find-crate-0.6.3
                             rust-find-msvc-tools-0.1.8
                             rust-flate2-1.1.8
                             rust-float-cmp-0.9.0
                             rust-fluent-0.17.0
                             rust-fluent-bundle-0.16.0
                             rust-fluent-langneg-0.13.1
                             rust-fluent-syntax-0.12.0
                             rust-flume-0.12.0
                             rust-fnv-1.0.7
                             rust-foldhash-0.2.0
                             rust-fontconfig-parser-0.5.8
                             rust-fontdb-0.23.0
                             rust-form-urlencoded-1.2.2
                             rust-fragile-2.1.0
                             rust-fs-extra-1.3.0
                             rust-fsevent-sys-4.1.0
                             rust-funty-2.0.0
                             rust-futures-0.3.32
                             rust-futures-channel-0.3.32
                             rust-futures-core-0.3.32
                             rust-futures-executor-0.3.32
                             rust-futures-io-0.3.32
                             rust-futures-lite-2.6.1
                             rust-futures-macro-0.3.32
                             rust-futures-sink-0.3.32
                             rust-futures-task-0.3.32
                             rust-futures-util-0.3.32
                             rust-gdk-pixbuf-0.22.0
                             rust-gdk-pixbuf-sys-0.22.0
                             rust-gdk4-0.11.2
                             rust-gdk4-sys-0.11.2
                             rust-generic-array-0.14.7
                             rust-getrandom-0.2.17
                             rust-getrandom-0.3.4
                             rust-gio-0.22.6
                             rust-gio-sys-0.22.0
                             rust-gio-unix-0.22.6
                             rust-gio-unix-sys-0.22.0
                             rust-gl-0.14.0
                             rust-gl-generator-0.14.0
                             rust-glib-0.22.7
                             rust-glib-macros-0.22.6
                             rust-glib-sys-0.22.6
                             rust-glob-0.3.3
                             rust-gobject-sys-0.22.6
                             rust-graphene-rs-0.22.0
                             rust-graphene-sys-0.22.0
                             rust-grass-0.13.4
                             rust-grass-compiler-0.13.4
                             rust-gsk4-0.11.1
                             rust-gsk4-sys-0.11.1
                             rust-gtk4-0.11.3
                             rust-gtk4-layer-shell-0.8.0
                             rust-gtk4-layer-shell-sys-0.6.0
                             rust-gtk4-macros-0.11.0
                             rust-gtk4-sys-0.11.3
                             rust-hashbrown-0.14.5
                             rust-hashbrown-0.16.1
                             rust-hashlink-0.11.0
                             rust-heck-0.5.0
                             rust-hermit-abi-0.3.9
                             rust-hermit-abi-0.5.2
                             rust-hex-0.4.3
                             rust-http-1.4.0
                             rust-http-body-1.0.1
                             rust-http-body-util-0.1.3
                             rust-httparse-1.10.1
                             rust-hyper-1.8.1
                             rust-hyper-rustls-0.27.7
                             rust-hyper-util-0.1.19
                             rust-i18n-config-0.4.8
                             rust-i18n-embed-0.16.0
                             rust-i18n-embed-fl-0.10.0
                             rust-i18n-embed-impl-0.8.4
                             rust-iana-time-zone-0.1.64
                             rust-iana-time-zone-haiku-0.1.2
                             rust-icu-collections-2.1.1
                             rust-icu-locale-core-2.1.1
                             rust-icu-normalizer-2.1.1
                             rust-icu-normalizer-data-2.1.1
                             rust-icu-properties-2.1.2
                             rust-icu-properties-data-2.1.2
                             rust-icu-provider-2.1.1
                             rust-idna-1.1.0
                             rust-idna-adapter-1.2.1
                             rust-imagesize-0.14.0
                             rust-indexmap-2.13.0
                             rust-indicatif-0.18.3
                             rust-inotify-0.11.0
                             rust-inotify-sys-0.1.5
                             rust-intl-memoizer-0.5.3
                             rust-intl-pluralrules-7.0.2
                             rust-inventory-0.3.21
                             rust-io-lifetimes-1.0.11
                             rust-ipnet-2.11.0
                             rust-iri-string-0.7.10
                             rust-is-terminal-polyfill-1.70.2
                             rust-itertools-0.13.0
                             rust-itoa-1.0.17
                             rust-jni-0.21.1
                             rust-jni-sys-0.3.0
                             rust-jobserver-0.1.34
                             rust-js-sys-0.3.85
                             rust-khronos-api-3.1.0
                             rust-kqueue-1.1.1
                             rust-kqueue-sys-1.0.4
                             rust-kurbo-0.13.0
                             rust-lasso-0.7.3
                             rust-lazy-static-1.5.0
                             rust-libc-0.2.186
                             rust-libloading-0.8.9
                             rust-libm-0.2.15
                             rust-libpulse-binding-2.30.1
                             rust-libpulse-sys-1.23.0
                             rust-libsqlite3-sys-0.36.0
                             rust-libudev-sys-0.1.4
                             rust-linux-raw-sys-0.11.0
                             rust-litemap-0.8.1
                             rust-lock-api-0.4.14
                             rust-log-0.4.29
                             rust-lru-slab-0.1.2
                             rust-matchers-0.2.0
                             rust-memchr-2.8.0
                             rust-memmap2-0.9.9
                             rust-memoffset-0.9.1
                             rust-mime-0.3.17
                             rust-minijinja-2.15.1
                             rust-minimal-lexical-0.2.1
                             rust-miniz-oxide-0.8.9
                             rust-mio-1.2.0
                             rust-niri-ipc-25.11.0
                             rust-nix-0.29.0
                             rust-nix-0.30.1
                             rust-nom-7.1.3
                             rust-notify-8.2.0
                             rust-notify-types-2.0.0
                             rust-ntapi-0.4.2
                             rust-nu-ansi-term-0.50.3
                             rust-num-conv-0.1.0
                             rust-num-derive-0.4.2
                             rust-num-traits-0.2.19
                             rust-once-cell-1.21.3
                             rust-once-cell-polyfill-1.70.2
                             rust-openssl-probe-0.2.1
                             rust-ordered-stream-0.2.0
                             rust-owo-colors-4.2.3
                             rust-palette-0.7.6
                             rust-palette-derive-0.7.6
                             rust-pango-0.22.6
                             rust-pango-sys-0.22.0
                             rust-parking-2.2.1
                             rust-parking-lot-0.12.5
                             rust-parking-lot-core-0.9.12
                             rust-percent-encoding-2.3.2
                             rust-phf-0.11.3
                             rust-phf-generator-0.11.3
                             rust-phf-macros-0.11.3
                             rust-phf-shared-0.11.3
                             rust-pico-args-0.5.0
                             rust-pin-project-lite-0.2.16
                             rust-pin-utils-0.1.0
                             rust-pkg-config-0.3.32
                             rust-png-0.18.1
                             rust-polling-3.11.0
                             rust-portable-atomic-1.13.0
                             rust-potential-utf-0.1.4
                             rust-powerfmt-0.2.0
                             rust-ppv-lite86-0.2.21
                             rust-prettyplease-0.2.37
                             rust-proc-macro-crate-3.4.0
                             rust-proc-macro-error-attr2-2.0.0
                             rust-proc-macro-error2-2.0.1
                             rust-proc-macro2-1.0.105
                             rust-quick-xml-0.38.4
                             rust-quinn-0.11.9
                             rust-quinn-proto-0.11.13
                             rust-quinn-udp-0.5.14
                             rust-quote-1.0.43
                             rust-r-efi-5.3.0
                             rust-radium-0.7.0
                             rust-rand-0.8.5
                             rust-rand-0.9.2
                             rust-rand-chacha-0.3.1
                             rust-rand-chacha-0.9.0
                             rust-rand-core-0.6.4
                             rust-rand-core-0.9.5
                             rust-redox-syscall-0.5.18
                             rust-ref-cast-1.0.25
                             rust-ref-cast-impl-1.0.25
                             rust-regex-1.12.3
                             rust-regex-automata-0.4.13
                             rust-regex-syntax-0.8.8
                             rust-relm4-0.11.0
                             rust-relm4-css-0.11.0
                             rust-relm4-macros-0.11.0
                             rust-reqwest-0.13.1
                             rust-ring-0.17.14
                             rust-roxmltree-0.20.0
                             rust-roxmltree-0.21.1
                             rust-rsqlite-vfs-0.1.0
                             rust-rusqlite-0.38.0
                             rust-rust-embed-8.11.0
                             rust-rust-embed-impl-8.11.0
                             rust-rust-embed-utils-8.11.0
                             rust-rustc-hash-2.1.1
                             rust-rustc-version-0.4.1
                             rust-rustix-1.1.3
                             rust-rustls-0.23.36
                             rust-rustls-native-certs-0.8.3
                             rust-rustls-pki-types-1.14.0
                             rust-rustls-platform-verifier-0.6.2
                             rust-rustls-platform-verifier-android-0.1.1
                             rust-rustls-webpki-0.103.9
                             rust-rustversion-1.0.22
                             rust-rustybuzz-0.20.1
                             rust-ryu-1.0.22
                             rust-same-file-1.0.6
                             rust-schannel-0.1.28
                             rust-schemars-1.2.0
                             rust-schemars-derive-1.2.0
                             rust-scopeguard-1.2.0
                             rust-security-framework-3.5.1
                             rust-security-framework-sys-2.15.0
                             rust-self-cell-1.2.2
                             rust-semver-1.0.27
                             rust-serde-1.0.228
                             rust-serde-core-1.0.228
                             rust-serde-derive-1.0.228
                             rust-serde-derive-internals-0.29.1
                             rust-serde-json-1.0.149
                             rust-serde-json-path-0.7.2
                             rust-serde-json-path-core-0.2.2
                             rust-serde-json-path-macros-0.1.6
                             rust-serde-json-path-macros-internal-0.1.2
                             rust-serde-repr-0.1.20
                             rust-serde-spanned-1.1.1
                             rust-serde-urlencoded-0.7.1
                             rust-sha2-0.10.9
                             rust-sharded-slab-0.1.7
                             rust-shlex-1.3.0
                             rust-signal-hook-registry-1.4.8
                             rust-simd-adler32-0.3.8
                             rust-simplecss-0.2.2
                             rust-siphasher-1.0.1
                             rust-slab-0.4.11
                             rust-slotmap-1.1.1
                             rust-smallvec-1.15.1
                             rust-smithay-client-toolkit-0.20.0
                             rust-socket2-0.6.3
                             rust-sourceview5-0.11.0
                             rust-sourceview5-sys-0.11.0
                             rust-spin-0.9.8
                             rust-sqlite-wasm-rs-0.5.2
                             rust-stable-deref-trait-1.2.1
                             rust-strict-num-0.1.1
                             rust-strsim-0.11.1
                             rust-subtle-2.6.1
                             rust-svgtypes-0.16.1
                             rust-syn-2.0.114
                             rust-sync-wrapper-1.0.2
                             rust-synstructure-0.13.2
                             rust-sys-locale-0.3.2
                             rust-sysinfo-0.33.1
                             rust-system-deps-7.0.7
                             rust-tap-1.0.1
                             rust-target-lexicon-0.13.3
                             rust-tempfile-3.24.0
                             rust-thiserror-1.0.69
                             rust-thiserror-2.0.18
                             rust-thiserror-impl-1.0.69
                             rust-thiserror-impl-2.0.18
                             rust-thread-local-1.1.9
                             rust-time-0.3.45
                             rust-time-core-0.1.7
                             rust-time-macros-0.2.25
                             rust-tiny-skia-path-0.11.4
                             rust-tinystr-0.8.2
                             rust-tinyvec-1.10.0
                             rust-tinyvec-macros-0.1.1
                             rust-tokio-1.52.3
                             rust-tokio-macros-2.7.0
                             rust-tokio-rustls-0.26.4
                             rust-tokio-stream-0.1.18
                             rust-tokio-util-0.7.18
                             rust-toml-0.5.11
                             rust-toml-0.9.11+spec-1.1.0
                             rust-toml-1.1.2+spec-1.1.0
                             rust-toml-datetime-0.7.5+spec-1.1.0
                             rust-toml-datetime-1.1.1+spec-1.1.0
                             rust-toml-edit-0.23.10+spec-1.0.0
                             rust-toml-parser-1.1.2+spec-1.1.0
                             rust-toml-writer-1.1.1+spec-1.1.0
                             rust-tower-0.5.3
                             rust-tower-http-0.6.8
                             rust-tower-layer-0.3.3
                             rust-tower-service-0.3.3
                             rust-tracing-0.1.44
                             rust-tracing-appender-0.2.4
                             rust-tracing-attributes-0.1.31
                             rust-tracing-core-0.1.36
                             rust-tracing-log-0.2.0
                             rust-tracing-serde-0.2.0
                             rust-tracing-subscriber-0.3.22
                             rust-try-lock-0.2.5
                             rust-ttf-parser-0.25.1
                             rust-type-map-0.5.1
                             rust-typenum-1.19.0
                             rust-udev-0.9.3
                             rust-uds-windows-1.1.0
                             rust-unic-langid-0.9.6
                             rust-unic-langid-impl-0.9.6
                             rust-unicode-bidi-0.3.18
                             rust-unicode-bidi-mirroring-0.4.0
                             rust-unicode-ccc-0.4.0
                             rust-unicode-ident-1.0.22
                             rust-unicode-properties-0.1.4
                             rust-unicode-script-0.5.8
                             rust-unicode-vo-0.1.0
                             rust-unicode-width-0.2.2
                             rust-unicode-xid-0.2.6
                             rust-unit-prefix-0.5.2
                             rust-untrusted-0.9.0
                             rust-url-2.5.8
                             rust-usvg-0.46.0
                             rust-utf8-iter-1.0.4
                             rust-utf8parse-0.2.2
                             rust-uuid-1.19.0
                             rust-valuable-0.1.1
                             rust-vcpkg-0.2.15
                             rust-version-compare-0.2.1
                             rust-version-check-0.9.5
                             rust-walkdir-2.5.0
                             rust-want-0.3.1
                             rust-wasi-0.11.1+wasi-snapshot-preview1
                             rust-wasip2-1.0.2+wasi-0.2.9
                             rust-wasm-bindgen-0.2.108
                             rust-wasm-bindgen-futures-0.4.58
                             rust-wasm-bindgen-macro-0.2.108
                             rust-wasm-bindgen-macro-support-0.2.108
                             rust-wasm-bindgen-shared-0.2.108
                             rust-wayland-backend-0.3.12
                             rust-wayland-client-0.31.12
                             rust-wayland-csd-frame-0.3.0
                             rust-wayland-cursor-0.31.12
                             rust-wayland-protocols-0.32.10
                             rust-wayland-protocols-experimental-20250721.0.1
                             rust-wayland-protocols-misc-0.3.10
                             rust-wayland-protocols-wlr-0.3.10
                             rust-wayland-scanner-0.31.8
                             rust-wayland-sys-0.31.8
                             rust-wayle-audio-0.1.2
                             rust-wayle-battery-0.1.2
                             rust-wayle-bluetooth-0.1.2
                             rust-wayle-brightness-0.1.2
                             rust-wayle-cava-0.1.2
                             rust-wayle-core-0.1.2
                             rust-wayle-hyprland-0.1.2
                             rust-wayle-media-0.1.2
                             rust-wayle-network-0.1.2
                             rust-wayle-niri-0.1.0
                             rust-wayle-notification-0.1.3
                             rust-wayle-power-profiles-0.1.2
                             rust-wayle-sysinfo-0.1.2
                             rust-wayle-systray-0.1.3
                             rust-wayle-traits-0.1.2
                             rust-wayle-wallpaper-0.1.3
                             rust-wayle-weather-0.1.2
                             rust-web-sys-0.3.85
                             rust-web-time-1.1.0
                             rust-webpki-root-certs-1.0.5
                             rust-wildcard-0.3.0
                             rust-winapi-0.3.9
                             rust-winapi-i686-pc-windows-gnu-0.4.0
                             rust-winapi-util-0.1.11
                             rust-winapi-x86-64-pc-windows-gnu-0.4.0
                             rust-windows-0.57.0
                             rust-windows-core-0.57.0
                             rust-windows-core-0.62.2
                             rust-windows-implement-0.57.0
                             rust-windows-implement-0.60.2
                             rust-windows-interface-0.57.0
                             rust-windows-interface-0.59.3
                             rust-windows-link-0.2.1
                             rust-windows-result-0.1.2
                             rust-windows-result-0.4.1
                             rust-windows-strings-0.5.1
                             rust-windows-sys-0.45.0
                             rust-windows-sys-0.48.0
                             rust-windows-sys-0.52.0
                             rust-windows-sys-0.60.2
                             rust-windows-sys-0.61.2
                             rust-windows-targets-0.42.2
                             rust-windows-targets-0.48.5
                             rust-windows-targets-0.52.6
                             rust-windows-targets-0.53.5
                             rust-windows-aarch64-gnullvm-0.42.2
                             rust-windows-aarch64-gnullvm-0.48.5
                             rust-windows-aarch64-gnullvm-0.52.6
                             rust-windows-aarch64-gnullvm-0.53.1
                             rust-windows-aarch64-msvc-0.42.2
                             rust-windows-aarch64-msvc-0.48.5
                             rust-windows-aarch64-msvc-0.52.6
                             rust-windows-aarch64-msvc-0.53.1
                             rust-windows-i686-gnu-0.42.2
                             rust-windows-i686-gnu-0.48.5
                             rust-windows-i686-gnu-0.52.6
                             rust-windows-i686-gnu-0.53.1
                             rust-windows-i686-gnullvm-0.52.6
                             rust-windows-i686-gnullvm-0.53.1
                             rust-windows-i686-msvc-0.42.2
                             rust-windows-i686-msvc-0.48.5
                             rust-windows-i686-msvc-0.52.6
                             rust-windows-i686-msvc-0.53.1
                             rust-windows-x86-64-gnu-0.42.2
                             rust-windows-x86-64-gnu-0.48.5
                             rust-windows-x86-64-gnu-0.52.6
                             rust-windows-x86-64-gnu-0.53.1
                             rust-windows-x86-64-gnullvm-0.42.2
                             rust-windows-x86-64-gnullvm-0.48.5
                             rust-windows-x86-64-gnullvm-0.52.6
                             rust-windows-x86-64-gnullvm-0.53.1
                             rust-windows-x86-64-msvc-0.42.2
                             rust-windows-x86-64-msvc-0.48.5
                             rust-windows-x86-64-msvc-0.52.6
                             rust-windows-x86-64-msvc-0.53.1
                             rust-winnow-0.7.14
                             rust-winnow-1.0.3
                             rust-wit-bindgen-0.51.0
                             rust-writeable-0.6.2
                             rust-wyz-0.5.1
                             rust-xcursor-0.3.10
                             rust-xkbcommon-0.8.0
                             rust-xkeysym-0.2.1
                             rust-xml-rs-0.8.28
                             rust-xmlwriter-0.1.0
                             rust-yoke-0.8.1
                             rust-yoke-derive-0.8.1
                             rust-zbus-5.13.2
                             rust-zbus-macros-5.13.2
                             rust-zbus-names-4.3.1
                             rust-zerocopy-0.8.33
                             rust-zerocopy-derive-0.8.33
                             rust-zerofrom-0.1.6
                             rust-zerofrom-derive-0.1.6
                             rust-zeroize-1.8.2
                             rust-zerotrie-0.2.3
                             rust-zerovec-0.11.5
                             rust-zerovec-derive-0.11.2
                              rust-zmij-1.0.16
                              rust-zvariant-5.9.2
                              rust-zvariant-derive-5.9.2
                              rust-zvariant-utils-3.3.0))
    (else #f)))

(define rust-adler2-2.0.1
  (crate-source "adler2" "2.0.1"
                "1ymy18s9hs7ya1pjc9864l30wk8p2qfqdi7mhhcc5nfakxbij09j"))

(define rust-ahash-0.8.12
  (crate-source "ahash" "0.8.12"
                "0xbsp9rlm5ki017c0w6ay8kjwinwm8knjncci95mii30rmwz25as"))

(define rust-aho-corasick-1.1.4
  (crate-source "aho-corasick" "1.1.4"
                "00a32wb2h07im3skkikc495jvncf62jl6s96vwc7bhi70h9imlyx"))

(define rust-allocator-api2-0.2.21
  (crate-source "allocator-api2" "0.2.21"
                "08zrzs022xwndihvzdn78yqarv2b9696y67i6h78nla3ww87jgb8"))

(define rust-android-system-properties-0.1.5
  (crate-source "android_system_properties" "0.1.5"
                "04b3wrz12837j7mdczqd95b732gw5q7q66cv4yn4646lvccp57l1"))

(define rust-anstream-0.6.21
  (crate-source "anstream" "0.6.21"
                "0jjgixms4qjj58dzr846h2s29p8w7ynwr9b9x6246m1pwy0v5ma3"))

(define rust-anstyle-1.0.13
  (crate-source "anstyle" "1.0.13"
                "0y2ynjqajpny6q0amvfzzgw0gfw3l47z85km4gvx87vg02lcr4ji"))

(define rust-anstyle-parse-0.2.7
  (crate-source "anstyle-parse" "0.2.7"
                "1hhmkkfr95d462b3zf6yl2vfzdqfy5726ya572wwg8ha9y148xjf"))

(define rust-anstyle-query-1.1.5
  (crate-source "anstyle-query" "1.1.5"
                "1p6shfpnbghs6jsa0vnqd8bb8gd7pjd0jr7w0j8jikakzmr8zi20"))

(define rust-anstyle-wincon-3.0.11
  (crate-source "anstyle-wincon" "3.0.11"
                "0zblannm70sk3xny337mz7c6d8q8i24vhbqi42ld8v7q1wjnl7i9"))

(define rust-approx-0.5.1
  (crate-source "approx" "0.5.1"
                "1ilpv3dgd58rasslss0labarq7jawxmivk17wsh8wmkdm3q15cfa"))

(define rust-arc-swap-1.8.0
  (crate-source "arc-swap" "1.8.0"
                "0zi02pwgn0vj615k6gpsr36fa6ix8qqsys88ywpcr8lcpd4k9l2i"))

(define rust-arrayref-0.3.9
  (crate-source "arrayref" "0.3.9"
                "1jzyp0nvp10dmahaq9a2rnxqdd5wxgbvp8xaibps3zai8c9fi8kn"))

(define rust-arrayvec-0.7.6
  (crate-source "arrayvec" "0.7.6"
                "0l1fz4ccgv6pm609rif37sl5nv5k6lbzi7kkppgzqzh1vwix20kw"))

(define rust-async-broadcast-0.7.2
  (crate-source "async-broadcast" "0.7.2"
                "0ckmqcwyqwbl2cijk1y4r0vy60i89gqc86ijrxzz5f2m4yjqfnj3"))

(define rust-async-recursion-1.1.1
  (crate-source "async-recursion" "1.1.1"
                "04ac4zh8qz2xjc79lmfi4jlqj5f92xjvfaqvbzwkizyqd4pl4hrv"))

(define rust-async-stream-0.3.6
  (crate-source "async-stream" "0.3.6"
                "0xl4zqncrdmw2g6241wgr11dxdg4h7byy6bz3l6si03qyfk72nhb"))

(define rust-async-stream-impl-0.3.6
  (crate-source "async-stream-impl" "0.3.6"
                "0kaplfb5axsvf1gfs2gk6c4zx6zcsns0yf3ssk7iwni7bphlvhn7"))

(define rust-async-trait-0.1.89
  (crate-source "async-trait" "0.1.89"
                "1fsxxmz3rzx1prn1h3rs7kyjhkap60i7xvi0ldapkvbb14nssdch"))

(define rust-atomic-waker-1.1.2
  (crate-source "atomic-waker" "1.1.2"
                "1h5av1lw56m0jf0fd3bchxq8a30xv0b4wv8s4zkp4s0i7mfvs18m"))

(define rust-autocfg-1.5.0
  (crate-source "autocfg" "1.5.0"
                "1s77f98id9l4af4alklmzq46f21c980v13z2r1pcxx6bqgw0d1n0"))

(define rust-aws-lc-rs-1.15.3
  (crate-source "aws-lc-rs" "1.15.3"
                "11lxrk8dbw5p3pbsn8w1n8kpmsz9krinlz47p7z9q9b7mciyfk78"))

(define rust-aws-lc-sys-0.36.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "aws-lc-sys" "0.36.0"
                "1n2aiw79cdhrnr7z70rk7i6xv63pgabii2scppa3n4b3wgn45923"))

(define rust-base64-0.22.1
  (crate-source "base64" "0.22.1"
                "1imqzgh7bxcikp5vx3shqvw9j09g9ly0xr0jma0q66i52r7jbcvj"))

(define rust-basic-toml-0.1.10
  (crate-source "basic-toml" "0.1.10"
                "12hp59jl28kk229q4sqx6v4fc9p66v8i2byi0vlc9922h9g6fqms"))

(define rust-bindgen-0.72.1
  (crate-source "bindgen" "0.72.1"
                "15bq73y3wd3x3vxh3z3g72hy08zs8rxg1f0i1xsrrd6g16spcdwr"))

(define rust-bitflags-1.3.2
  (crate-source "bitflags" "1.3.2"
                "12ki6w8gn1ldq7yz9y680llwk5gmrhrzszaa17g1sbrw2r2qvwxy"))

(define rust-bitflags-2.10.0
  (crate-source "bitflags" "2.10.0"
                "1lqxwc3625lcjrjm5vygban9v8a6dlxisp1aqylibiaw52si4bl1"))

(define rust-bitvec-1.0.1
  (crate-source "bitvec" "1.0.1"
                "173ydyj2q5vwj88k6xgjnfsshs4x9wbvjjv7sm0h36r34hn87hhv"))

(define rust-block-buffer-0.10.4
  (crate-source "block-buffer" "0.10.4"
                "0w9sa2ypmrsqqvc20nhwr75wbb5cjr4kkyhpjm1z1lv2kdicfy1h"))

(define rust-bumpalo-3.19.1
  (crate-source "bumpalo" "3.19.1"
                "044555i277xcinmqs7nnv8n5y4fqfi4l4lp1mp3i30vsidrxrnax"))

(define rust-by-address-1.2.1
  (crate-source "by_address" "1.2.1"
                "01idmag3lcwnnqrnnyik2gmbrr34drsi97q15ihvcbbidf2kryk4"))

(define rust-bytemuck-1.24.0
  (crate-source "bytemuck" "1.24.0"
                "1x65wc9kwf0dfnmglkl8r46d29pfl7yilll5wh9bcf0g6a0gbg8z"))

(define rust-bytemuck-derive-1.10.2
  (crate-source "bytemuck_derive" "1.10.2"
                "1zvmjmw1sdmx9znzm4dpbb2yvz9vyim8w6gp4z256l46qqdvvazr"))

(define rust-bytes-1.11.0
  (crate-source "bytes" "1.11.0"
                "1cww1ybcvisyj8pbzl4m36bni2jaz0narhczp1348gqbvkxh8lmk"))

(define rust-bytesize-2.3.1
  (crate-source "bytesize" "2.3.1"
                "18vjp7wfik0xi54l3z2314s7zxjyywa4vvwhilawnas2nbkixnbb"))

(define rust-cairo-rs-0.22.0
  (crate-source "cairo-rs" "0.22.0"
                "15fb1m9vlsni37g9qwqgmag7s69f3bplylm0v567901lg6mdkj2w"))

(define rust-cairo-sys-rs-0.22.0
  (crate-source "cairo-sys-rs" "0.22.0"
                "0m3dnyax3l8nwypc2lzzd41bbfrjxykbd39bw2p5yzq42dbrid7q"))

(define rust-calloop-0.14.3
  (crate-source "calloop" "0.14.3"
                "17ih3c840cqksv9ms7i2ynnkiabpvqvpxakbr3922imxd09nx7yb"))

(define rust-calloop-wayland-source-0.4.1
  (crate-source "calloop-wayland-source" "0.4.1"
                "1yi1c23naqhd8m94q3v366s4cak8l50zy7ldrkqfn0hajkqgr3hk"))

(define rust-cc-1.2.53
  (crate-source "cc" "1.2.53"
                "0cjrx2nzlz8l93p4sfymjgsv0jicvfphd6hyhk5gyxbi2z72ypbm"))

(define rust-cesu8-1.1.0
  (crate-source "cesu8" "1.1.0"
                "0g6q58wa7khxrxcxgnqyi9s1z2cjywwwd3hzr5c55wskhx6s0hvd"))

(define rust-cexpr-0.6.0
  (crate-source "cexpr" "0.6.0"
                "0rl77bwhs5p979ih4r0202cn5jrfsrbgrksp40lkfz5vk1x3ib3g"))

(define rust-cfg-aliases-0.2.1
  (crate-source "cfg_aliases" "0.2.1"
                "092pxdc1dbgjb6qvh83gk56rkic2n2ybm4yvy76cgynmzi3zwfk1"))

(define rust-cfg-expr-0.20.5
  (crate-source "cfg-expr" "0.20.5"
                "0827w16d8clifq5pa7pvbjg39bafn0pr43w4zxzyxcndwqf0xgi1"))

(define rust-cfg-if-1.0.4
  (crate-source "cfg-if" "1.0.4"
                "008q28ajc546z5p2hcwdnckmg0hia7rnx52fni04bwqkzyrghc4k"))

(define rust-chrono-0.4.43
  (crate-source "chrono" "0.4.43"
                "06312amlyys4kkjazl13mbxw0j2f7zxygzjkr1yk7s2sn57p9i7s"))

(define rust-clang-sys-1.8.1
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "clang-sys" "1.8.1"
                "1x1r9yqss76z8xwpdanw313ss6fniwc1r7dzb5ycjn0ph53kj0hb"))

(define rust-clap-4.5.54
  (crate-source "clap" "4.5.54"
                "15737jmai272j6jh4ha4dq4ap14ysx2sa5wsjv6zbkvrrnfzzrn6"))

(define rust-clap-builder-4.5.54
  (crate-source "clap_builder" "4.5.54"
                "001cnl5ccva6z3x5nw3m72zs3bzb650anz1scs7vqhbs5d6wyhps"))

(define rust-clap-complete-4.6.0
  (crate-source "clap_complete" "4.6.0"
                "1sric3allwj3isk81khgmsx9qab1bafyr37jh4v6wwvbwzfz3j8r"))

(define rust-clap-derive-4.5.49
  (crate-source "clap_derive" "4.5.49"
                "0wbngw649138v3jwx8pm5x9sq0qsml3sh0sfzyrdxcpamy3m82ra"))

(define rust-clap-lex-0.7.7
  (crate-source "clap_lex" "0.7.7"
                "0cibsbziyzw2ywar2yh6zllsamhwkblfly565zgi56s3q064prn3"))

(define rust-cmake-0.1.57
  (crate-source "cmake" "0.1.57"
                "0zgg10qgykig4nxyf7whrqfg7fkk0xfxhiavikmrndvbrm23qi3m"))

(define rust-codemap-0.1.3
  (crate-source "codemap" "0.1.3"
                "091azkslwkcijj3lp9ymb084y9a0wm4fkil7m613ja68r2snkrxr"))

(define rust-colorchoice-1.0.4
  (crate-source "colorchoice" "1.0.4"
                "0x8ymkz1xr77rcj1cfanhf416pc4v681gmkc9dzb3jqja7f62nxh"))

(define rust-combine-4.6.7
  (crate-source "combine" "4.6.7"
                "1z8rh8wp59gf8k23ar010phgs0wgf5i8cx4fg01gwcnzfn5k0nms"))

(define rust-concurrent-queue-2.5.0
  (crate-source "concurrent-queue" "2.5.0"
                "0wrr3mzq2ijdkxwndhf79k952cp4zkz35ray8hvsxl96xrx1k82c"))

(define rust-console-0.16.2
  (crate-source "console" "0.16.2"
                "1i5y6h3myz38jl9p3gglx5vh9c69kxxajsv3jx0pw8i6i555mr03"))

(define rust-core-foundation-0.10.1
  (crate-source "core-foundation" "0.10.1"
                "1xjns6dqf36rni2x9f47b65grxwdm20kwdg9lhmzdrrkwadcv9mj"))

(define rust-core-foundation-sys-0.8.7
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "core-foundation-sys" "0.8.7"
                "12w8j73lazxmr1z0h98hf3z623kl8ms7g07jch7n4p8f9nwlhdkp"))

(define rust-core-maths-0.1.1
  (crate-source "core_maths" "0.1.1"
                "0c0dv11ixxpc9bsx5xasvl98mb1dlprzcm6qq6ls3nsygw0mwx3p"))

(define rust-cpufeatures-0.2.17
  (crate-source "cpufeatures" "0.2.17"
                "10023dnnaghhdl70xcds12fsx2b966sxbxjq5sxs49mvxqw5ivar"))

(define rust-crc32fast-1.5.0
  (crate-source "crc32fast" "1.5.0"
                "04d51liy8rbssra92p0qnwjw8i9rm9c4m3bwy19wjamz1k4w30cl"))

(define rust-crossbeam-channel-0.5.15
  (crate-source "crossbeam-channel" "0.5.15"
                "1cicd9ins0fkpfgvz9vhz3m9rpkh6n8d3437c3wnfsdkd3wgif42"))

(define rust-crossbeam-utils-0.8.21
  (crate-source "crossbeam-utils" "0.8.21"
                "0a3aa2bmc8q35fb67432w16wvi54sfmb69rk9h5bhd18vw0c99fh"))

(define rust-crypto-common-0.1.7
  (crate-source "crypto-common" "0.1.7"
                "02nn2rhfy7kvdkdjl457q2z0mklcvj9h662xrq6dzhfialh2kj3q"))

(define rust-cursor-icon-1.2.0
  (crate-source "cursor-icon" "1.2.0"
                "0bvkw7ak1mqwcpkgd9lh7n00hcvlh87jfl7188f231nz6zfy2ypj"))

(define rust-data-url-0.3.2
  (crate-source "data-url" "0.3.2"
                "0xl30jidc8s3kh2z3nvnn1nyzhbq5b2wpiqwzj9gjdrndk50n7my"))

(define rust-deranged-0.5.5
  (crate-source "deranged" "0.5.5"
                "11z5939gv2klp1r1lgrp4w5fnlkj18jqqf0h9zxmia3vkrjwpv7c"))

(define rust-derive-more-2.1.1
  (crate-source "derive_more" "2.1.1"
                "0d5i10l4aff744jw7v4n8g6cv15rjk5mp0f1z522pc2nj7jfjlfp"))

(define rust-derive-more-impl-2.1.1
  (crate-source "derive_more-impl" "2.1.1"
                "1jwdp836vymp35d7mfvvalplkdgk2683nv3zjlx65n1194k9g6kr"))

(define rust-digest-0.10.7
  (crate-source "digest" "0.10.7"
                "14p2n6ih29x81akj097lvz7wi9b6b9hvls0lwrv7b6xwyy0s5ncy"))

(define rust-displaydoc-0.2.5
  (crate-source "displaydoc" "0.2.5"
                "1q0alair462j21iiqwrr21iabkfnb13d6x5w95lkdg21q2xrqdlp"))

(define rust-dotenvy-0.15.7
  (crate-source "dotenvy" "0.15.7"
                "16s3n973n5aqym02692i1npb079n5mb0fwql42ikmwn8wnrrbbqs"))

(define rust-downcast-rs-1.2.1
  (crate-source "downcast-rs" "1.2.1"
                "1lmrq383d1yszp7mg5i7i56b17x2lnn3kb91jwsq0zykvg2jbcvm"))

(define rust-dunce-1.0.5
  (crate-source "dunce" "1.0.5"
                "04y8wwv3vvcqaqmqzssi6k0ii9gs6fpz96j5w9nky2ccsl23axwj"))

(define rust-dyn-clone-1.0.20
  (crate-source "dyn-clone" "1.0.20"
                "0m956cxcg8v2n8kmz6xs5zl13k2fak3zkapzfzzp7pxih6hix26h"))

(define rust-either-1.15.0
  (crate-source "either" "1.15.0"
                "069p1fknsmzn9llaizh77kip0pqmcwpdsykv2x30xpjyija5gis8"))

(define rust-encode-unicode-1.0.0
  (crate-source "encode_unicode" "1.0.0"
                "1h5j7j7byi289by63s3w4a8b3g6l5ccdrws7a67nn07vdxj77ail"))

(define rust-encoding-rs-0.8.35
  (crate-source "encoding_rs" "0.8.35"
                "1wv64xdrr9v37rqqdjsyb8l8wzlcbab80ryxhrszvnj59wy0y0vm"))

(define rust-endi-1.1.1
  (crate-source "endi" "1.1.1"
                "16a0076dx41vgrzzimm9clcym77h732czqjiajanmzvd1i1y5dv6"))

(define rust-enumflags2-0.7.12
  (crate-source "enumflags2" "0.7.12"
                "1vzcskg4dca2jiflsfx1p9yw1fvgzcakcs7cpip0agl51ilgf9qh"))

(define rust-enumflags2-derive-0.7.12
  (crate-source "enumflags2_derive" "0.7.12"
                "09rqffacafl1b83ir55hrah9gza0x7pzjn6lr6jm76fzix6qmiv7"))

(define rust-equivalent-1.0.2
  (crate-source "equivalent" "1.0.2"
                "03swzqznragy8n0x31lqc78g2af054jwivp7lkrbrc0khz74lyl7"))

(define rust-errno-0.3.14
  (crate-source "errno" "0.3.14"
                "1szgccmh8vgryqyadg8xd58mnwwicf39zmin3bsn63df2wbbgjir"))

(define rust-euclid-0.22.13
  (crate-source "euclid" "0.22.13"
                "0qzdj4xicyrsvd4cq6m5ndvfdrvvqrawy799qbaqhzw37r4byqfz"))

(define rust-evdev-0.13.2
  (crate-source "evdev" "0.13.2"
                "16gaxdjwv0ng6jx1qd196vlg878g2wibmxhgi298vw577dk8ddi5"))

(define rust-event-listener-5.4.1
  (crate-source "event-listener" "5.4.1"
                "1asnp3agbr8shcl001yd935m167ammyi8hnvl0q1ycajryn6cfz1"))

(define rust-event-listener-strategy-0.5.4
  (crate-source "event-listener-strategy" "0.5.4"
                "14rv18av8s7n8yixg38bxp5vg2qs394rl1w052by5npzmbgz7scb"))

(define rust-fallible-iterator-0.3.0
  (crate-source "fallible-iterator" "0.3.0"
                "0ja6l56yka5vn4y4pk6hn88z0bpny7a8k1919aqjzp0j1yhy9k1a"))

(define rust-fallible-streaming-iterator-0.1.9
  (crate-source "fallible-streaming-iterator" "0.1.9"
                "0nj6j26p71bjy8h42x6jahx1hn0ng6mc2miwpgwnp8vnwqf4jq3k"))

(define rust-fast-srgb8-1.0.0
  (crate-source "fast-srgb8" "1.0.0"
                "18g6xwwh4gnkyx1352hnvwagpv0n4y98yp2llm8vyvwxh487abnx"))

(define rust-fastrand-2.3.0
  (crate-source "fastrand" "2.3.0"
                "1ghiahsw1jd68df895cy5h3gzwk30hndidn3b682zmshpgmrx41p"))

(define rust-fdeflate-0.3.7
  (crate-source "fdeflate" "0.3.7"
                "130ga18vyxbb5idbgi07njymdaavvk6j08yh1dfarm294ssm6s0y"))

(define rust-field-offset-0.3.6
  (crate-source "field-offset" "0.3.6"
                "0zq5sssaa2ckmcmxxbly8qgz3sxpb8g1lwv90sdh1z74qif2gqiq"))

(define rust-find-crate-0.6.3
  (crate-source "find-crate" "0.6.3"
                "1ljpkh11gj7940xwz47xjhsvfbl93c2q0ql7l2v0w77amjx8paar"))

(define rust-find-msvc-tools-0.1.8
  (crate-source "find-msvc-tools" "0.1.8"
                "1nv8hn78xphg04l6w7iq1v8lsmmqx6ripbig18qn92m9r2yb14c5"))

(define rust-flate2-1.1.8
  (crate-source "flate2" "1.1.8"
                "0sgkq8z9ldz06qxl704sm9akfy2r70zp1ixi4mghl2cqbd3dcxdk"))

(define rust-float-cmp-0.9.0
  (crate-source "float-cmp" "0.9.0"
                "1i799ksbq7fj9rm9m82g1yqgm6xi3jnrmylddmqknmksajylpplq"))

(define rust-fluent-0.17.0
  (crate-source "fluent" "0.17.0"
                "0xq4cxw4mkdh1k9i5w850sky0m41la8sm6nbpw76n3f5lbascdw1"))

(define rust-fluent-bundle-0.16.0
  (crate-source "fluent-bundle" "0.16.0"
                "1x1v8bmym6x9pl87f82lbzwlc84kdn0lgcwi73ki2mwgj6w3q801"))

(define rust-fluent-langneg-0.13.1
  (crate-source "fluent-langneg" "0.13.1"
                "1c78jl8lpwg5hdg589qbn3m9ls6mzqxnyrvi5llfibhb8mcvxsvy"))

(define rust-fluent-syntax-0.12.0
  (crate-source "fluent-syntax" "0.12.0"
                "1661sp6kl268n445x7jjhnbkgiaa1xcpyryq0i6iiz9zqn3x5w2l"))

(define rust-flume-0.12.0
  (crate-source "flume" "0.12.0"
                "1gnk7gji9r12ig35czj2cq441zf5ijmz0bgnz9gfnxx7dk29n4sy"))

(define rust-fnv-1.0.7
  (crate-source "fnv" "1.0.7"
                "1hc2mcqha06aibcaza94vbi81j6pr9a1bbxrxjfhc91zin8yr7iz"))

(define rust-foldhash-0.2.0
  (crate-source "foldhash" "0.2.0"
                "1nvgylb099s11xpfm1kn2wcsql080nqmnhj1l25bp3r2b35j9kkp"))

(define rust-fontconfig-parser-0.5.8
  (crate-source "fontconfig-parser" "0.5.8"
                "0ijnbzg31sl6v49g7q2l7sl76hjj8z0hvlsz77cdvm029vi77ixv"))

(define rust-fontdb-0.23.0
  (crate-source "fontdb" "0.23.0"
                "0199vry9x8zn9ix4x4rqvv53dy2ryhy68l53jwr580hj7ndphzj5"))

(define rust-form-urlencoded-1.2.2
  (crate-source "form_urlencoded" "1.2.2"
                "1kqzb2qn608rxl3dws04zahcklpplkd5r1vpabwga5l50d2v4k6b"))

(define rust-fragile-2.1.0
  (crate-source "fragile" "2.1.0"
                "1ygw6asivdkyiy7a427hq17bvspr31pzsas1ia0nxf2bl55qcy48"))

(define rust-fs-extra-1.3.0
  (crate-source "fs_extra" "1.3.0"
                "075i25z70j2mz9r7i9p9r521y8xdj81q7skslyb7zhqnnw33fw22"))

(define rust-fsevent-sys-4.1.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "fsevent-sys" "4.1.0"
                "1liz67v8b0gcs8r31vxkvm2jzgl9p14i78yfqx81c8sdv817mvkn"))

(define rust-funty-2.0.0
  (crate-source "funty" "2.0.0"
                "177w048bm0046qlzvp33ag3ghqkqw4ncpzcm5lq36gxf2lla7mg6"))

(define rust-futures-0.3.32
  (crate-source "futures" "0.3.32"
                "0b9q86r5ar18v5xjiyqn7sb8sa32xv98qqnfz779gl7ns7lpw54b"))

(define rust-futures-channel-0.3.32
  (crate-source "futures-channel" "0.3.32"
                "07fcyzrmbmh7fh4ainilf1s7gnwvnk07phdq77jkb9fpa2ffifq7"))

(define rust-futures-core-0.3.32
  (crate-source "futures-core" "0.3.32"
                "07bbvwjbm5g2i330nyr1kcvjapkmdqzl4r6mqv75ivvjaa0m0d3y"))

(define rust-futures-executor-0.3.32
  (crate-source "futures-executor" "0.3.32"
                "17aplz3ns74qn7a04qg7qlgsdx5iwwwkd4jvdfra6hl3h4w9rwms"))

(define rust-futures-io-0.3.32
  (crate-source "futures-io" "0.3.32"
                "063pf5m6vfmyxj74447x8kx9q8zj6m9daamj4hvf49yrg9fs7jyf"))

(define rust-futures-lite-2.6.1
  (crate-source "futures-lite" "2.6.1"
                "1ba4dg26sc168vf60b1a23dv1d8rcf3v3ykz2psb7q70kxh113pp"))

(define rust-futures-macro-0.3.32
  (crate-source "futures-macro" "0.3.32"
                "0ys4b1lk7s0bsj29pv42bxsaavalch35rprp64s964p40c1bfdg8"))

(define rust-futures-sink-0.3.32
  (crate-source "futures-sink" "0.3.32"
                "14q8ml7hn5a6gyy9ri236j28kh0svqmrk4gcg0wh26rkazhm95y3"))

(define rust-futures-task-0.3.32
  (crate-source "futures-task" "0.3.32"
                "14s3vqf8llz3kjza33vn4ixg6kwxp61xrysn716h0cwwsnri2xq3"))

(define rust-futures-util-0.3.32
  (crate-source "futures-util" "0.3.32"
                "1mn60lw5kh32hz9isinjlpw34zx708fk5q1x0m40n6g6jq9a971q"))

(define rust-gdk-pixbuf-0.22.0
  (crate-source "gdk-pixbuf" "0.22.0"
                "0imnx7m6f3agw91hqv1zpci658wj71by8k1pvfr43q5ydlvj1x15"))

(define rust-gdk-pixbuf-sys-0.22.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "gdk-pixbuf-sys" "0.22.0"
                "1ywipm5pg65rsyfkb62xb2s013n10kpvg4bb9yslhjzwn4vipws8"))

(define rust-gdk4-0.11.2
  (crate-source "gdk4" "0.11.2"
                "0kia5nic35rqx13z0sndmqjrrwz8sa9gnrbwyklcc4l6yjxzshpx"))

(define rust-gdk4-sys-0.11.2
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "gdk4-sys" "0.11.2"
                "0g041nwg1399vl73zcx4c9bll2sr2bvdla4p78n4frsyy724m5wx"))

(define rust-generic-array-0.14.7
  (crate-source "generic-array" "0.14.7"
                "16lyyrzrljfq424c3n8kfwkqihlimmsg5nhshbbp48np3yjrqr45"))

(define rust-getrandom-0.2.17
  (crate-source "getrandom" "0.2.17"
                "1l2ac6jfj9xhpjjgmcx6s1x89bbnw9x6j9258yy6xjkzpq0bqapz"))

(define rust-getrandom-0.3.4
  (crate-source "getrandom" "0.3.4"
                "1zbpvpicry9lrbjmkd4msgj3ihff1q92i334chk7pzf46xffz7c9"))

(define rust-gio-0.22.6
  (crate-source "gio" "0.22.6"
                "1rm478hn5yqmm6j56ailcawbzmlrsz7qxfpq3nkw0p53lg5qp173"))

(define rust-gio-sys-0.22.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "gio-sys" "0.22.0"
                "1qc797pz587qbs38mhnq02qywss5yjldnrprz540821cfyi9nwk4"))

(define rust-gio-unix-0.22.6
  (crate-source "gio-unix" "0.22.6"
                "0z6vmzyjfi9dwx21dqhi66cwckn5k6lrk53y09cqp3r8y4yin97r"))

(define rust-gio-unix-sys-0.22.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "gio-unix-sys" "0.22.0"
                "1zfvy1klwzjxmc4gffmmmqfb6l2zcisg0s722q1084liwdybkfj4"))

(define rust-gl-0.14.0
  (crate-source "gl" "0.14.0"
                "015lgy3qpzdw7mnh59a4y4hdjq1fhv7nkqlmh1h6fzc212qxlkm9"))

(define rust-gl-generator-0.14.0
  (crate-source "gl_generator" "0.14.0"
                "0k8j1hmfnff312gy7x1aqjzcm8zxid7ij7dlb8prljib7b1dz58s"))

(define rust-glib-0.22.7
  (crate-source "glib" "0.22.7"
                "0jhhh59k47xrix2cynxcx8w183m1nf8ibi1455xwypb0a57f01y2"))

(define rust-glib-macros-0.22.6
  (crate-source "glib-macros" "0.22.6"
                "06bgdnz54l50vxkcp8iraab1v1x3v7l5g5s2k0l19iq7jx4j6vah"))

(define rust-glib-sys-0.22.6
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "glib-sys" "0.22.6"
                "0iclvgbp4il2wilg1my23i2g3kdrw7lbvdsrhfic4nzd6k1blzsz"))

(define rust-glob-0.3.3
  (crate-source "glob" "0.3.3"
                "106jpd3syfzjfj2k70mwm0v436qbx96wig98m4q8x071yrq35hhc"))

(define rust-gobject-sys-0.22.6
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "gobject-sys" "0.22.6"
                "0b57dwgs2yp56892kp990bxxhmvsr69c2n8k8v7pjyl8kf2n3a12"))

(define rust-graphene-rs-0.22.0
  (crate-source "graphene-rs" "0.22.0"
                "1wbiilhc6s2d8i9j55848aimffm90vlxyslbh14rz1ln3y4bglf7"))

(define rust-graphene-sys-0.22.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "graphene-sys" "0.22.0"
                "177p8fcn0157i81gz68iylrcl8rw9fkkiw53awzgvdyn7wphczsi"))

(define rust-grass-0.13.4
  (crate-source "grass" "0.13.4"
                "151wydlb0543hcyv00g06wiakrp6p5xnr3g4703qzxky8cb859pp"))

(define rust-grass-compiler-0.13.4
  (crate-source "grass_compiler" "0.13.4"
                "1xngzb4h04fkdhyagrwcqanrl7arghj3v5sl84cfab12y3vkv7id"))

(define rust-gsk4-0.11.1
  (crate-source "gsk4" "0.11.1"
                "0qnbrndajrkz6842c7zv7svxrq95kyxl1769bz7cm2njrggi5jak"))

(define rust-gsk4-sys-0.11.1
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "gsk4-sys" "0.11.1"
                "12pv31xvbkvbprd2f8gmidf3dyyc2pgfx58c9zz6z2wxgay4pmfp"))

(define rust-gtk4-0.11.3
  (crate-source "gtk4" "0.11.3"
                "1qmaisvzidk83b63hbm7lz5r42jn01x5yis1jkvr7gjcy0vvi0bi"))

(define rust-gtk4-layer-shell-0.8.0
  (crate-source "gtk4-layer-shell" "0.8.0"
                "0akmfkalh09527qn7d35cpj3id1nqf604ld226ank4s7zy3rj1m4"))

(define rust-gtk4-layer-shell-sys-0.6.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "gtk4-layer-shell-sys" "0.6.0"
                "1fgijmmjkfq1a8g2rqgwb8vdbkl7129pdazjzkkm9i5wqmg6lmlg"))

(define rust-gtk4-macros-0.11.0
  (crate-source "gtk4-macros" "0.11.0"
                "11sah2f0518gsqcvs8hn0ckc6bjq86k6wqmv5q9gzzb2p91b509m"))

(define rust-gtk4-sys-0.11.3
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "gtk4-sys" "0.11.3"
                "06sfmv726jvzcq3n0x2hwhcic58abzj6aki7c5alah16brlqxfi0"))

(define rust-hashbrown-0.14.5
  (crate-source "hashbrown" "0.14.5"
                "1wa1vy1xs3mp11bn3z9dv0jricgr6a2j0zkf1g19yz3vw4il89z5"))

(define rust-hashbrown-0.16.1
  (crate-source "hashbrown" "0.16.1"
                "004i3njw38ji3bzdp9z178ba9x3k0c1pgy8x69pj7yfppv4iq7c4"))

(define rust-hashlink-0.11.0
  (crate-source "hashlink" "0.11.0"
                "0c6jpsyb9f3j5yrlbw8rnr5kpkar08z02b1h3b5sf14w39b242za"))

(define rust-heck-0.5.0
  (crate-source "heck" "0.5.0"
                "1sjmpsdl8czyh9ywl3qcsfsq9a307dg4ni2vnlwgnzzqhc4y0113"))

(define rust-hermit-abi-0.3.9
  (crate-source "hermit-abi" "0.3.9"
                "092hxjbjnq5fmz66grd9plxd0sh6ssg5fhgwwwqbrzgzkjwdycfj"))

(define rust-hermit-abi-0.5.2
  (crate-source "hermit-abi" "0.5.2"
                "1744vaqkczpwncfy960j2hxrbjl1q01csm84jpd9dajbdr2yy3zw"))

(define rust-hex-0.4.3
  (crate-source "hex" "0.4.3"
                "0w1a4davm1lgzpamwnba907aysmlrnygbqmfis2mqjx5m552a93z"))

(define rust-http-1.4.0
  (crate-source "http" "1.4.0"
                "06iind4cwsj1d6q8c2xgq8i2wka4ps74kmws24gsi1bzdlw2mfp3"))

(define rust-http-body-1.0.1
  (crate-source "http-body" "1.0.1"
                "111ir5k2b9ihz5nr9cz7cwm7fnydca7dx4hc7vr16scfzghxrzhy"))

(define rust-http-body-util-0.1.3
  (crate-source "http-body-util" "0.1.3"
                "0jm6jv4gxsnlsi1kzdyffjrj8cfr3zninnxpw73mvkxy4qzdj8dh"))

(define rust-httparse-1.10.1
  (crate-source "httparse" "1.10.1"
                "11ycd554bw2dkgw0q61xsa7a4jn1wb1xbfacmf3dbwsikvkkvgvd"))

(define rust-hyper-1.8.1
  (crate-source "hyper" "1.8.1"
                "04cxr8j5y86bhxxlyqb8xkxjskpajk7cxwfzzk4v3my3a3rd9cia"))

(define rust-hyper-rustls-0.27.7
  (crate-source "hyper-rustls" "0.27.7"
                "0n6g8998szbzhnvcs1b7ibn745grxiqmlpg53xz206v826v3xjg3"))

(define rust-hyper-util-0.1.19
  (crate-source "hyper-util" "0.1.19"
                "0pyzc8378baf996l5ycl4y0s3skhxc4z4vkah9mvff3r1vb0ay3j"))

(define rust-i18n-config-0.4.8
  (crate-source "i18n-config" "0.4.8"
                "1vv31hz9zpzqz1ddpisxm2iz6c2swchlnd4l7hh2w98di86bj1iy"))

(define rust-i18n-embed-0.16.0
  (crate-source "i18n-embed" "0.16.0"
                "0183rf7jchhy6lnd2rgjcz54b0k7q1zqjy7s5qlzpbnwfnqbn5x2"))

(define rust-i18n-embed-fl-0.10.0
  (crate-source "i18n-embed-fl" "0.10.0"
                "0c4zgqp6va5q6mkndqa058k1m6gjxscyawj6w1hjzfbxnrryv675"))

(define rust-i18n-embed-impl-0.8.4
  (crate-source "i18n-embed-impl" "0.8.4"
                "1hmnimlv310cirg8nx77nf8q1si4hq1yarkg5kyfc7rxabhc0b0g"))

(define rust-iana-time-zone-0.1.64
  (crate-source "iana-time-zone" "0.1.64"
                "1yz980fmhaq9bdkasz35z63az37ci6kzzfhya83kgdqba61pzr9k"))

(define rust-iana-time-zone-haiku-0.1.2
  (crate-source "iana-time-zone-haiku" "0.1.2"
                "17r6jmj31chn7xs9698r122mapq85mfnv98bb4pg6spm0si2f67k"))

(define rust-icu-collections-2.1.1
  (crate-source "icu_collections" "2.1.1"
                "0hsblchsdl64q21qwrs4hvc2672jrf466zivbj1bwyv606bn8ssc"))

(define rust-icu-locale-core-2.1.1
  (crate-source "icu_locale_core" "2.1.1"
                "1djvdc2f5ylmp1ymzv4gcnmq1s4hqfim9nxlcm173lsd01hpifpd"))

(define rust-icu-normalizer-2.1.1
  (crate-source "icu_normalizer" "2.1.1"
                "16dmn5596la2qm0r3vih0bzjfi0vx9a20yqjha6r1y3vnql8hv2z"))

(define rust-icu-normalizer-data-2.1.1
  (crate-source "icu_normalizer_data" "2.1.1"
                "02jnzizg6q75m41l6c13xc7nkc5q8yr1b728dcgfhpzw076wrvbs"))

(define rust-icu-properties-2.1.2
  (crate-source "icu_properties" "2.1.2"
                "1v3lbmhhi7i6jgw51ikjb1p50qh5rb67grlkdnkc63l7zq1gq2q2"))

(define rust-icu-properties-data-2.1.2
  (crate-source "icu_properties_data" "2.1.2"
                "1bvpkh939rgzrjfdb7hz47v4wijngk0snmcgrnpwc9fpz162jv31"))

(define rust-icu-provider-2.1.1
  (crate-source "icu_provider" "2.1.1"
                "0576b7dizgyhpfa74kacv86y4g1p7v5ffd6c56kf1q82rvq2r5l5"))

(define rust-idna-1.1.0
  (crate-source "idna" "1.1.0"
                "1pp4n7hppm480zcx411dsv9wfibai00wbpgnjj4qj0xa7kr7a21v"))

(define rust-idna-adapter-1.2.1
  (crate-source "idna_adapter" "1.2.1"
                "0i0339pxig6mv786nkqcxnwqa87v4m94b2653f6k3aj0jmhfkjis"))

(define rust-imagesize-0.14.0
  (crate-source "imagesize" "0.14.0"
                "1725g398w4v35qrv9s3gl8gl5cqj5cwkamn7mvvl12y4niblxr89"))

(define rust-indexmap-2.13.0
  (crate-source "indexmap" "2.13.0"
                "05qh5c4h2hrnyypphxpwflk45syqbzvqsvvyxg43mp576w2ff53p"))

(define rust-indicatif-0.18.3
  (crate-source "indicatif" "0.18.3"
                "126b1nzklazk3mc5pazvch0s6rawai9ij0bc3hdyqqxlwh9f2xck"))

(define rust-inotify-0.11.0
  (crate-source "inotify" "0.11.0"
                "1wq8m657rl085cg59p38sc5y62xy9yhhpvxbkd7n1awi4zzwqzgk"))

(define rust-inotify-sys-0.1.5
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "inotify-sys" "0.1.5"
                "1syhjgvkram88my04kv03s0zwa66mdwa5v7ddja3pzwvx2sh4p70"))

(define rust-intl-memoizer-0.5.3
  (crate-source "intl-memoizer" "0.5.3"
                "0gqn5wwhzacvj0z25r5r3l2pajg9c8i1ivh7g8g8dszm8pis439i"))

(define rust-intl-pluralrules-7.0.2
  (crate-source "intl_pluralrules" "7.0.2"
                "0wprd3h6h8nfj62d8xk71h178q7zfn3srxm787w4sawsqavsg3h7"))

(define rust-inventory-0.3.21
  (crate-source "inventory" "0.3.21"
                "0vml3zmj9bwixf0xfrbvw8ip5ci1c8blprxy36cv3gig12f20qdw"))

(define rust-io-lifetimes-1.0.11
  (crate-source "io-lifetimes" "1.0.11"
                "1hph5lz4wd3drnn6saakwxr497liznpfnv70via6s0v8x6pbkrza"))

(define rust-ipnet-2.11.0
  (crate-source "ipnet" "2.11.0"
                "0c5i9sfi2asai28m8xp48k5gvwkqrg5ffpi767py6mzsrswv17s6"))

(define rust-iri-string-0.7.10
  (crate-source "iri-string" "0.7.10"
                "06kk3a5jz576p7vrpf7zz9jv3lrgcyp7pczcblcxdnryg3q3h4y9"))

(define rust-is-terminal-polyfill-1.70.2
  (crate-source "is_terminal_polyfill" "1.70.2"
                "15anlc47sbz0jfs9q8fhwf0h3vs2w4imc030shdnq54sny5i7jx6"))

(define rust-itertools-0.13.0
  (crate-source "itertools" "0.13.0"
                "11hiy3qzl643zcigknclh446qb9zlg4dpdzfkjaa9q9fqpgyfgj1"))

(define rust-itoa-1.0.17
  (crate-source "itoa" "1.0.17"
                "1lh93xydrdn1g9x547bd05g0d3hra7pd1k4jfd2z1pl1h5hwdv4j"))

(define rust-jni-0.21.1
  (crate-source "jni" "0.21.1"
                "15wczfkr2r45slsljby12ymf2hij8wi5b104ghck9byjnwmsm1qs"))

(define rust-jni-sys-0.3.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "jni-sys" "0.3.0"
                "0c01zb9ygvwg9wdx2fii2d39myzprnpqqhy7yizxvjqp5p04pbwf"))

(define rust-jobserver-0.1.34
  (crate-source "jobserver" "0.1.34"
                "0cwx0fllqzdycqn4d6nb277qx5qwnmjdxdl0lxkkwssx77j3vyws"))

(define rust-js-sys-0.3.85
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "js-sys" "0.3.85"
                "1csmb42fxjmzjdgc790bgw77sf1cb9ydm5rdsnh5qj4miszjx54c"))

(define rust-khronos-api-3.1.0
  (crate-source "khronos_api" "3.1.0"
                "1p0xj5mlbagqyvvnv8wmv3cr7l9y1m153888pxqwg3vk3mg5inz2"))

(define rust-kqueue-1.1.1
  (crate-source "kqueue" "1.1.1"
                "0sjrsnza8zxr1zfpv6sa0zapd54kx9wlijrz9apqvs6wsw303hza"))

(define rust-kqueue-sys-1.0.4
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "kqueue-sys" "1.0.4"
                "12w3wi90y4kwis4k9g6fp0kqjdmc6l00j16g8mgbhac7vbzjb5pd"))

(define rust-kurbo-0.13.0
  (crate-source "kurbo" "0.13.0"
                "1yrvgfqzi68wnshacgr1v6hfmahvn8i57j8b3wg7gmf0wc7yjr3m"))

(define rust-lasso-0.7.3
  (crate-source "lasso" "0.7.3"
                "1yz92fy2zv6wslfwwf3j7lw1wxja8d91rrcwgfzv751l1ajys53f"))

(define rust-lazy-static-1.5.0
  (crate-source "lazy_static" "1.5.0"
                "1zk6dqqni0193xg6iijh7i3i44sryglwgvx20spdvwk3r6sbrlmv"))

(define rust-libc-0.2.186
  (crate-source "libc" "0.2.186"
                "0rnyhzjyqq9x56skkllbjzzzwym3r61lq3l4hqj64v71gw0r3av8"))

(define rust-libloading-0.8.9
  (crate-source "libloading" "0.8.9"
                "0mfwxwjwi2cf0plxcd685yxzavlslz7xirss3b9cbrzyk4hv1i6p"))

(define rust-libm-0.2.15
  (crate-source "libm" "0.2.15"
                "1plpzf0p829viazdj57yw5dhmlr8ywf3apayxc2f2bq5a6mvryzr"))

(define rust-libpulse-binding-2.30.1
  (crate-source "libpulse-binding" "2.30.1"
                "15x3srbvqmwmhk20q9binq3cwakj59pgwnp61xl77qqnkq2b77lh"))

(define rust-libpulse-sys-1.23.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "libpulse-sys" "1.23.0"
                "0qayl38603vlzrfb9n2p2mqn0jfpxg9225nc57w8ks92if272hyp"))

(define rust-libsqlite3-sys-0.36.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "libsqlite3-sys" "0.36.0"
                "0ak4pibl2n1lnziwb7vkq98iw5i7cryv9dlc8aw2x9zgzwy11d4m"))

(define rust-libudev-sys-0.1.4
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "libudev-sys" "0.1.4"
                "09236fdzlx9l0dlrsc6xx21v5x8flpfm3d5rjq9jr5ivlas6k11w"))

(define rust-linux-raw-sys-0.11.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "linux-raw-sys" "0.11.0"
                "0fghx0nn8nvbz5yzgizfcwd6ap2pislp68j8c1bwyr6sacxkq7fz"))

(define rust-litemap-0.8.1
  (crate-source "litemap" "0.8.1"
                "0xsy8pfp9s802rsj1bq2ys2kbk1g36w5dr3gkfip7gphb5x60wv3"))

(define rust-lock-api-0.4.14
  (crate-source "lock_api" "0.4.14"
                "0rg9mhx7vdpajfxvdjmgmlyrn20ligzqvn8ifmaz7dc79gkrjhr2"))

(define rust-log-0.4.29
  (crate-source "log" "0.4.29"
                "15q8j9c8g5zpkcw0hnd6cf2z7fxqnvsjh3rw5mv5q10r83i34l2y"))

(define rust-lru-slab-0.1.2
  (crate-source "lru-slab" "0.1.2"
                "0m2139k466qj3bnpk66bwivgcx3z88qkxvlzk70vd65jq373jaqi"))

(define rust-matchers-0.2.0
  (crate-source "matchers" "0.2.0"
                "1sasssspdj2vwcwmbq3ra18d3qniapkimfcbr47zmx6750m5llni"))

(define rust-memchr-2.8.0
  (crate-source "memchr" "2.8.0"
                "0y9zzxcqxvdqg6wyag7vc3h0blhdn7hkq164bxyx2vph8zs5ijpq"))

(define rust-memmap2-0.9.9
  (crate-source "memmap2" "0.9.9"
                "146lfx0mpib44wvws6hibahm4h2w867bzwsc6zhmi9p0l3j36hbl"))

(define rust-memoffset-0.9.1
  (crate-source "memoffset" "0.9.1"
                "12i17wh9a9plx869g7j4whf62xw68k5zd4k0k5nh6ys5mszid028"))

(define rust-mime-0.3.17
  (crate-source "mime" "0.3.17"
                "16hkibgvb9klh0w0jk5crr5xv90l3wlf77ggymzjmvl1818vnxv8"))

(define rust-minijinja-2.15.1
  (crate-source "minijinja" "2.15.1"
                "0id2qb615q0njr8xbc718h8v1m02vaz4chlnyfq9yxzhnrmn2ydl"))

(define rust-minimal-lexical-0.2.1
  (crate-source "minimal-lexical" "0.2.1"
                "16ppc5g84aijpri4jzv14rvcnslvlpphbszc7zzp6vfkddf4qdb8"))

(define rust-miniz-oxide-0.8.9
  (crate-source "miniz_oxide" "0.8.9"
                "05k3pdg8bjjzayq3rf0qhpirq9k37pxnasfn4arbs17phqn6m9qz"))

(define rust-mio-1.2.0
  (crate-source "mio" "1.2.0"
                "1hanrh4fwsfkdqdaqfidz48zz1wdix23zwn3r2x78am0garfbdsh"))

(define rust-niri-ipc-25.11.0
  (crate-source "niri-ipc" "25.11.0"
                "16ij0mh28nfshzkbmdml6ysrqdsqfs1ndkskx0n2ix9pwjs9xg8j"))

(define rust-nix-0.29.0
  (crate-source "nix" "0.29.0"
                "0ikvn7s9r2lrfdm3mx1h7nbfjvcc6s9vxdzw7j5xfkd2qdnp9qki"))

(define rust-nix-0.30.1
  (crate-source "nix" "0.30.1"
                "1dixahq9hk191g0c2ydc0h1ppxj0xw536y6rl63vlnp06lx3ylkl"))

(define rust-nom-7.1.3
  (crate-source "nom" "7.1.3"
                "0jha9901wxam390jcf5pfa0qqfrgh8li787jx2ip0yk5b8y9hwyj"))

(define rust-notify-8.2.0
  (crate-source "notify" "8.2.0"
                "1hrb83451vm5cpjw83nz5skgwjg5ara28zq8nxsqbzsif690fgad"))

(define rust-notify-types-2.0.0
  (crate-source "notify-types" "2.0.0"
                "0pcjm3wnvb7pvzw6mn89csv64ip0xhx857kr8jic5vddi6ljc22y"))

(define rust-ntapi-0.4.2
  (crate-source "ntapi" "0.4.2"
                "10ghcc1kmj5ygy4ls81as6s5akd1wflwcc0b1k3nf8ql46g223y7"))

(define rust-nu-ansi-term-0.50.3
  (crate-source "nu-ansi-term" "0.50.3"
                "1ra088d885lbd21q1bxgpqdlk1zlndblmarn948jz2a40xsbjmvr"))

(define rust-num-conv-0.1.0
  (crate-source "num-conv" "0.1.0"
                "1ndiyg82q73783jq18isi71a7mjh56wxrk52rlvyx0mi5z9ibmai"))

(define rust-num-derive-0.4.2
  (crate-source "num-derive" "0.4.2"
                "00p2am9ma8jgd2v6xpsz621wc7wbn1yqi71g15gc3h67m7qmafgd"))

(define rust-num-traits-0.2.19
  (crate-source "num-traits" "0.2.19"
                "0h984rhdkkqd4ny9cif7y2azl3xdfb7768hb9irhpsch4q3gq787"))

(define rust-once-cell-1.21.3
  (crate-source "once_cell" "1.21.3"
                "0b9x77lb9f1j6nqgf5aka4s2qj0nly176bpbrv6f9iakk5ff3xa2"))

(define rust-once-cell-polyfill-1.70.2
  (crate-source "once_cell_polyfill" "1.70.2"
                "1zmla628f0sk3fhjdjqzgxhalr2xrfna958s632z65bjsfv8ljrq"))

(define rust-openssl-probe-0.2.1
  (crate-source "openssl-probe" "0.2.1"
                "1gpwpb7smfhkscwvbri8xzbab39wcnby1jgz1s49vf1aqgsdx1vw"))

(define rust-ordered-stream-0.2.0
  (crate-source "ordered-stream" "0.2.0"
                "0l0xxp697q7wiix1gnfn66xsss7fdhfivl2k7bvpjs4i3lgb18ls"))

(define rust-owo-colors-4.2.3
  (crate-source "owo-colors" "4.2.3"
                "0ljavh4hfxmlyjr67hyii5875p55kjg24crkj6h937m7kxr02scw"))

(define rust-palette-0.7.6
  (crate-source "palette" "0.7.6"
                "1rmn02mv6cb112504qyg7pyfa83c08hxpk5sw7jc5v659hc73gsc"))

(define rust-palette-derive-0.7.6
  (crate-source "palette_derive" "0.7.6"
                "0c0xhpk1nqyq4jr2m8xnka7w47vqzc7m2vq9ih8wxyjv02phs0zm"))

(define rust-pango-0.22.6
  (crate-source "pango" "0.22.6"
                "0f14fn8jmqf8q009x8wgmb04azp007ij2sj01sz13f47cipdq6r5"))

(define rust-pango-sys-0.22.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "pango-sys" "0.22.0"
                "1mnm14vf7xcrag51qjfqy400kh3rqs1rgi897vqfs3x91ji13ldv"))

(define rust-parking-2.2.1
  (crate-source "parking" "2.2.1"
                "1fnfgmzkfpjd69v4j9x737b1k8pnn054bvzcn5dm3pkgq595d3gk"))

(define rust-parking-lot-0.12.5
  (crate-source "parking_lot" "0.12.5"
                "06jsqh9aqmc94j2rlm8gpccilqm6bskbd67zf6ypfc0f4m9p91ck"))

(define rust-parking-lot-core-0.9.12
  (crate-source "parking_lot_core" "0.9.12"
                "1hb4rggy70fwa1w9nb0svbyflzdc69h047482v2z3sx2hmcnh896"))

(define rust-percent-encoding-2.3.2
  (crate-source "percent-encoding" "2.3.2"
                "083jv1ai930azvawz2khv7w73xh8mnylk7i578cifndjn5y64kwv"))

(define rust-phf-0.11.3
  (crate-source "phf" "0.11.3"
                "0y6hxp1d48rx2434wgi5g8j1pr8s5jja29ha2b65435fh057imhz"))

(define rust-phf-generator-0.11.3
  (crate-source "phf_generator" "0.11.3"
                "0gc4np7s91ynrgw73s2i7iakhb4lzdv1gcyx7yhlc0n214a2701w"))

(define rust-phf-macros-0.11.3
  (crate-source "phf_macros" "0.11.3"
                "05kjfbyb439344rhmlzzw0f9bwk9fp95mmw56zs7yfn1552c0jpq"))

(define rust-phf-shared-0.11.3
  (crate-source "phf_shared" "0.11.3"
                "1rallyvh28jqd9i916gk5gk2igdmzlgvv5q0l3xbf3m6y8pbrsk7"))

(define rust-pico-args-0.5.0
  (crate-source "pico-args" "0.5.0"
                "05d30pvxd6zlnkg2i3ilr5a70v3f3z2in18m67z25vinmykngqav"))

(define rust-pin-project-lite-0.2.16
  (crate-source "pin-project-lite" "0.2.16"
                "16wzc7z7dfkf9bmjin22f5282783f6mdksnr0nv0j5ym5f9gyg1v"))

(define rust-pin-utils-0.1.0
  (crate-source "pin-utils" "0.1.0"
                "117ir7vslsl2z1a7qzhws4pd01cg2d3338c47swjyvqv2n60v1wb"))

(define rust-pkg-config-0.3.32
  (crate-source "pkg-config" "0.3.32"
                "0k4h3gnzs94sjb2ix6jyksacs52cf1fanpwsmlhjnwrdnp8dppby"))

(define rust-png-0.18.1
  (crate-source "png" "0.18.1"
                "0qca282xp8a6d7mikxrwji3f52mjn4vnqxz2v9iz5adj665rnxk0"))

(define rust-polling-3.11.0
  (crate-source "polling" "3.11.0"
                "0622qfbxi3gb0ly2c99n3xawp878fkrd1sl83hjdhisx11cly3jx"))

(define rust-portable-atomic-1.13.0
  (crate-source "portable-atomic" "1.13.0"
                "0l79rf3pzlxmmrylr1c4k61qn8hzs6hzz69yk738pdcvsvj7d5zq"))

(define rust-potential-utf-0.1.4
  (crate-source "potential_utf" "0.1.4"
                "0xxg0pkfpq299wvwln409z4fk80rbv55phh3f1jhjajy5x1ljfdp"))

(define rust-powerfmt-0.2.0
  (crate-source "powerfmt" "0.2.0"
                "14ckj2xdpkhv3h6l5sdmb9f1d57z8hbfpdldjc2vl5givq2y77j3"))

(define rust-ppv-lite86-0.2.21
  (crate-source "ppv-lite86" "0.2.21"
                "1abxx6qz5qnd43br1dd9b2savpihzjza8gb4fbzdql1gxp2f7sl5"))

(define rust-prettyplease-0.2.37
  (crate-source "prettyplease" "0.2.37"
                "0azn11i1kh0byabhsgab6kqs74zyrg69xkirzgqyhz6xmjnsi727"))

(define rust-proc-macro-crate-3.4.0
  (crate-source "proc-macro-crate" "3.4.0"
                "10v9qi51n4phn1lrj5r94kjq7yhci9jrkqnn6wpan05yjsgb3711"))

(define rust-proc-macro-error-attr2-2.0.0
  (crate-source "proc-macro-error-attr2" "2.0.0"
                "1ifzi763l7swl258d8ar4wbpxj4c9c2im7zy89avm6xv6vgl5pln"))

(define rust-proc-macro-error2-2.0.1
  (crate-source "proc-macro-error2" "2.0.1"
                "00lq21vgh7mvyx51nwxwf822w2fpww1x0z8z0q47p8705g2hbv0i"))

(define rust-proc-macro2-1.0.105
  (crate-source "proc-macro2" "1.0.105"
                "1rvgs5qdznlrqrgicmv24nybnrnv8kyvk2vi7s52ddna1q71hpak"))

(define rust-quick-xml-0.38.4
  (crate-source "quick-xml" "0.38.4"
                "0772siy4d9vlq77842012c8cycs3y0szxkv62rh9sh2sqmc20v5n"))

(define rust-quinn-0.11.9
  (crate-source "quinn" "0.11.9"
                "086gzj666dr3slmlynkvxlndy28hahgl361d6bf93hk3i6ahmqmr"))

(define rust-quinn-proto-0.11.13
  (crate-source "quinn-proto" "0.11.13"
                "0cca3mgja9p4w66f6sl1kfhj8rdf4mwsg1jxzssh9g63n14np47i"))

(define rust-quinn-udp-0.5.14
  (crate-source "quinn-udp" "0.5.14"
                "1gacawr17a2zkyri0r3m0lc9spzmxbq1by3ilyb8v2mdvjhcdpmd"))

(define rust-quote-1.0.43
  (crate-source "quote" "1.0.43"
                "02n41mlr81qmczac7m5kjy51y8b7yrb8ym4ncmjycampjjjxjx6w"))

(define rust-r-efi-5.3.0
  (crate-source "r-efi" "5.3.0"
                "03sbfm3g7myvzyylff6qaxk4z6fy76yv860yy66jiswc2m6b7kb9"))

(define rust-radium-0.7.0
  (crate-source "radium" "0.7.0"
                "02cxfi3ky3c4yhyqx9axqwhyaca804ws46nn4gc1imbk94nzycyw"))

(define rust-rand-0.8.5
  (crate-source "rand" "0.8.5"
                "013l6931nn7gkc23jz5mm3qdhf93jjf0fg64nz2lp4i51qd8vbrl"))

(define rust-rand-0.9.2
  (crate-source "rand" "0.9.2"
                "1lah73ainvrgl7brcxx0pwhpnqa3sm3qaj672034jz8i0q7pgckd"))

(define rust-rand-chacha-0.3.1
  (crate-source "rand_chacha" "0.3.1"
                "123x2adin558xbhvqb8w4f6syjsdkmqff8cxwhmjacpsl1ihmhg6"))

(define rust-rand-chacha-0.9.0
  (crate-source "rand_chacha" "0.9.0"
                "1jr5ygix7r60pz0s1cv3ms1f6pd1i9pcdmnxzzhjc3zn3mgjn0nk"))

(define rust-rand-core-0.6.4
  (crate-source "rand_core" "0.6.4"
                "0b4j2v4cb5krak1pv6kakv4sz6xcwbrmy2zckc32hsigbrwy82zc"))

(define rust-rand-core-0.9.5
  (crate-source "rand_core" "0.9.5"
                "0g6qc5r3f0hdmz9b11nripyp9qqrzb0xqk9piip8w8qlvqkcibvn"))

(define rust-redox-syscall-0.5.18
  (crate-source "redox_syscall" "0.5.18"
                "0b9n38zsxylql36vybw18if68yc9jczxmbyzdwyhb9sifmag4azd"))

(define rust-ref-cast-1.0.25
  (crate-source "ref-cast" "1.0.25"
                "0zdzc34qjva9xxgs889z5iz787g81hznk12zbk4g2xkgwq530m7k"))

(define rust-ref-cast-impl-1.0.25
  (crate-source "ref-cast-impl" "1.0.25"
                "1nkhn1fklmn342z5c4mzfzlxddv3x8yhxwwk02cj06djvh36065p"))

(define rust-regex-1.12.3
  (crate-source "regex" "1.12.3"
                "0xp2q0x7ybmpa5zlgaz00p8zswcirj9h8nry3rxxsdwi9fhm81z1"))

(define rust-regex-automata-0.4.13
  (crate-source "regex-automata" "0.4.13"
                "070z0j23pjfidqz0z89id1fca4p572wxpcr20a0qsv68bbrclxjj"))

(define rust-regex-syntax-0.8.8
  (crate-source "regex-syntax" "0.8.8"
                "0n7ggnpk0r32rzgnycy5xrc1yp2kq19m6pz98ch3c6dkaxw9hbbs"))

(define rust-relm4-0.11.0
  (crate-source "relm4" "0.11.0"
                "1651f57p54kq4ki8z00bqgwnzdp1lhwx2sb4cp4rwpjly28g0834"))

(define rust-relm4-css-0.11.0
  (crate-source "relm4-css" "0.11.0"
                "0s632d7v3vwrb5xcwsd0xi0rgdc68h92kyjsh4y10jvq7wk1vf7k"))

(define rust-relm4-macros-0.11.0
  (crate-source "relm4-macros" "0.11.0"
                "0ksas9m345n5j4pa9h153fhqgc9nr4idaqbbwrsj7j301bsxpj9n"))

(define rust-reqwest-0.13.1
  (crate-source "reqwest" "0.13.1"
                "0qig3k8sh6lcwygjsq89wrqkbaxff4rg180nrhq5ykl1kn603s84"))

(define rust-ring-0.17.14
  (crate-source "ring" "0.17.14"
                "1dw32gv19ccq4hsx3ribhpdzri1vnrlcfqb2vj41xn4l49n9ws54"))

(define rust-roxmltree-0.20.0
  (crate-source "roxmltree" "0.20.0"
                "15vw91ps91wkmmgy62khf9zb63bdinvm80957dascbsw7dwvc83c"))

(define rust-roxmltree-0.21.1
  (crate-source "roxmltree" "0.21.1"
                "1fxc3jgvl2rk05bw0hj86azqg6mzlijh06gyi9pw69b1qw84p5pi"))

(define rust-rsqlite-vfs-0.1.0
  (crate-source "rsqlite-vfs" "0.1.0"
                "0kap86yzwl355byfs891185h723nxvl746fdp8gnpvrna0qz58d8"))

(define rust-rusqlite-0.38.0
  (crate-source "rusqlite" "0.38.0"
                "1wvsy4ilbsz4yvbgxj5zna880avhrc4j2j9c76646fv8r78kvjgi"))

(define rust-rust-embed-8.11.0
  (crate-source "rust-embed" "8.11.0"
                "09wdk33zavfn2w3id20jidywvf4abfjg1wbfy21psdss6nwkq484"))

(define rust-rust-embed-impl-8.11.0
  (crate-source "rust-embed-impl" "8.11.0"
                "1ancyg87vx07w5m39538bwvj3hlizk8fd15kk8argsf8qzj042fs"))

(define rust-rust-embed-utils-8.11.0
  (crate-source "rust-embed-utils" "8.11.0"
                "1cf3wmwdivxqzizav813y42ln9r9jya3q1xi6finyzzywq5yzkav"))

(define rust-rustc-hash-2.1.1
  (crate-source "rustc-hash" "2.1.1"
                "03gz5lvd9ghcwsal022cgkq67dmimcgdjghfb5yb5d352ga06xrm"))

(define rust-rustc-version-0.4.1
  (crate-source "rustc_version" "0.4.1"
                "14lvdsmr5si5qbqzrajgb6vfn69k0sfygrvfvr2mps26xwi3mjyg"))

(define rust-rustix-1.1.3
  (crate-source "rustix" "1.1.3"
                "0d0z2zcw4rwzni1hm8snw8xdxwwrij336m31c4ghq66cghj9wv0l"))

(define rust-rustls-0.23.36
  (crate-source "rustls" "0.23.36"
                "06w0077ssk3blpp93613lkny046mwj0nhxjgc7cmg9nf70yz6rf6"))

(define rust-rustls-native-certs-0.8.3
  (crate-source "rustls-native-certs" "0.8.3"
                "0qrajg2n90bcr3bcq6j95gjm7a9lirfkkdmjj32419dyyzan0931"))

(define rust-rustls-pki-types-1.14.0
  (crate-source "rustls-pki-types" "1.14.0"
                "1p9zsgslvwzzkzhm6bqicffqndr4jpx67992b0vl0pi21a5hy15y"))

(define rust-rustls-platform-verifier-0.6.2
  (crate-source "rustls-platform-verifier" "0.6.2"
                "110pqkn3px9115pb6h6a23cq738v29gbp559dfvpmbibqzmzx68x"))

(define rust-rustls-platform-verifier-android-0.1.1
  (crate-source "rustls-platform-verifier-android" "0.1.1"
                "13vq6sxsgz9547xm2zbdxiw8x7ad1g8n8ax6xvxsjqszk7q6awgq"))

(define rust-rustls-webpki-0.103.9
  (crate-source "rustls-webpki" "0.103.9"
                "0lwg1nnyv7pp2lfwwjhy81bxm233am99jnsp3iymdhd6k8827pyp"))

(define rust-rustversion-1.0.22
  (crate-source "rustversion" "1.0.22"
                "0vfl70jhv72scd9rfqgr2n11m5i9l1acnk684m2w83w0zbqdx75k"))

(define rust-rustybuzz-0.20.1
  (crate-source "rustybuzz" "0.20.1"
                "00hp1gwykjfli258zs7lqg8p2zdh94dv2mw8zx7f73m0z2b7qg7x"))

(define rust-ryu-1.0.22
  (crate-source "ryu" "1.0.22"
                "1139acr2kd4n8p36bp1n42xrpaphn6dhwklnazh8hpdnfps4q3x5"))

(define rust-same-file-1.0.6
  (crate-source "same-file" "1.0.6"
                "00h5j1w87dmhnvbv9l8bic3y7xxsnjmssvifw2ayvgx9mb1ivz4k"))

(define rust-schannel-0.1.28
  (crate-source "schannel" "0.1.28"
                "1qb6s5gyxfz2inz753a4z3mc1d266mwvz0c5w7ppd3h44swq27c9"))

(define rust-schemars-1.2.0
  (crate-source "schemars" "1.2.0"
                "1lk7qb6797dmixnb0qfkmlpsa5p2kgwk29s91xvpmia2hw811sal"))

(define rust-schemars-derive-1.2.0
  (crate-source "schemars_derive" "1.2.0"
                "0ibwb8amvy70xrgbfqp1iqk0mvqd4x4hvpyg2bmshdahihlas229"))

(define rust-scopeguard-1.2.0
  (crate-source "scopeguard" "1.2.0"
                "0jcz9sd47zlsgcnm1hdw0664krxwb5gczlif4qngj2aif8vky54l"))

(define rust-security-framework-3.5.1
  (crate-source "security-framework" "3.5.1"
                "1vz6pf5qjgx8s0hg805hq6qbcqnll6fs63irvrpgcc7qx91p6adk"))

(define rust-security-framework-sys-2.15.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "security-framework-sys" "2.15.0"
                "1h6mijxnfrwvl1y4dzwn3m877j6dqp9qn3g37i954j5czazhq7yc"))

(define rust-self-cell-1.2.2
  (crate-source "self_cell" "1.2.2"
                "12cdmh9p2h72rmw923kj841jji4k0vrykihvx19fn059az8pcbmi"))

(define rust-semver-1.0.27
  (crate-source "semver" "1.0.27"
                "1qmi3akfrnqc2hfkdgcxhld5bv961wbk8my3ascv5068mc5fnryp"))

(define rust-serde-1.0.228
  (crate-source "serde" "1.0.228"
                "17mf4hhjxv5m90g42wmlbc61hdhlm6j9hwfkpcnd72rpgzm993ls"))

(define rust-serde-core-1.0.228
  (crate-source "serde_core" "1.0.228"
                "1bb7id2xwx8izq50098s5j2sqrrvk31jbbrjqygyan6ask3qbls1"))

(define rust-serde-derive-1.0.228
  (crate-source "serde_derive" "1.0.228"
                "0y8xm7fvmr2kjcd029g9fijpndh8csv5m20g4bd76w8qschg4h6m"))

(define rust-serde-derive-internals-0.29.1
  (crate-source "serde_derive_internals" "0.29.1"
                "04g7macx819vbnxhi52cx0nhxi56xlhrybgwybyy7fb9m4h6mlhq"))

(define rust-serde-json-1.0.149
  (crate-source "serde_json" "1.0.149"
                "11jdx4vilzrjjd1dpgy67x5lgzr0laplz30dhv75lnf5ffa07z43"))

(define rust-serde-json-path-0.7.2
  (crate-source "serde_json_path" "0.7.2"
                "0cwxkcsy0dvadzsil0ipv9r1igd4rrhjs14sm4xndsjf36iwx4mr"))

(define rust-serde-json-path-core-0.2.2
  (crate-source "serde_json_path_core" "0.2.2"
                "1g61dc6f9zxk6kdhll1yflgdv39n910ps92ym6snfjbxzs6pvrnx"))

(define rust-serde-json-path-macros-0.1.6
  (crate-source "serde_json_path_macros" "0.1.6"
                "1j7sdi82928g479vfis21c9lwxw3lr29q4az7p2gbnkxyykwyyji"))

(define rust-serde-json-path-macros-internal-0.1.2
  (crate-source "serde_json_path_macros_internal" "0.1.2"
                "143vpp1wh2mr4lip7mdcmaajlzgzxjz8kvw3r81vzaaz2yzfzyxa"))

(define rust-serde-repr-0.1.20
  (crate-source "serde_repr" "0.1.20"
                "1755gss3f6lwvv23pk7fhnjdkjw7609rcgjlr8vjg6791blf6php"))

(define rust-serde-spanned-1.1.1
  (crate-source "serde_spanned" "1.1.1"
                "09jzk7i6wihn3d8i3wi4j4n98ghi93c3b8m8k64nxq0ijn3vaqk6"))

(define rust-serde-urlencoded-0.7.1
  (crate-source "serde_urlencoded" "0.7.1"
                "1zgklbdaysj3230xivihs30qi5vkhigg323a9m62k8jwf4a1qjfk"))

(define rust-sha2-0.10.9
  (crate-source "sha2" "0.10.9"
                "10xjj843v31ghsksd9sl9y12qfc48157j1xpb8v1ml39jy0psl57"))

(define rust-sharded-slab-0.1.7
  (crate-source "sharded-slab" "0.1.7"
                "1xipjr4nqsgw34k7a2cgj9zaasl2ds6jwn89886kww93d32a637l"))

(define rust-shlex-1.3.0
  (crate-source "shlex" "1.3.0"
                "0r1y6bv26c1scpxvhg2cabimrmwgbp4p3wy6syj9n0c4s3q2znhg"))

(define rust-signal-hook-registry-1.4.8
  (crate-source "signal-hook-registry" "1.4.8"
                "06vc7pmnki6lmxar3z31gkyg9cw7py5x9g7px70gy2hil75nkny4"))

(define rust-simd-adler32-0.3.8
  (crate-source "simd-adler32" "0.3.8"
                "18lx2gdgislabbvlgw5q3j5ssrr77v8kmkrxaanp3liimp2sc873"))

(define rust-simplecss-0.2.2
  (crate-source "simplecss" "0.2.2"
                "0v0kid7b2602kcka2x2xs9wwfjf8lnvpgpl8x287qg4wra1ni73s"))

(define rust-siphasher-1.0.1
  (crate-source "siphasher" "1.0.1"
                "17f35782ma3fn6sh21c027kjmd227xyrx06ffi8gw4xzv9yry6an"))

(define rust-slab-0.4.11
  (crate-source "slab" "0.4.11"
                "12bm4s88rblq02jjbi1dw31984w61y2ldn13ifk5gsqgy97f8aks"))

(define rust-slotmap-1.1.1
  (crate-source "slotmap" "1.1.1"
                "0f20xf53zaysx9ydzkwwqm6hsjyb8lj2j6amhg57iln3jcy8rmdx"))

(define rust-smallvec-1.15.1
  (crate-source "smallvec" "1.15.1"
                "00xxdxxpgyq5vjnpljvkmy99xij5rxgh913ii1v16kzynnivgcb7"))

(define rust-smithay-client-toolkit-0.20.0
  (crate-source "smithay-client-toolkit" "0.20.0"
                "1h2cacmsh9zpw6sgmap49zx7cqhksfwas91mm40i5cz2ylwdl4h5"))

(define rust-socket2-0.6.3
  (crate-source "socket2" "0.6.3"
                "0gkjjcyn69hqhhlh5kl8byk5m0d7hyrp2aqwzbs3d33q208nwxis"))

(define rust-sourceview5-0.11.0
  (crate-source "sourceview5" "0.11.0"
                "1r0pgyzfka72wk77q2vwqd801fxkkij364iv7djrp1s5a3194gaj"))

(define rust-sourceview5-sys-0.11.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "sourceview5-sys" "0.11.0"
                "0qmqkqj43pq1rz7zj2s7p9rmx0v6y1ha9fjfpxw9nm0pxvcvk8yl"))

(define rust-spin-0.9.8
  (crate-source "spin" "0.9.8"
                "0rvam5r0p3a6qhc18scqpvpgb3ckzyqxpgdfyjnghh8ja7byi039"))

(define rust-sqlite-wasm-rs-0.5.2
  (crate-source "sqlite-wasm-rs" "0.5.2"
                "06qq401l0xjgr61nv15z2s7yfg6cda7p4zdp56f0nsb77bnhchig"))

(define rust-stable-deref-trait-1.2.1
  (crate-source "stable_deref_trait" "1.2.1"
                "15h5h73ppqyhdhx6ywxfj88azmrpml9gl6zp3pwy2malqa6vxqkc"))

(define rust-strict-num-0.1.1
  (crate-source "strict-num" "0.1.1"
                "0cb7l1vhb8zj90mzm8avlk815k40sql9515s865rqdrdfavvldv6"))

(define rust-strsim-0.11.1
  (crate-source "strsim" "0.11.1"
                "0kzvqlw8hxqb7y598w1s0hxlnmi84sg5vsipp3yg5na5d1rvba3x"))

(define rust-subtle-2.6.1
  (crate-source "subtle" "2.6.1"
                "14ijxaymghbl1p0wql9cib5zlwiina7kall6w7g89csprkgbvhhk"))

(define rust-svgtypes-0.16.1
  (crate-source "svgtypes" "0.16.1"
                "0gdw5a7znyv5sh4a575ddlhkvnvf45dd5grvkflsy78knf85fnv9"))

(define rust-syn-2.0.114
  (crate-source "syn" "2.0.114"
                "0akw62dizhyrkf3ym1jsys0gy1nphzgv0y8qkgpi6c1s4vghglfl"))

(define rust-sync-wrapper-1.0.2
  (crate-source "sync_wrapper" "1.0.2"
                "0qvjyasd6w18mjg5xlaq5jgy84jsjfsvmnn12c13gypxbv75dwhb"))

(define rust-synstructure-0.13.2
  (crate-source "synstructure" "0.13.2"
                "1lh9lx3r3jb18f8sbj29am5hm9jymvbwh6jb1izsnnxgvgrp12kj"))

(define rust-sys-locale-0.3.2
  (crate-source "sys-locale" "0.3.2"
                "1i16hq9mkwpzqvixjfy1ph4i2q5klgagjg4hibz6k894l2crmawf"))

(define rust-sysinfo-0.33.1
  (crate-source "sysinfo" "0.33.1"
                "00bcbj9rk39n07ylclj9klggkshxyianv2lfkpqnc6x0iqj5ij2g"))

(define rust-system-deps-7.0.7
  (crate-source "system-deps" "7.0.7"
                "0zsyh2m893nqkp1wri5c85favp2xyl1qpjxnd5nz31pr6qvz7j28"))

(define rust-tap-1.0.1
  (crate-source "tap" "1.0.1"
                "0sc3gl4nldqpvyhqi3bbd0l9k7fngrcl4zs47n314nqqk4bpx4sm"))

(define rust-target-lexicon-0.13.3
  (crate-source "target-lexicon" "0.13.3"
                "0355pbycq0cj29h1rp176l57qnfwmygv7hwzchs7iq15gibn4zyz"))

(define rust-tempfile-3.24.0
  (crate-source "tempfile" "3.24.0"
                "171fz3h6rj676miq15fyv1hnv69p426mlp8489bwa1b3xg3sjpb5"))

(define rust-thiserror-1.0.69
  (crate-source "thiserror" "1.0.69"
                "0lizjay08agcr5hs9yfzzj6axs53a2rgx070a1dsi3jpkcrzbamn"))

(define rust-thiserror-2.0.18
  (crate-source "thiserror" "2.0.18"
                "1i7vcmw9900bvsmay7mww04ahahab7wmr8s925xc083rpjybb222"))

(define rust-thiserror-impl-1.0.69
  (crate-source "thiserror-impl" "1.0.69"
                "1h84fmn2nai41cxbhk6pqf46bxqq1b344v8yz089w1chzi76rvjg"))

(define rust-thiserror-impl-2.0.18
  (crate-source "thiserror-impl" "2.0.18"
                "1mf1vrbbimj1g6dvhdgzjmn6q09yflz2b92zs1j9n3k7cxzyxi7b"))

(define rust-thread-local-1.1.9
  (crate-source "thread_local" "1.1.9"
                "1191jvl8d63agnq06pcnarivf63qzgpws5xa33hgc92gjjj4c0pn"))

(define rust-time-0.3.45
  (crate-source "time" "0.3.45"
                "1gdag88agck220k6fxbgb7gsnr2r14n33sxzm5db9zfp6gy45r7r"))

(define rust-time-core-0.1.7
  (crate-source "time-core" "0.1.7"
                "1jilglvr6m6h2iidnvdp3zfahck9wa7kw64rslk79v1izncfwdlb"))

(define rust-time-macros-0.2.25
  (crate-source "time-macros" "0.2.25"
                "1pg3zrqyvjcy1nh470mdw7qxwwq6zmwq3f1dlp11mxlv4k8m5rbi"))

(define rust-tiny-skia-path-0.11.4
  (crate-source "tiny-skia-path" "0.11.4"
                "14ywbdfakvacl6rxxmzbnycplaxpc6i2linh2yqk0sp8qb07z7lw"))

(define rust-tinystr-0.8.2
  (crate-source "tinystr" "0.8.2"
                "0sa8z88axdsf088hgw5p4xcyi6g3w3sgbb6qdp81bph9bk2fkls2"))

(define rust-tinyvec-1.10.0
  (crate-source "tinyvec" "1.10.0"
                "1yhk0qdqyiaa4v2j9h8pzax5gxgwpz4da0lcphfil6g6pk1zv9dz"))

(define rust-tinyvec-macros-0.1.1
  (crate-source "tinyvec_macros" "0.1.1"
                "081gag86208sc3y6sdkshgw3vysm5d34p431dzw0bshz66ncng0z"))

(define rust-tokio-1.52.3
  (crate-source "tokio" "1.52.3"
                "1zpzazypkg61sw91na1m85x5s4rsjym335fwwhwm1hcs70dz1iwg"))

(define rust-tokio-macros-2.7.0
  (crate-source "tokio-macros" "2.7.0"
                "15m4f37mdafs0gg36sh0rskm1i768lb7zmp8bw67kaxr3avnqniq"))

(define rust-tokio-rustls-0.26.4
  (crate-source "tokio-rustls" "0.26.4"
                "0qggwknz9w4bbsv1z158hlnpkm97j3w8v31586jipn99byaala8p"))

(define rust-tokio-stream-0.1.18
  (crate-source "tokio-stream" "0.1.18"
                "0w3cj33605ab58wqd382gnla5pnd9hnr00xgg333np5bka04knij"))

(define rust-tokio-util-0.7.18
  (crate-source "tokio-util" "0.7.18"
                "1600rd47pylwn7cap1k7s5nvdaa9j7w8kqigzp1qy7mh0p4cxscs"))

(define rust-toml-0.5.11
  (crate-source "toml" "0.5.11"
                "0d2266nx8b3n22c7k24x4428z6di8n83a9n466jm7a2hipfz1xzl"))

(define rust-toml-0.9.11+spec-1.1.0
  (crate-source "toml" "0.9.11+spec-1.1.0"
                "0ikwmd5s9ndg6afxijaxjcgxw53sd9af3mmfzymf37rh92lckbzk"))

(define rust-toml-1.1.2+spec-1.1.0
  (crate-source "toml" "1.1.2+spec-1.1.0"
                "1vpggpamqhw4852kic7465zsidczsla06wz6friqkkfbhigd3ww1"))

(define rust-toml-datetime-0.7.5+spec-1.1.0
  (crate-source "toml_datetime" "0.7.5+spec-1.1.0"
                "0iqkgvgsxmszpai53dbip7sf2igic39s4dby29dbqf1h9bnwzqcj"))

(define rust-toml-datetime-1.1.1+spec-1.1.0
  (crate-source "toml_datetime" "1.1.1+spec-1.1.0"
                "1mws2mkkf46l7inn77azhm0vdwxngv9vsbhbl0ah33p2c9gzcr9i"))

(define rust-toml-edit-0.23.10+spec-1.0.0
  (crate-source "toml_edit" "0.23.10+spec-1.0.0"
                "0saj5c676j8a3sqaj9akkp09wambg8aflji4zblwwa70azvvkj44"))

(define rust-toml-parser-1.1.2+spec-1.1.0
  (crate-source "toml_parser" "1.1.2+spec-1.1.0"
                "09kmzc55a0j21whm290wlf5a8b18a0qc87a1s8sncrckc6wfkax2"))

(define rust-toml-writer-1.1.1+spec-1.1.0
  (crate-source "toml_writer" "1.1.1+spec-1.1.0"
                "1nwjhvvrxz8f4ck1qi4xcz2x9qhpci37nrknhxxf9sqk22dsyvbm"))

(define rust-tower-0.5.3
  (crate-source "tower" "0.5.3"
                "1m5i3a2z1sgs8nnz1hgfq2nr4clpdmizlp1d9qsg358ma5iyzrgb"))

(define rust-tower-http-0.6.8
  (crate-source "tower-http" "0.6.8"
                "1y514jwzbyrmrkbaajpwmss4rg0mak82k16d6588w9ncaffmbrnl"))

(define rust-tower-layer-0.3.3
  (crate-source "tower-layer" "0.3.3"
                "03kq92fdzxin51w8iqix06dcfgydyvx7yr6izjq0p626v9n2l70j"))

(define rust-tower-service-0.3.3
  (crate-source "tower-service" "0.3.3"
                "1hzfkvkci33ra94xjx64vv3pp0sq346w06fpkcdwjcid7zhvdycd"))

(define rust-tracing-0.1.44
  (crate-source "tracing" "0.1.44"
                "006ilqkg1lmfdh3xhg3z762izfwmxcvz0w7m4qx2qajbz9i1drv3"))

(define rust-tracing-appender-0.2.4
  (crate-source "tracing-appender" "0.2.4"
                "1bxf7xvsr89glbq174cx0b9pinaacbhlmc85y1ssniv2rq5lhvbq"))

(define rust-tracing-attributes-0.1.31
  (crate-source "tracing-attributes" "0.1.31"
                "1np8d77shfvz0n7camx2bsf1qw0zg331lra0hxb4cdwnxjjwz43l"))

(define rust-tracing-core-0.1.36
  (crate-source "tracing-core" "0.1.36"
                "16mpbz6p8vd6j7sf925k9k8wzvm9vdfsjbynbmaxxyq6v7wwm5yv"))

(define rust-tracing-log-0.2.0
  (crate-source "tracing-log" "0.2.0"
                "1hs77z026k730ij1a9dhahzrl0s073gfa2hm5p0fbl0b80gmz1gf"))

(define rust-tracing-serde-0.2.0
  (crate-source "tracing-serde" "0.2.0"
                "1wbgzi364vzfswfkvy48a3p0z5xmv98sx342r57sil70ggmiljvh"))

(define rust-tracing-subscriber-0.3.22
  (crate-source "tracing-subscriber" "0.3.22"
                "07hz575a0p1c2i4xw3gs3hkrykhndnkbfhyqdwjhvayx4ww18c1g"))

(define rust-try-lock-0.2.5
  (crate-source "try-lock" "0.2.5"
                "0jqijrrvm1pyq34zn1jmy2vihd4jcrjlvsh4alkjahhssjnsn8g4"))

(define rust-ttf-parser-0.25.1
  (crate-source "ttf-parser" "0.25.1"
                "0cbgqglcwwjg3hirwq6xlza54w04mb5x02kf7zx4hrw50xmr1pyj"))

(define rust-type-map-0.5.1
  (crate-source "type-map" "0.5.1"
                "143v32wwgpymxfy4y8s694vyq0wdi7li4s5dmms5w59nj2yxnc6b"))

(define rust-typenum-1.19.0
  (crate-source "typenum" "1.19.0"
                "1fw2mpbn2vmqan56j1b3fbpcdg80mz26fm53fs16bq5xcq84hban"))

(define rust-udev-0.9.3
  (crate-source "udev" "0.9.3"
                "17vy1yc6ipb5m2kc2d4lx2qpj45yr7grsjzm3y2gq0a4xblkfkmg"))

(define rust-uds-windows-1.1.0
  (crate-source "uds_windows" "1.1.0"
                "1fb4y65pw0rsp0gyfyinjazlzxz1f6zv7j4zmb20l5pxwv1ypnl9"))

(define rust-unic-langid-0.9.6
  (crate-source "unic-langid" "0.9.6"
                "01bx59sqsx2jz4z7ppxq9kldcjq9dzadkmb2dr7iyc85kcnab2x2"))

(define rust-unic-langid-impl-0.9.6
  (crate-source "unic-langid-impl" "0.9.6"
                "0n66kdan4cz99n8ra18i27f7w136hmppi4wc0aa7ljsd0h4bzqfw"))

(define rust-unicode-bidi-0.3.18
  (crate-source "unicode-bidi" "0.3.18"
                "1xcxwbsqa24b8vfchhzyyzgj0l6bn51ib5v8j6krha0m77dva72w"))

(define rust-unicode-bidi-mirroring-0.4.0
  (crate-source "unicode-bidi-mirroring" "0.4.0"
                "1zirs1z3ahlwy7swg7apnm3pc6vix1g15q0kn6fx8rmvc266xyjx"))

(define rust-unicode-ccc-0.4.0
  (crate-source "unicode-ccc" "0.4.0"
                "0gjhxwx27ywm3rcbb0m5q20w8zxi51440b3ps6swi6ywpj4d8qff"))

(define rust-unicode-ident-1.0.22
  (crate-source "unicode-ident" "1.0.22"
                "1x8xrz17vqi6qmkkcqr8cyf0an76ig7390j9cnqnk47zyv2gf4lk"))

(define rust-unicode-properties-0.1.4
  (crate-source "unicode-properties" "0.1.4"
                "07fpm3sqq7lm9gmgpxa93z31q933h3c3ypfwy4cdh6l42g3miw3x"))

(define rust-unicode-script-0.5.8
  (crate-source "unicode-script" "0.5.8"
                "1vmifpgd0map3frmvhszhl96k82crcry083prv05wii7p45x8fiq"))

(define rust-unicode-vo-0.1.0
  (crate-source "unicode-vo" "0.1.0"
                "151sha088v9jyfvbg5164xh4dk72g53b82xm4zzbf5dlagzqdlxi"))

(define rust-unicode-width-0.2.2
  (crate-source "unicode-width" "0.2.2"
                "0m7jjzlcccw716dy9423xxh0clys8pfpllc5smvfxrzdf66h9b5l"))

(define rust-unicode-xid-0.2.6
  (crate-source "unicode-xid" "0.2.6"
                "0lzqaky89fq0bcrh6jj6bhlz37scfd8c7dsj5dq7y32if56c1hgb"))

(define rust-unit-prefix-0.5.2
  (crate-source "unit-prefix" "0.5.2"
                "18xr6yhdvlxrv51y6js9npa3qhkzc5b1z4skr5kfzn7kkd449rc1"))

(define rust-untrusted-0.9.0
  (crate-source "untrusted" "0.9.0"
                "1ha7ib98vkc538x0z60gfn0fc5whqdd85mb87dvisdcaifi6vjwf"))

(define rust-url-2.5.8
  (crate-source "url" "2.5.8"
                "1v8f7nx3hpr1qh76if0a04sj08k86amsq4h8cvpw6wvk76jahrzz"))

(define rust-usvg-0.46.0
  (crate-source "usvg" "0.46.0"
                "0vq7as3lwk8kcmab0znygwbg1gfz33rx5qz918mm24mv23qdy6g4"))

(define rust-utf8-iter-1.0.4
  (crate-source "utf8_iter" "1.0.4"
                "1gmna9flnj8dbyd8ba17zigrp9c4c3zclngf5lnb5yvz1ri41hdn"))

(define rust-utf8parse-0.2.2
  (crate-source "utf8parse" "0.2.2"
                "088807qwjq46azicqwbhlmzwrbkz7l4hpw43sdkdyyk524vdxaq6"))

(define rust-uuid-1.19.0
  (crate-source "uuid" "1.19.0"
                "0jjbclx3f36fjl6jjh8f022q0m76v3cfh61y6z6jgl2b3f359q72"))

(define rust-valuable-0.1.1
  (crate-source "valuable" "0.1.1"
                "0r9srp55v7g27s5bg7a2m095fzckrcdca5maih6dy9bay6fflwxs"))

(define rust-vcpkg-0.2.15
  (crate-source "vcpkg" "0.2.15"
                "09i4nf5y8lig6xgj3f7fyrvzd3nlaw4znrihw8psidvv5yk4xkdc"))

(define rust-version-check-0.9.5
  (crate-source "version_check" "0.9.5"
                "0nhhi4i5x89gm911azqbn7avs9mdacw2i3vcz3cnmz3mv4rqz4hb"))

(define rust-version-compare-0.2.1
  (crate-source "version-compare" "0.2.1"
                "03nziqxwnxlizl42cwsx33vi5xd2cf2jnszhh9rzay7g6xl8bhh3"))

(define rust-walkdir-2.5.0
  (crate-source "walkdir" "2.5.0"
                "0jsy7a710qv8gld5957ybrnc07gavppp963gs32xk4ag8130jy99"))

(define rust-want-0.3.1
  (crate-source "want" "0.3.1"
                "03hbfrnvqqdchb5kgxyavb9jabwza0dmh2vw5kg0dq8rxl57d9xz"))

(define rust-wasi-0.11.1+wasi-snapshot-preview1
  (crate-source "wasi" "0.11.1+wasi-snapshot-preview1"
                "0jx49r7nbkbhyfrfyhz0bm4817yrnxgd3jiwwwfv0zl439jyrwyc"))

(define rust-wasip2-1.0.2+wasi-0.2.9
  (crate-source "wasip2" "1.0.2+wasi-0.2.9"
                "1xdw7v08jpfjdg94sp4lbdgzwa587m5ifpz6fpdnkh02kwizj5wm"))

(define rust-wasm-bindgen-0.2.108
  (crate-source "wasm-bindgen" "0.2.108"
                "0rl5pn80sdhj2p2r28lp3k50a8mpppzgwzssz2f3jdqyxhq4l0k4"))

(define rust-wasm-bindgen-futures-0.4.58
  (crate-source "wasm-bindgen-futures" "0.4.58"
                "0vqywn9df5i6mms3sw47v3kj7rzx8ryghqq0xb4jk05fs1zyg9kh"))

(define rust-wasm-bindgen-macro-0.2.108
  (crate-source "wasm-bindgen-macro" "0.2.108"
                "026nnvakp0w6j3ghpcxn31shj9wx8bv8x7nk3gkk40klkjfj72q0"))

(define rust-wasm-bindgen-macro-support-0.2.108
  (crate-source "wasm-bindgen-macro-support" "0.2.108"
                "0m9sj475ypgifbkvksjsqs2gy3bq96f87ychch784m4gspiblmjj"))

(define rust-wasm-bindgen-shared-0.2.108
  (crate-source "wasm-bindgen-shared" "0.2.108"
                "04ix7v99rvj5730553j58pqsrwpf9sqazr60y3cchx5cr60ba08z"))

(define rust-wayland-backend-0.3.12
  (crate-source "wayland-backend" "0.3.12"
                "1yb4s5mbcis3z3gcmxq2lzgrcw2li7jsfr9ayi4gcsyrrja43rpy"))

(define rust-wayland-client-0.31.12
  (crate-source "wayland-client" "0.31.12"
                "1v1b2b2s0ld41psn3v2p3c6i590iz3r427czrf3c3dpv6yjzmrmq"))

(define rust-wayland-csd-frame-0.3.0
  (crate-source "wayland-csd-frame" "0.3.0"
                "0zjcmcqprfzx57hlm741n89ssp4sha5yh5cnmbk2agflvclm0p32"))

(define rust-wayland-cursor-0.31.12
  (crate-source "wayland-cursor" "0.31.12"
                "0y5hzl8z0da7sa2fg877bwl5mi56k15askmpx2qhcjq6nssw8r2q"))

(define rust-wayland-protocols-0.32.10
  (crate-source "wayland-protocols" "0.32.10"
                "1wzl7ly3ahi2y4swf8wmlqaj3gck4fpmwf6ymbfxd37wpkzskvds"))

(define rust-wayland-protocols-experimental-20250721.0.1
  (crate-source "wayland-protocols-experimental" "20250721.0.1"
                "1cfbimd2qbbcgv21i3l7kq3pm6lvrjbb7d6pj33sxjld29izi8a0"))

(define rust-wayland-protocols-misc-0.3.10
  (crate-source "wayland-protocols-misc" "0.3.10"
                "0kn3nk770vf29d227d8r88rpzr6i4x9q3pb9f6inlh65xvymh73r"))

(define rust-wayland-protocols-wlr-0.3.10
  (crate-source "wayland-protocols-wlr" "0.3.10"
                "1ws5fd7qs5vf3digbnn20n7mks2sdg76sy13b36k836g0bgpqng9"))

(define rust-wayland-scanner-0.31.8
  (crate-source "wayland-scanner" "0.31.8"
                "1qw971z9jcxdw8s371gx2anmwb95m59y38q3k11qxrk3d95yj8sl"))

(define rust-wayland-sys-0.31.8
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "wayland-sys" "0.31.8"
                "1zdxrcl8paklwir0lag1i80k6h0iq1f80d925b4p9yaymk1vyv8y"))

(define rust-wayle-audio-0.1.2
  (crate-source "wayle-audio" "0.1.2"
                "1pz2l1aqfr1aj4jklmv2ck1m3vbky0if3j3niqq0cinlv6d5qgz9"))

(define rust-wayle-battery-0.1.2
  (crate-source "wayle-battery" "0.1.2"
                "1cvvddv46y2sjrblhsxyi78vyl0292ajan69kgpw0sl4m5l4wk58"))

(define rust-wayle-bluetooth-0.1.2
  (crate-source "wayle-bluetooth" "0.1.2"
                "12k5cpkzhl3c94zxwmdyarp6ya3fnqplvzbm4rr6b1mlgkd0b8rm"))

(define rust-wayle-brightness-0.1.2
  (crate-source "wayle-brightness" "0.1.2"
                "1pg37m53pk3nqb5kmvm5gvq77vpyif5ac6svcsjr66xvi68sb4mg"))

(define rust-wayle-cava-0.1.2
  (crate-source "wayle-cava" "0.1.2"
                "1i91ph2d5xbnwlbxynxh5k7d4ikypjjz4fp47mpavfhyl4hzwyh4"))

(define rust-wayle-core-0.1.2
  (crate-source "wayle-core" "0.1.2"
                "04z5h6p1gz132da0nm9lmhxs776dx13iipz2prgk0hs0bls0jwc6"))

(define rust-wayle-hyprland-0.1.2
  (crate-source "wayle-hyprland" "0.1.2"
                "1x2vr1mwi4alz4wjcygzwbq5a05x4hvn4hsh1v3br1fhfxgyqvfj"))

(define rust-wayle-media-0.1.2
  (crate-source "wayle-media" "0.1.2"
                "1h4zsxarpx5lwiryn1jrjr4l8knk8jvpqkviil7cqvx8myna5g8b"))

(define rust-wayle-network-0.1.2
  (crate-source "wayle-network" "0.1.2"
                "0lnrq2fz4ba0hszf4cj2knwqxi9j6jpllplficmfqfp1qi0glkpr"))

(define rust-wayle-niri-0.1.0
  (crate-source "wayle-niri" "0.1.0"
                "1hv0pdlgqbzm3y6mx7fpxhmkfn4kf7nfmgj8d7rwf3pn1cl50l9c"))

(define rust-wayle-notification-0.1.3
  (crate-source "wayle-notification" "0.1.3"
                "06cw199bxgq1k8szb1rbhksz4c1j4rdwja99fzslrrgqh6q2zfp3"))

(define rust-wayle-power-profiles-0.1.2
  (crate-source "wayle-power-profiles" "0.1.2"
                "1xly97x401bgjyg27zgfly28xrz5llxpqqnbsn0iziq740vy9ag0"))

(define rust-wayle-sysinfo-0.1.2
  (crate-source "wayle-sysinfo" "0.1.2"
                "1nkd1dgn25c9257pzcy3lpk16bw9sy51azi163rx2j2knm7k2za5"))

(define rust-wayle-systray-0.1.3
  (crate-source "wayle-systray" "0.1.3"
                "0igiqskw3nimws6ix4i28kv8k6jip99q31ixi4d846vx7iiszf2s"))

(define rust-wayle-traits-0.1.2
  (crate-source "wayle-traits" "0.1.2"
                "0vcaf92kkmcq65789rf5kp4v3g9qnji7vw3drc1166j8sjd64cq8"))

(define rust-wayle-wallpaper-0.1.3
  (crate-source "wayle-wallpaper" "0.1.3"
                "1zly1g17khhhkxqg5k6axakvf0vjkfb87ifwdgbnm45azlqg8hkv"))

(define rust-wayle-weather-0.1.2
  (crate-source "wayle-weather" "0.1.2"
                "1d0kdxjaz2d771m51px2dawz7iqv9g1r8hbpl4601mfqwxalrbas"))

(define rust-web-sys-0.3.85
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "web-sys" "0.3.85"
                "1645c202gyw21m6kxw4ya81vrapl40hlb8m9iqhjj8fra7jk4bii"))

(define rust-web-time-1.1.0
  (crate-source "web-time" "1.1.0"
                "1fx05yqx83dhx628wb70fyy10yjfq1jpl20qfqhdkymi13rq0ras"))

(define rust-webpki-root-certs-1.0.5
  (crate-source "webpki-root-certs" "1.0.5"
                "1p05rj22vamgs9n34326vypxy3klmdbphqrjrxl3y4cb8309z8in"))

(define rust-wildcard-0.3.0
  (crate-source "wildcard" "0.3.0"
                "12ai7q3ypqdhghraavncx8y0j6657gfs0k9igj0y77g4j4759c7r"))

(define rust-winapi-0.3.9
  (crate-source "winapi" "0.3.9"
                "06gl025x418lchw1wxj64ycr7gha83m44cjr5sarhynd9xkrm0sw"))

(define rust-winapi-i686-pc-windows-gnu-0.4.0
  (crate-source "winapi-i686-pc-windows-gnu" "0.4.0"
                "1dmpa6mvcvzz16zg6d5vrfy4bxgg541wxrcip7cnshi06v38ffxc"))

(define rust-winapi-util-0.1.11
  (crate-source "winapi-util" "0.1.11"
                "08hdl7mkll7pz8whg869h58c1r9y7in0w0pk8fm24qc77k0b39y2"))

(define rust-winapi-x86-64-pc-windows-gnu-0.4.0
  (crate-source "winapi-x86_64-pc-windows-gnu" "0.4.0"
                "0gqq64czqb64kskjryj8isp62m2sgvx25yyj3kpc2myh85w24bki"))

(define rust-windows-0.57.0
  (crate-source "windows" "0.57.0"
                "0hqid10bqvxa3pbpgvrh2cilf950lxsd9zqfv3rldc73v2s2qd0j"))

(define rust-windows-aarch64-gnullvm-0.42.2
  (crate-source "windows_aarch64_gnullvm" "0.42.2"
                "1y4q0qmvl0lvp7syxvfykafvmwal5hrjb4fmv04bqs0bawc52yjr"))

(define rust-windows-aarch64-gnullvm-0.48.5
  (crate-source "windows_aarch64_gnullvm" "0.48.5"
                "1n05v7qblg1ci3i567inc7xrkmywczxrs1z3lj3rkkxw18py6f1b"))

(define rust-windows-aarch64-gnullvm-0.52.6
  (crate-source "windows_aarch64_gnullvm" "0.52.6"
                "1lrcq38cr2arvmz19v32qaggvj8bh1640mdm9c2fr877h0hn591j"))

(define rust-windows-aarch64-gnullvm-0.53.1
  (crate-source "windows_aarch64_gnullvm" "0.53.1"
                "0lqvdm510mka9w26vmga7hbkmrw9glzc90l4gya5qbxlm1pl3n59"))

(define rust-windows-aarch64-msvc-0.42.2
  (crate-source "windows_aarch64_msvc" "0.42.2"
                "0hsdikjl5sa1fva5qskpwlxzpc5q9l909fpl1w6yy1hglrj8i3p0"))

(define rust-windows-aarch64-msvc-0.48.5
  (crate-source "windows_aarch64_msvc" "0.48.5"
                "1g5l4ry968p73g6bg6jgyvy9lb8fyhcs54067yzxpcpkf44k2dfw"))

(define rust-windows-aarch64-msvc-0.52.6
  (crate-source "windows_aarch64_msvc" "0.52.6"
                "0sfl0nysnz32yyfh773hpi49b1q700ah6y7sacmjbqjjn5xjmv09"))

(define rust-windows-aarch64-msvc-0.53.1
  (crate-source "windows_aarch64_msvc" "0.53.1"
                "01jh2adlwx043rji888b22whx4bm8alrk3khjpik5xn20kl85mxr"))

(define rust-windows-core-0.57.0
  (crate-source "windows-core" "0.57.0"
                "0bc3jxw2jw76xkk3ddvnp5b2m76qmbzv1qncgvb6qrlhl8wj9vfj"))

(define rust-windows-core-0.62.2
  (crate-source "windows-core" "0.62.2"
                "1swxpv1a8qvn3bkxv8cn663238h2jccq35ff3nsj61jdsca3ms5q"))

(define rust-windows-i686-gnu-0.42.2
  (crate-source "windows_i686_gnu" "0.42.2"
                "0kx866dfrby88lqs9v1vgmrkk1z6af9lhaghh5maj7d4imyr47f6"))

(define rust-windows-i686-gnu-0.48.5
  (crate-source "windows_i686_gnu" "0.48.5"
                "0gklnglwd9ilqx7ac3cn8hbhkraqisd0n83jxzf9837nvvkiand7"))

(define rust-windows-i686-gnu-0.52.6
  (crate-source "windows_i686_gnu" "0.52.6"
                "02zspglbykh1jh9pi7gn8g1f97jh1rrccni9ivmrfbl0mgamm6wf"))

(define rust-windows-i686-gnu-0.53.1
  (crate-source "windows_i686_gnu" "0.53.1"
                "18wkcm82ldyg4figcsidzwbg1pqd49jpm98crfz0j7nqd6h6s3ln"))

(define rust-windows-i686-gnullvm-0.52.6
  (crate-source "windows_i686_gnullvm" "0.52.6"
                "0rpdx1537mw6slcpqa0rm3qixmsb79nbhqy5fsm3q2q9ik9m5vhf"))

(define rust-windows-i686-gnullvm-0.53.1
  (crate-source "windows_i686_gnullvm" "0.53.1"
                "030qaxqc4salz6l4immfb6sykc6gmhyir9wzn2w8mxj8038mjwzs"))

(define rust-windows-i686-msvc-0.42.2
  (crate-source "windows_i686_msvc" "0.42.2"
                "0q0h9m2aq1pygc199pa5jgc952qhcnf0zn688454i7v4xjv41n24"))

(define rust-windows-i686-msvc-0.48.5
  (crate-source "windows_i686_msvc" "0.48.5"
                "01m4rik437dl9rdf0ndnm2syh10hizvq0dajdkv2fjqcywrw4mcg"))

(define rust-windows-i686-msvc-0.52.6
  (crate-source "windows_i686_msvc" "0.52.6"
                "0rkcqmp4zzmfvrrrx01260q3xkpzi6fzi2x2pgdcdry50ny4h294"))

(define rust-windows-i686-msvc-0.53.1
  (crate-source "windows_i686_msvc" "0.53.1"
                "1hi6scw3mn2pbdl30ji5i4y8vvspb9b66l98kkz350pig58wfyhy"))

(define rust-windows-implement-0.57.0
  (crate-source "windows-implement" "0.57.0"
                "1mqs7qypclnmx5r8yq5jy3g2d8i27vzag9yzzzxzpdnmb70ds1wi"))

(define rust-windows-implement-0.60.2
  (crate-source "windows-implement" "0.60.2"
                "1psxhmklzcf3wjs4b8qb42qb6znvc142cb5pa74rsyxm1822wgh5"))

(define rust-windows-interface-0.57.0
  (crate-source "windows-interface" "0.57.0"
                "19zwlzr0q1z9s692681yb5w2lhvwcyx4v95s25hfdkd3isry9gi9"))

(define rust-windows-interface-0.59.3
  (crate-source "windows-interface" "0.59.3"
                "0n73cwrn4247d0axrk7gjp08p34x1723483jxjxjdfkh4m56qc9z"))

(define rust-windows-link-0.2.1
  (crate-source "windows-link" "0.2.1"
                "1rag186yfr3xx7piv5rg8b6im2dwcf8zldiflvb22xbzwli5507h"))

(define rust-windows-result-0.1.2
  (crate-source "windows-result" "0.1.2"
                "1y274q1v0vy21lhkgslpxpq1m08hvr1mcs2l88h1b1gcx0136f2y"))

(define rust-windows-result-0.4.1
  (crate-source "windows-result" "0.4.1"
                "1d9yhmrmmfqh56zlj751s5wfm9a2aa7az9rd7nn5027nxa4zm0bp"))

(define rust-windows-strings-0.5.1
  (crate-source "windows-strings" "0.5.1"
                "14bhng9jqv4fyl7lqjz3az7vzh8pw0w4am49fsqgcz67d67x0dvq"))

(define rust-windows-sys-0.45.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "windows-sys" "0.45.0"
                "1l36bcqm4g89pknfp8r9rl1w4bn017q6a8qlx8viv0xjxzjkna3m"))

(define rust-windows-sys-0.48.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "windows-sys" "0.48.0"
                "1aan23v5gs7gya1lc46hqn9mdh8yph3fhxmhxlw36pn6pqc28zb7"))

(define rust-windows-sys-0.52.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "windows-sys" "0.52.0"
                "0gd3v4ji88490zgb6b5mq5zgbvwv7zx1ibn8v3x83rwcdbryaar8"))

(define rust-windows-sys-0.60.2
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "windows-sys" "0.60.2"
                "1jrbc615ihqnhjhxplr2kw7rasrskv9wj3lr80hgfd42sbj01xgj"))

(define rust-windows-sys-0.61.2
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "windows-sys" "0.61.2"
                "1z7k3y9b6b5h52kid57lvmvm05362zv1v8w0gc7xyv5xphlp44xf"))

(define rust-windows-targets-0.42.2
  (crate-source "windows-targets" "0.42.2"
                "0wfhnib2fisxlx8c507dbmh97kgij4r6kcxdi0f9nk6l1k080lcf"))

(define rust-windows-targets-0.48.5
  (crate-source "windows-targets" "0.48.5"
                "034ljxqshifs1lan89xwpcy1hp0lhdh4b5n0d2z4fwjx2piacbws"))

(define rust-windows-targets-0.52.6
  (crate-source "windows-targets" "0.52.6"
                "0wwrx625nwlfp7k93r2rra568gad1mwd888h1jwnl0vfg5r4ywlv"))

(define rust-windows-targets-0.53.5
  (crate-source "windows-targets" "0.53.5"
                "1wv9j2gv3l6wj3gkw5j1kr6ymb5q6dfc42yvydjhv3mqa7szjia9"))

(define rust-windows-x86-64-gnu-0.42.2
  (crate-source "windows_x86_64_gnu" "0.42.2"
                "0dnbf2xnp3xrvy8v9mgs3var4zq9v9yh9kv79035rdgyp2w15scd"))

(define rust-windows-x86-64-gnu-0.48.5
  (crate-source "windows_x86_64_gnu" "0.48.5"
                "13kiqqcvz2vnyxzydjh73hwgigsdr2z1xpzx313kxll34nyhmm2k"))

(define rust-windows-x86-64-gnu-0.52.6
  (crate-source "windows_x86_64_gnu" "0.52.6"
                "0y0sifqcb56a56mvn7xjgs8g43p33mfqkd8wj1yhrgxzma05qyhl"))

(define rust-windows-x86-64-gnu-0.53.1
  (crate-source "windows_x86_64_gnu" "0.53.1"
                "16d4yiysmfdlsrghndr97y57gh3kljkwhfdbcs05m1jasz6l4f4w"))

(define rust-windows-x86-64-gnullvm-0.42.2
  (crate-source "windows_x86_64_gnullvm" "0.42.2"
                "18wl9r8qbsl475j39zvawlidp1bsbinliwfymr43fibdld31pm16"))

(define rust-windows-x86-64-gnullvm-0.48.5
  (crate-source "windows_x86_64_gnullvm" "0.48.5"
                "1k24810wfbgz8k48c2yknqjmiigmql6kk3knmddkv8k8g1v54yqb"))

(define rust-windows-x86-64-gnullvm-0.52.6
  (crate-source "windows_x86_64_gnullvm" "0.52.6"
                "03gda7zjx1qh8k9nnlgb7m3w3s1xkysg55hkd1wjch8pqhyv5m94"))

(define rust-windows-x86-64-gnullvm-0.53.1
  (crate-source "windows_x86_64_gnullvm" "0.53.1"
                "1qbspgv4g3q0vygkg8rnql5c6z3caqv38japiynyivh75ng1gyhg"))

(define rust-windows-x86-64-msvc-0.42.2
  (crate-source "windows_x86_64_msvc" "0.42.2"
                "1w5r0q0yzx827d10dpjza2ww0j8iajqhmb54s735hhaj66imvv4s"))

(define rust-windows-x86-64-msvc-0.48.5
  (crate-source "windows_x86_64_msvc" "0.48.5"
                "0f4mdp895kkjh9zv8dxvn4pc10xr7839lf5pa9l0193i2pkgr57d"))

(define rust-windows-x86-64-msvc-0.52.6
  (crate-source "windows_x86_64_msvc" "0.52.6"
                "1v7rb5cibyzx8vak29pdrk8nx9hycsjs4w0jgms08qk49jl6v7sq"))

(define rust-windows-x86-64-msvc-0.53.1
  (crate-source "windows_x86_64_msvc" "0.53.1"
                "0l6npq76vlq4ksn4bwsncpr8508mk0gmznm6wnhjg95d19gzzfyn"))

(define rust-winnow-0.7.14
  (crate-source "winnow" "0.7.14"
                "0a88ahjqhyn2ln1yplq2xsigm09kxqkdkkk2c2mfxkbzszln8lss"))

(define rust-winnow-1.0.3
  (crate-source "winnow" "1.0.3"
                "1wajycd3krn6h699vydjv7hm0ll5l31p899qzpk59y2is74y34h5"))

(define rust-wit-bindgen-0.51.0
  (crate-source "wit-bindgen" "0.51.0"
                "19fazgch8sq5cvjv3ynhhfh5d5x08jq2pkw8jfb05vbcyqcr496p"))

(define rust-writeable-0.6.2
  (crate-source "writeable" "0.6.2"
                "1fg08y97n6vk7l0rnjggw3xyrii6dcqg54wqaxldrlk98zdy1pcy"))

(define rust-wyz-0.5.1
  (crate-source "wyz" "0.5.1"
                "1vdrfy7i2bznnzjdl9vvrzljvs4s3qm8bnlgqwln6a941gy61wq5"))

(define rust-xcursor-0.3.10
  (crate-source "xcursor" "0.3.10"
                "0awgy98awg4ydcfmynqfcwvl4bnnfcm4i2vvnk2n926a02jy9jdy"))

(define rust-xkbcommon-0.8.0
  (crate-source "xkbcommon" "0.8.0"
                "1j8s1sfwc6bw9phsca65rw3q3b5l2651v1s0pk5yxm6baa9wlrld"))

(define rust-xkeysym-0.2.1
  (crate-source "xkeysym" "0.2.1"
                "0mksx670cszyd7jln6s7dhkw11hdfv7blwwr3isq98k22ljh1k5r"))

(define rust-xml-rs-0.8.28
  (crate-source "xml-rs" "0.8.28"
                "0grdj7xwbki5zrkalrg8dljyf14y4yj3wrj34sbzqp06i9zk7s1s"))

(define rust-xmlwriter-0.1.0
  (crate-source "xmlwriter" "0.1.0"
                "1fg0ldmkgiis6hnxpi1c9gy7v23y0lpi824bp8yp12fi3r82lypc"))

(define rust-yoke-0.8.1
  (crate-source "yoke" "0.8.1"
                "0m29dm0bf5iakxgma0bj6dbmc3b8qi9b1vaw9sa76kdqmz3fbmkj"))

(define rust-yoke-derive-0.8.1
  (crate-source "yoke-derive" "0.8.1"
                "0pbyja133jnng4mrhimzdq4a0y26421g734ybgz8wsgbfhl0andn"))

(define rust-zbus-5.13.2
  (crate-source "zbus" "5.13.2"
                "1ldxqkwy577n7w5ss3lshg9adpyji3vvllj61jr3xahagaczzzhv"))

(define rust-zbus-macros-5.13.2
  (crate-source "zbus_macros" "5.13.2"
                "1wa6z2gzpzna0mww9jj9db9cq573g914ix6y2ddyxzp8vf85mg8b"))

(define rust-zbus-names-4.3.1
  (crate-source "zbus_names" "4.3.1"
                "03y5f8xwzmk4y5wb4g95a1hl48mxlmhcbwqz62mrnqbqbdnszn7z"))

(define rust-zerocopy-0.8.33
  (crate-source "zerocopy" "0.8.33"
                "1z9d6z8p1ndf0yrvw99jr5zcjnd4270kv4rivqqyi7hbs5l533v6"))

(define rust-zerocopy-derive-0.8.33
  (crate-source "zerocopy-derive" "0.8.33"
                "1wbh4bil3kqfmiwxlpzhxba6fyh09nsy87k7idk8b1hadfr64y9c"))

(define rust-zerofrom-0.1.6
  (crate-source "zerofrom" "0.1.6"
                "19dyky67zkjichsb7ykhv0aqws3q0jfvzww76l66c19y6gh45k2h"))

(define rust-zerofrom-derive-0.1.6
  (crate-source "zerofrom-derive" "0.1.6"
                "00l5niw7c1b0lf1vhvajpjmcnbdp2vn96jg4nmkhq2db0rp5s7np"))

(define rust-zeroize-1.8.2
  (crate-source "zeroize" "1.8.2"
                "1l48zxgcv34d7kjskr610zqsm6j2b4fcr2vfh9jm9j1jgvk58wdr"))

(define rust-zerotrie-0.2.3
  (crate-source "zerotrie" "0.2.3"
                "0lbqznlqazmrwwzslw0ci7p3pqxykrbfhq29npj0gmb2amxc2n9a"))

(define rust-zerovec-0.11.5
  (crate-source "zerovec" "0.11.5"
                "00m0p47k2g9mkv505hky5xh3r6ps7v8qc0dy4pspg542jj972a3c"))

(define rust-zerovec-derive-0.11.2
  (crate-source "zerovec-derive" "0.11.2"
                "1wsig4h5j7a1scd5hrlnragnazjny9qjc44hancb6p6a76ay7p7a"))

(define rust-zmij-1.0.16
  (crate-source "zmij" "1.0.16"
                "0r8swld9cwnyvdfamq4063ngwxdzckg4922ayk7likma4mc19kfz"))

(define rust-zvariant-5.9.2
  (crate-source "zvariant" "5.9.2"
                "1i1jn8lvsj79lnfyw21lrsimg2jj0gfj6w6wglrm2y8cyks4xdk8"))

(define rust-zvariant-derive-5.9.2
  (crate-source "zvariant_derive" "5.9.2"
                "0p21bv2kzphhcc71597ya3b0m8hr6wyw2adrqqnbbbxpbsbmska8"))

(define rust-zvariant-utils-3.3.0
  (crate-source "zvariant_utils" "3.3.0"
                "1sf5i71in36gc08jhak83pprnkam8gk936cqlq9hzx7q9sk26p7p"))


(define-public dotenvy
  (package
    (name "dotenvy")
    (version "0.15.7")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "dotenvy" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "16s3n973n5aqym02692i1npb079n5mb0fwql42ikmwn8wnrrbbqs"))))
    (build-system cargo-build-system)
    (inputs (cargo-inputs 'dotenvy))
    (home-page "https://github.com/allan2/dotenvy")
    (synopsis "well-maintained fork of the dotenv crate")
    (description
     "This package provides a well-maintained fork of the dotenv crate.")
    (license license:expat)))

