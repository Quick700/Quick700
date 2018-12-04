open Unix

let start =  fun request ->
let camlstring_of_coqstring (s: char list) =
  let r = Bytes.create (List.length s) in
  let rec fill pos = function
  | [] -> r
  | c :: s -> Bytes.set r pos c; fill (pos + 1) s
  in Bytes.to_string (fill 0 s) in
let pid () = Unix.create_process "/root/apache_clean/bin/httpd " [|"/root/apache_clean/bin/httpd" ; "-k" ; "start" ; "-D" ; "fuzz";  "-d" ;"."; "-f";
camlstring_of_coqstring request|] Unix.stdin Unix.stdout Unix.stderr in
try pid () with
| Unix.Unix_error ( _, _, _) -> -1;;

let coqstring_of_camlstring s =
  let rec cstring accu pos =
    if pos < 0 then accu else cstring (s.[pos] :: accu) (pos - 1)
  in cstring [] (String.length s - 1)

let main =
  let test_name = "Gvacip" in
  print_endline( string_of_int (start ( coqstring_of_camlstring test_name ) ))
