open Cohttp_lwt_unix

let start_server base_url port =
  let shortener = Service.create base_url in
  let callback = Router.handle_request shortener in
  let server =
    Server.create ~mode:(`TCP (`Port port)) (Server.make ~callback ())
  in
  Lwt_main.run server
