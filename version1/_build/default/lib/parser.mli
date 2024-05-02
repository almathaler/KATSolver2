
(* The type of tokens. *)

type token = 
  | ZERO
  | STAR
  | RPAREN
  | PTEST of (char)
  | PLUS
  | PACTION of (char)
  | ONE
  | NEG
  | LPAREN
  | EOF

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val kat_expr: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Kat.expr)
