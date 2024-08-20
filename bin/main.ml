open Cohttp_lwt_unix

let start_server t port =
  let callback = Url_shortener.handle_request t in
  let server =
    Server.create ~mode:(`TCP (`Port port)) (Server.make ~callback ())
  in
  Lwt_main.run server

let () =
  let base_url = "http://localhost:8080" in
  let shortener = Url_shortener.create base_url in
  Printf.printf "Starting server on %s\n" base_url;
  start_server shortener 8080
