type filetype = {
  syntax : Colormap.ctx -> Lexing.lexbuf -> unit;
  names : string list;
  exts : string list;
}

let filetypes = [
  {
    syntax = Lex_cpp.scan;
    names  = [];
    exts   = [".c"; ".h"; ".cpp"; ".hpp"; ".cc"; ".c++"; ".cxx"]
  };
  {
    syntax = Lex_ruby.scan;
    names  = ["Rakefile"; "rakefile"; "gpkgfile"];
    exts   = [".rb"]
  };
  {
    syntax = Lex_ocaml.scan;
    names  = [];
    exts   = [".ml"; ".mll"; ".mli"]
  }
]

let pick_syntax path =
  let name = Filename.basename path in
  let ext = Filename.extension path in
  let match_ftype ftype =
    (List.exists ((=) name) ftype.names) ||
    (List.exists ((=) ext) ftype.exts)
  in
  (List.find_opt match_ftype filetypes)

let rec scan_string lexfn string =
  let lbuf = Lexing.from_string string in
  let ctx = Colormap.({ lbuf = lbuf; pos = 0; }) in
  try while true do lexfn ctx lbuf done
  with Colormap.Eof ->
    Printf.printf "0,0,0\n";
    flush stdout;
    scan_input lexfn

and scan_input lexfn =
  try
    scan_string lexfn (really_input_string stdin (read_int ()));
  with
  | Failure _ -> scan_input lexfn
  | End_of_file -> ()

let () =
  if (Array.length Sys.argv) >= 2 then
  match pick_syntax Sys.argv.(1) with
  | Some ft -> scan_input ft.syntax
  | None -> ()
