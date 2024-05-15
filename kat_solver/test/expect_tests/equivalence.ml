open Core 
open Kat_solver 

let parse (s : string) : Expr.t = 
  let lexbuf = Lexing.from_string s in 
  let exp = Parser.expr Lexer.read lexbuf in 
  exp 

let test str1 str2 = 
  let sym_expr1 = str1 |> parse |> Sym_expr.of_expr in 
  let sym_expr2 = str2 |> parse |> Sym_expr.of_expr in 
  let (ans, _, _) = Equivalence_checker.are_equivalent sym_expr1 sym_expr2 in 
  Printf.printf "%b" ans 

let%expect_test "a, a" = 
  test "a" "a"; 
  [%expect {| true |}]

let%expect_test "a, b" = 
  test "a" "b"; 
  [%expect {| false |}]

let%expect_test "1a, a" = 
  test "1a" "a"; 
  [%expect {| true |}]

let%expect_test "!a, a" = 
  test "!a" "a"; 
  [%expect {| false |}]

let%expect_test "ab+!b, ab" = 
  test "ab+!b" "ab"; 
  [%expect {| false |}]

let%expect_test "ax0, ax" = 
  test "ax0" "ax"; 
  [%expect {| false |}]

let%expect_test "1, x*" = 
  test "1" "x*"; 
  [%expect {| false |}]

let%expect_test "1+x*, x*" = 
  test "1+x*" "x*"; 
  [%expect {| true |}]

(* Ex from https://perso.ens-lyon.fr/damien.pous/symbolickat/ *)
let%expect_test "(ar!a)*, 1+ar!a" = 
  test "(ar!a)*" "1+ar!a"; 
  [%expect {| true |}]