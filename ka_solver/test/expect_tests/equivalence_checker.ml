open Core
open Ka_solver

let parse (s : string) : Expr.t =
  let lexbuf = Lexing.from_string s in
  let exp = Parser.ka_expr Lexer.read lexbuf in
  exp

let test_basic str1 str2 = 
  let e1 = parse str1 in 
  let e2 = parse str2 in 
  let (equiv, _, _) = Equivalence_checker.are_equivalent e1 e2 in 
  Printf.printf "Are equivalent?: %b \n" equiv

let%expect_test "a, 1a" =
  test_basic "a" "1a";
  [%expect{| Are equivalent?: true |}]

let%expect_test "a, ab" =
  test_basic "a" "ab";
  [%expect{| Are equivalent?: false |}]

let%expect_test "a, b" = 
  test_basic "a" "b"; 
  [%expect{| Are equivalent?: false |}]

let%expect_test "a, 1a1" = 
  test_basic "a" "1a1"; 
  [%expect{| Are equivalent?: true |}]