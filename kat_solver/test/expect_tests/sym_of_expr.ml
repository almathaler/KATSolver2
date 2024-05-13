open Core 
open Kat_solver 

let parse (s : string) : Expr.t = 
  let lexbuf = Lexing.from_string s in 
  let exp = Parser.expr Lexer.read lexbuf in 
  exp 

let test str = 
  str |> parse |> Sym_expr.of_expr |> Sym_expr.sexp_of_t |> Core.Sexp.to_string_hum |> print_endline

let%expect_test "a" = 
  test "a";
  [%expect {| (Test (N a (V false) (V true))) |}]

let%expect_test "x+!(ab)+yz" = 
  test "x+!(ab)+yz";
  [%expect {|
    (Sum
     ((Sum ((Prim x) (Test (N a (V true) (N b (V true) (V false))))))
      (Prod ((Prim y) (Prim z))))) |}]

let%expect_test "x+!!(10)" = 
  test "x+!!(10)";
  [%expect {| (Sum ((Prim x) (Test (V false)))) |}]