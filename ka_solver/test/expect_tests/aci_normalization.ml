open Core
open Ka_solver

let parse (s : string) : Expr.t =
  let lexbuf = Lexing.from_string s in
  let exp = Parser.ka_expr Lexer.read lexbuf in
  exp

let%expect_test "abc" =
  let expr = parse "abc" in 
  expr |> Expr.sexp_of_t |> Core.Sexp.to_string_hum |> print_endline; 
  print_endline "After aci_norm:"; 
  expr |> Equivalence_checker.aci_normalize |> 
  Expr.sexp_of_t |> Core.Sexp.to_string_hum |> print_endline;
  [%expect{|
    (Prod ((Prim a) (Prod ((Prim b) (Prim c)))))
    After aci_norm:
    (Prod ((Prod ((Prim a) (Prim b))) (Prim c))) |}]