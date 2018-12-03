open Unix

let pid = Unix.create_process "httpd" [|"httpd -k start -D fuzz -d ."|] Unix.stdin Unix.stdout Unix.stderr
let pt = Printf.printf "pid is: %d" pid

(*
let fk =
  match Unix.fork () with
    0  -> let apache = Unix.execvp "httpd -k start -D fuzz -d ." in
              ( apache ;
              Printf.printf "I am the child: %d\n" (Unix.getpid ()))
    | pid -> Printf.printf "I am the father: %d of child: %d\n"
                       (Unix.getpid ()) pid ;;
*)
