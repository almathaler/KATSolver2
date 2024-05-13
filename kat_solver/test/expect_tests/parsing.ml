open Core 
open Kat_solver 

let parse (s : string) : Expr.t = 
  let lexbuf = Lexing.from_string s in 
  let exp = Parser.expr Lexer.read lexbuf in 
  exp 

let test str = 
  str |> parse |> Expr.sexp_of_t |> Core.Sexp.to_string_hum |> print_endline

let%expect_test "a+b" = 
  test "a+b";
  [%expect {| (Sum ((Test (Prim a)) (Test (Prim b)))) |}]

let%expect_test "x+y" = 
  test "x+y"; 
  [%expect {| (Sum ((Prim x) (Prim y))) |}]

let%expect_test "ab" = 
  test "ab"; 
  [%expect {| (Prod ((Test (Prim a)) (Test (Prim b)))) |}]

let%expect_test "xy" = 
  test "xy"; 
  [%expect {| (Prod ((Prim x) (Prim y))) |}]

let%expect_test "!(ab)" = 
  test "!(ab)"; 
  [%expect {| (Test (Not (Land ((Prim a) (Prim b))))) |}]

let%expect_test "!(a+b)" = 
  test "!(a+b)"; 
  [%expect {| (Test (Not (Lor ((Prim a) (Prim b))))) |}]

let%expect_test "x + !(ab)" = 
  test "x + !(ab)"; 
  [%expect {| (Sum ((Prim x) (Test (Not (Land ((Prim a) (Prim b))))))) |}]

let%expect_test "x!(ab)" = 
  test "x!(ab)"; 
  [%expect {| (Prod ((Prim x) (Test (Not (Land ((Prim a) (Prim b))))))) |}]

let%expect_test "x!(a+b)" =
  test "x!(a+b)"; 
  [%expect {| (Prod ((Prim x) (Test (Not (Lor ((Prim a) (Prim b))))))) |}]

let%expect_test "a*" =
  test "a*"; 
  [%expect {| (Star (Test (Prim a))) |}]

let%expect_test "x*" = 
  test "x*";
  [%expect {| (Star (Prim x)) |}]
