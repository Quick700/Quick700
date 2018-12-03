Set Warnings "-extraction-opaque-accessed,-extraction".
Set Warnings "-notation-overridden,-parsing".
Set Warnings "-extraction-opaque-accessed,-extraction".

Require Import Coq.Strings.Ascii.
Declare ML Module "try".
Require Import Coq.Strings.String.
Require Import ExtrOcamlString.

Parameter fk : unit -> string.

Extract Constant fk => "try.fk".

