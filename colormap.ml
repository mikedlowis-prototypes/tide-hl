open Lexing

exception Eof

type style =
  | Normal | Comment | Constant | String | Char | Number | Boolean | Float
  | Variable | Function | Keyword | Operator | PreProcessor | Type | Statement
  | Special

type ctx = {
  lbuf : lexbuf;
  mutable clr : style;
  mutable pos : int;
}

type lexer = {
  scanfn : ctx -> Lexing.lexbuf -> unit;
  lexbuf : Lexing.lexbuf
}

let get_color = function
  | Normal ->       1 * 16
  | Comment ->      2 * 16
  | Constant ->     3 * 16
  | String ->       4 * 16
  | Char ->         5 * 16
  | Number ->       6 * 16
  | Boolean ->      7 * 16
  | Float ->        8 * 16
  | Variable ->     9 * 16
  | Function ->     10 * 16
  | Keyword ->      11 * 16
  | Operator ->     12 * 16
  | PreProcessor -> 13 * 16
  | Type ->         14 * 16
  | Statement ->    15 * 16
  | Special ->      16 * 16

let set_color ctx clr =
  Printf.printf "%d,%d,%d\n"
    (lexeme_start ctx.lbuf) (lexeme_end ctx.lbuf) (get_color clr)

let range_start ctx clr =
  ctx.clr <- clr;
  ctx.pos <- (lexeme_start ctx.lbuf)

let range_stop ctx =
  Printf.printf "%d,%d,%d\n"
    ctx.pos (lexeme_end ctx.lbuf) (get_color ctx.clr);
  ctx.pos <- (-1)

