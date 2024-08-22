let () =
  let open Url_shortener in
  let open Alcotest in
  run "Url_shortener"
    [
      ( "generate_short_code",
        [ test_case "Assert short code length" `Quick test_shortcode ] );
      ( "shorten_url",
        [
          test_case "Create a new short URL" `Quick test_shorten_url;
          test_case "Create two short URLs" `Quick test_shorten_urls;
        ] );
    ]
