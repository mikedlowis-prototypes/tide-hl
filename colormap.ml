open Lexing

exception Eof

type style = Normal | Comment | Constant | Keyword | Type | PreProcessor

module Span = struct
  type t = { start : int; stop : int; style : int }
  let compare a b =
    if a.stop < b.start then -1
    else if a.start > b.stop then 1
    else 0
end

type ctx = {
  lbuf : lexbuf;
  mutable pos : int;
}

type lexer = {
  scanfn : ctx -> Lexing.lexbuf -> unit;
  lexbuf : Lexing.lexbuf
}

let get_color = function
  | Normal       -> 0
  | Comment      -> 1
  | Constant     -> 2
  | Keyword      -> 3
  | Type         -> 4
  | PreProcessor -> 5

let set_color ctx clr =
  Printf.printf "%d,%d,%d\n"
    (lexeme_start ctx.lbuf) ((lexeme_end ctx.lbuf) - 1) (get_color clr)

let range_start ctx =
  ctx.pos <- (lexeme_start ctx.lbuf)

let range_stop ctx clr =
  Printf.printf "%d,%d,%d\n"
    ctx.pos ((lexeme_end ctx.lbuf) - 1) (get_color clr)
