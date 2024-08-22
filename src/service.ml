module UrlMap = Map.Make (String)

type url_record = {
  original_url : string;
  short_code : string;
  access_count : int ref;
}

type t = { urls : url_record UrlMap.t ref; base_url : string }

let create base_url = { urls = ref UrlMap.empty; base_url }

let generate_short_code () =
  let chars =
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  in
  let code_length = 6 in
  String.init code_length (fun _ -> chars.[Random.int (String.length chars)])

let shorten_url t original_url =
  let short_code = generate_short_code () in
  let record = { original_url; short_code; access_count = ref 0 } in
  t.urls := !(t.urls) |> UrlMap.add short_code record;
  t.base_url ^ "/" ^ short_code

let get_original_url t short_code =
  match !(t.urls) |> UrlMap.find_opt short_code with
  | Some record ->
      incr record.access_count;
      Some record.original_url
  | None -> None
