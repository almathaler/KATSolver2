open Core 
open Kat_solver 

let parse (s : string) : Expr.t = 
  let lexbuf = Lexing.from_string s in 
  let exp = Parser.expr Lexer.read lexbuf in 
  exp 

let test str1 str2 = 
  let sym_expr1 = str1 |> parse |> Sym_expr.of_expr in 
  let sym_expr2 = str2 |> parse |> Sym_expr.of_expr in 
  let (ans, w1, w2) = Equivalence_checker.are_equivalent sym_expr1 sym_expr2 in 
  let str_w w = match w with 
  | None -> "None"
  | Some w -> Sym_expr.to_string w 
  in 
  Printf.printf "ans: %b, w1: %s, w2: %s" ans (str_w w1) (str_w w2)

let%expect_test "a, a" = 
  test "a" "a"; 
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "a, b" = 
  test "a" "b"; 
  [%expect {| ans: false, w1: (a[false][true]), w2: (b[false][true]) |}]

let%expect_test "1a, a" = 
  test "1a" "a"; 
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "!a, a" = 
  test "!a" "a"; 
  [%expect {| ans: false, w1: (a[true][false]), w2: (a[false][true]) |}]

let%expect_test "ab+!b, ab" = 
  test "ab+!b" "ab"; 
  [%expect {| ans: false, w1: (a(b[true][false])[true]), w2: (a[false](b[false][true])) |}]

let%expect_test "ax0, ax" = 
  test "ax0" "ax"; 
  [%expect {| ans: false, w1: [false], w2: [true] |}]

let%expect_test "1, x*" = 
  test "1" "x*"; 
  [%expect {| ans: false, w1: [false], w2: [true] |}]

let%expect_test "1+x*, x*" = 
  test "1+x*" "x*"; 
  [%expect {| ans: true, w1: None, w2: None |}]

(* Ex from https://perso.ens-lyon.fr/damien.pous/symbolickat/ *)
let%expect_test "(ar!a)*, 1+ar!a" = 
  test "(ar!a)*" "1+ar!a"; 
  [%expect {| ans: true, w1: None, w2: None |}]
  (* [%expect {| ans: false, w1: [false], w2: (a[true][false]) |}] *)