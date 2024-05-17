open Core 
open Kat_solver 

let parse (s : string) : Expr.t = 
  let lexbuf = Lexing.from_string s in 
  let exp = Parser.expr Lexer.read lexbuf in 
  exp 

let brz_d = Equivalence_checker.Brz_d.create () 


let test str = 
  let sym_expr = str |> parse |> Sym_expr.of_expr in 
  let deriv = Equivalence_checker.Brz_d.brz_d brz_d sym_expr in 
  Printf.printf "%s" (Explicit_deriv.to_string deriv)


let%expect_test "ab" = 
  test "ab"; 
  [%expect {|
    (n, [[false]])
    (o, [[false]])
    (p, [[false]])
    (q, [[false]])
    (r, [[false]])
    (s, [[false]])
    (t, [[false]])
    (u, [[false]])
    (v, [[false]])
    (w, [[false]])
    (x, [[false]])
    (y, [[false]])
    (z, [[false]]) |}]

let%expect_test "brp*+!brp" = 
  test "brp*+!brp";
  [%expect {|
    (n, [[false]])
    (o, [[false]])
    (p, [[false]])
    (q, [[false]])
    (r, (b[p][p*]))
    (s, [[false]])
    (t, [[false]])
    (u, [[false]])
    (v, [[false]])
    (w, [[false]])
    (x, [[false]])
    (y, [[false]])
    (z, [[false]]) |}]