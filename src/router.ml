open Lwt
open Cohttp_lwt_unix
open Service

let handle_home () = Server.respond_string ~status:`OK ~body:"URL Shortener" ()

let handle_shorten t body =
  ( body |> Cohttp_lwt.Body.to_string >|= fun body ->
    let original_url = Uri.of_string body |> Uri.to_string in
    let short_url = shorten_url t original_url in
    short_url )
  >>= fun short_url -> Server.respond_string ~status:`OK ~body:short_url ()

let access_url t path =
  let short_code = String.sub path 1 (String.length path - 1) in
  match get_original_url t short_code with
  | Some original_url ->
      Server.respond_redirect ~uri:(Uri.of_string original_url) ()
  | None ->
      Server.respond_string ~status:`Not_found ~body:"Short URL not found" ()

let handle_not_found () =
  Server.respond_string ~status:`Not_found ~body:"Not found" ()

let handle_request t _conn req body =
  match (req |> Request.meth, req |> Request.uri |> Uri.path) with
  | `GET, "/" -> handle_home ()
  | `POST, "/shorten" -> handle_shorten t body
  | `GET, path -> access_url t path
  | _ -> handle_not_found ()
