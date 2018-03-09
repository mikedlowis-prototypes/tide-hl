
(*
let make lexer =
  let ctx = { lbuf = lexer.lexbuf; pos = 0; } in
  (try while true do lexer.scanfn ctx lexer.lexbuf done
   with Eof -> ());
*)

while true do
  try
    let chunk = really_input_string stdin (read_int ()) in
    Printf.printf "chunk: '%s'\n" chunk;
    flush stdout
  with
    | Failure _ -> ()
    | End_of_file -> exit 0
done
