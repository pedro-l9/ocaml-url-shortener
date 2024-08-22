let () =
  let base_url = "http://localhost:8080" in
  Printf.printf "Starting server on %s\n" base_url;
  Url_shortener.start_server base_url 8080
