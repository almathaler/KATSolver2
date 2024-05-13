open Core 
open Kat_solver 

let parse (s : string) : Expr.t = 
  let lexbuf = Lexing.from_string s in 
  let exp = Parser.expr Lexer.read lexbuf in 
  exp 

let test str = 
  str |> parse |> Expr.to_bdd |> Bdd.sexp_of_t sexp_of_char sexp_of_bool |> Core.Sexp.to_string_hum |> print_endline

let%expect_test "a" = 
  test "a";
  [%expect {| (N a (V false) (V true)) |}]

let%expect_test "!(a+b)" = 
  test "!(a+b)";
  [%expect {||}]
