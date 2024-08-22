let base_url, original_url = ("http://localhost:8080", "https://x.com")

(* Utils *)

let get_code_from_url url =
  let path = url |> Uri.of_string |> Uri.path in
  String.sub path 1 (String.length path - 1)

(* Tests *)

let test_shortcode () =
  Alcotest.(check int)
    "Shortcode size" 6
    (Url_shortener__Service.generate_short_code () |> String.length)

let test_shorten_url () =
  let open Url_shortener__Service in
  let t = create base_url in
  let short_url = shorten_url t original_url in

  match !(t.urls) |> UrlMap.find_opt (get_code_from_url short_url) with
  | Some record ->
      Alcotest.(check string) "Original URL" original_url record.original_url;
      Alcotest.(check int) "Access count" 0 !(record.access_count)
  | None -> Alcotest.fail "URL not found"

let test_shorten_urls () =
  let open Url_shortener__Service in
  let t = create base_url in
  let short_url1 = shorten_url t original_url in
  let short_url2 = shorten_url t original_url in

  Alcotest.(check bool)
    "Short URLs are different" true (short_url1 <> short_url2)
