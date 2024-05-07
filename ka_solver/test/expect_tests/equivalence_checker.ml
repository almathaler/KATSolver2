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

(* Idempotent Seniring Axioms *)
let%expect_test "x+0, x" = 
  test_basic "x" "x+0"; 
  [%expect {| Are equivalent?: true |}]

let%expect_test "x, 0+x" = 
  test_basic "0+x" "x"; 
  [%expect {| Are equivalent?: true |}]

(* let%expect_test "x(yz), (xy)z" = 
  test_basic "x(yz)" "(xy)z"; 
  [%expect {| Are equivalent?: true |}] *)

(* let%expect_test "x(y+z), xy + xz" = 
  test_basic "x(y+z)" "xy + xz"; 
  [%expect {| Are equivaleent?: true |}] *)

(* let%expect_test "x0, 0" = 
  test_basic "x0" "0"; 
  [%expect {| Are equivaleent?: true |}] *)

(* let%expect_test "0x, 0" = 
  test_basic "0x" "0"; 
  [%expect {| Are equivaleent?: true |}] *)

(* let%expect_test "0x, x0" = 
  test_basic "0x" "x0"; 
  [%expect {| Are equivaleent?: true |}] *)

(* let%expect_test "x, 1x" =
  test_basic "x" "1x";
  [%expect{| Are equivalent?: true |}] *)

(* let%expect_test "x1, x" = 
  test_basic "1x" "x"; 
  [%expect {| Are equivalent?: true |}]   *)

(* let%expect_test "x1, 1x" = 
  test_basic "1x" "x1"; 
  [%expect {| Are equivalent?: true |}]   *)

(* let%expect_test "x+y, y+x" = 
  test_basic "x+y" "y+x"; 
  [%expect {| Are equivalent?: true |}] *)

(* let%expect_test "x+x, x" = 
  test_basic "x+x" "x"; 
  [%expect {| Are equivalent?: true |}] *)

(* let%expect_test "(x+y)z, xz+yz" =
  test_basic "(x+y)z" "xz+yz"; 
  [%expect {| Are equivalent?: true |}] *)

(* Star equational axioms *)
(* let%expect_test "1+xx*+x*, x*" = 
  test_basic "1+xx*+x*" "x*"; 
  [%expect {| Are equivalent?: true |}] *)

(* let%expect_test "1+x*x+x*, x*" = 
  test_basic "1+x*x+x*" "x*"; 
  [%expect {| Are equivalent?: true |}] *)

(* Others *)
let%expect_test "a, ab" =
  test_basic "a" "ab";
  [%expect{| Are equivalent?: false |}]

let%expect_test "a, b" = 
  test_basic "a" "b"; 
  [%expect{| Are equivalent?: false |}]

let%expect_test "a, 1a1" = 
  test_basic "a" "1a1"; 
  [%expect{| Are equivalent?: true |}]

