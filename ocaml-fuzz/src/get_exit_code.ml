open Unix

let start =  fun request ->
let camlstring_of_coqstring (s: char list) =
  let r = Bytes.create (List.length s) in
  let rec fill pos = function
  | [] -> r
  | c :: s -> Bytes.set r pos c; fill (pos + 1) s
  in Bytes.to_string (fill 0 s) in
let pid () = Unix.create_process "httpd" [|"httpd";"-k" ; "start" ; "-X" ; "-F" ;
camlstring_of_coqstring request|] Unix.stdin Unix.stdout Unix.stderr in
 pid () ; match Unix.wait () with
| ( _, WEXITED 0 ) -> 1
| ( _, WEXITED 1 ) -> -1
| ( _, WEXITED a ) -> a
| _ -> -2

let coqstring_of_camlstring s =
  let rec cstring accu pos =
    if pos < 0 then accu else cstring (s.[pos] :: accu) (pos - 1)
  in cstring [] (String.length s - 1)

let main =
  let test_name = "./input/GET_test" in
  print_endline( string_of_int (start ( coqstring_of_camlstring test_name ) ))
