open Core 
open Kat_solver 

let parse (s : string) : Expr.t = 
  let lexbuf = Lexing.from_string s in 
  let exp = Parser.expr Lexer.read lexbuf in 
  exp 

let test_once s1 s2 = 
  let se1 = s1 |> parse |> Sym_expr.of_expr in 
  let se2 = s2 |> parse |> Sym_expr.of_expr in 
  let sum = Sym_expr.sum se1 se2 in 
  sum |> Sym_expr.sexp_of_t |> Core.Sexp.to_string_hum |> print_endline

let%expect_test "a and b" = 
  test_once "a" "b";
  [%expect {| (Test (N a (N b (V false) (V true)) (V true))) |}]

let%expect_test "x and a" = 
  test_once "x" "a"; 
  [%expect {| (Sum ((Test (N a (V false) (V true))) (Prim x))) |}]