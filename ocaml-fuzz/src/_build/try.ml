open Unix
open Stdio
open Base

(* The multiplex function takes a descriptor open on the serial
   port and two arrays of descriptors of the same size, one containing
   pipes connected to the standard input of the user processes, the other
   containing pipes connected to their standard output. *)
  
let start =  fun request ->
let camlstring_of_coqstring (s: char list) =
  let r = Bytes.create (List.length s) in
  let rec fill pos = function
  | [] -> r
  | c :: s -> Bytes.set r pos c; fill (pos + 1) s
  in Bytes.to_string (fill 0 s) in
  
let coqstring_of_camlstring s =
  let rec cstring accu pos =
    if pos < 0 then accu else cstring (s.[pos] :: accu) (pos - 1)
  in cstring [] (String.length s - 1) in

let stdout_res = open_process_in ( String.concat [ "httpd -k start -F " ; (camlstring_of_coqstring request) ] ) in
let response = In_channel.input_lines stdout_res in
In_channel.close stdout_res; coqstring_of_camlstring (String.concat ~sep:" " response) ;;

(*
pid () ;
let in_chan1 = Unix.in_channel_of_descr Unix.stdout in
let in_chan2 = Unix.in_channel_of_descr Unix.stderr in
let std_output = In_channel.input_all in_chan1 in
let std_err = In_channel.input_all in_chan2 in
match Unix.wait () with
| ( _, WEXITED 0 ) -> In_channel.close in_chan1 ; In_channel.close in_chan2 ; (0, std_output)
| ( _, WEXITED 1 ) -> In_channel.close in_chan1 ; In_channel.close in_chan2 ; (-1, std_err)
| ( _, WEXITED a ) -> In_channel.close in_chan1 ; In_channel.close in_chan2 ; (a, std_err )
| _ -> (-2, std_err )
*)

let coqstring_of_camlstring s =
  let rec cstring accu pos =
    if pos < 0 then accu else cstring (s.[pos] :: accu) (pos - 1)
    in cstring [] (String.length s - 1) ;;

let camlstring_of_coqstring (s: char list) =
  let r = Bytes.create (List.length s) in
  let rec fill pos = function
  | [] -> r
  | c :: s -> Bytes.set r pos c; fill (pos + 1) s
  in Bytes.to_string (fill 0 s) ;;
  
let main =
  let test_name = "./input/GET_test" in
  let s = start ( coqstring_of_camlstring test_name ) in
  print_string ( camlstring_of_coqstring s ) ;;
