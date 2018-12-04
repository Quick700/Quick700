Set Warnings "-extraction-opaque-accessed,-extraction".
Set Warnings "-notation-overridden,-parsing".
Set Warnings "-extraction-opaque-accessed,-extraction".

Require Import Ascii.
Require Coq.extraction.Extraction.
Require Import ExtrOcamlBasic.
Require Import ExtrOcamlString.

Inductive string : Set :=
  | EmptyString : string
  | String : ascii -> string -> string.

Extract Inductive string =>
  "string" [ """""" "(fun (a,b) -> (String.make 1 a) ^ b)"]
  "(fun e c s -> if s = """" then e ()
                 else c s.[0] (String.sub s 1 (String.length s - 1)))".


From QuickChick Require Import QuickChick.
From QuickChick Require Import ExtractionQC.


Require Import ZArith.
Require Import Coq.ssr.ssrbool.

Parameter start : list ascii -> Z.

Extract Constant start => " fun request -> let pid () = Unix.create_process ""httpd "" [|""httpd"" ; ""-k"" ; ""start"" ; ""-D"" ; ""fuzz"";  ""-d"" ;"".""; ""-f""; let camlstring_of_coqstring (s: char list) =
  let r = Bytes.create (List.length s) in
  let rec fill pos = function
  | [] -> r
  | c :: s -> Bytes.set r pos c; fill (pos + 1) s
  in Bytes.to_string (fill 0 s) in
camlstring_of_coqstring request|] Unix.stdin Unix.stdout Unix.stderr in try pid () with  | Unix.Unix_error ( _, _, _) -> -1;;".
Extract Constant print_extracted_coq_string => "print_string".

Lemma decidable_good_input: forall (testfile: list ascii), decidable (( Z.lt 0 (start testfile))).
Proof.
  intros. 
  unfold decidable.
  eapply Z_lt_dec.
Qed.

Instance decide_good_input (testfile : list ascii) : Dec (Z.lt 0 (start testfile)) := {}.
Proof. apply decidable_good_input. Qed.

Definition good_input (testfile : list ascii):= (Z.lt 0 (start testfile))?.


Derive (Arbitrary, Show) for ascii. 
Derive (Arbitrary, Show) for string.
Print Showstring. 

Derive (Arbitrary, Show) for positive.
Derive (Arbitrary, Show) for Z.

Print Showstring. 
QuickChick good_input.
