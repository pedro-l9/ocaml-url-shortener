(lang dune 2.9)

(generate_opam_files true)

(name url_shortener)

(license ISC)

(authors "Pedro Lacerda")

(maintainers "me@placerda.dev")

(package
 (name url_shortener)
 (synopsis "URL shortener")
 (depends
  (ocaml
   (>= 4.08))
  (dune
   (>= 2.9))
  lwt
  cohttp-lwt-unix
  jwt
  (alcotest :with-test)))
