Set Warnings "-extraction-opaque-accessed,-extraction".
Set Warnings "-notation-overridden,-parsing".
Set Warnings "-extraction-opaque-accessed,-extraction".

Require Import Ascii String.
Require Coq.extraction.Extraction.
Require Import ExtrOcamlBasic.
Require Import ExtrOcamlString.

From QuickChick Require Import QuickChick.
From QuickChick Require Import ExtractionQC.

Require Import ZArith.
Require Import Coq.ssr.ssrbool.

Parameter start : string -> Z.

Extract Constant start => " fun request ->
let camlstring_of_coqstring (s: char list) : string =
  let r = Bytes.create (List.length s) in
  let rec fill pos = function
  | [] -> r
  | c :: s -> Bytes.set r pos c; fill (pos + 1) s
  in Bytes.to_string (fill 0 s) in
  
let coqstring_of_camlstring (s : string) : char list =
  let rec cstring accu pos =
    if pos < 0 then accu else cstring (s.[pos] :: accu) (pos - 1)
  in cstring [] (String.length s - 1) in

let stdout_res = Unix.open_process_in
( String.concat """" [ "" httpd -k start -F "" ; (camlstring_of_coqstring request) ] ) in
let response = Stdio.In_channel.input_lines stdout_res in
Stdio.In_channel.close stdout_res; coqstring_of_camlstring (String.concat "" "" response)
".

Definition good_input (testfile : string) : bool := Z.ltb 0 (start testfile).

Derive (Arbitrary, Show) for ascii.
Derive (Arbitrary, Show) for string.

(* FuzzChick good_input. *)
QuickChick good_input.
