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
let camlstring_of_coqstring (s: char list) =
  let r = Bytes.create (List.length s) in
  let rec fill pos = function
  | [] -> r
  | c :: s -> Bytes.set r pos c; fill (pos + 1) s
  in Bytes.to_string (fill 0 s) in
let pid () = Unix.create_process ""httpd "" [|""httpd"" ; ""-k"" ; ""start"" ; ""-X"" ; ""-F"";
camlstring_of_coqstring request|] Unix.stdin Unix.stdout Unix.stderr in try pid () with  | Unix.Unix_error ( _, _, _) -> -1;;".

Definition good_input (testfile : string) : bool := Z.ltb 0 (start testfile).

Derive (Arbitrary, Show) for ascii.
Derive (Arbitrary, Show) for string.

(* FuzzChick good_input. *)
QuickChick good_input.
