open Core
open Ka_solver

let parse (s : string) : Expr.t =
  let lexbuf = Lexing.from_string s in
  let exp = Parser.ka_expr Lexer.read lexbuf in
  exp

let%expect_test "a+b" =
  "a+b" |> parse |> Expr.sexp_of_t |> Core.Sexp.to_string_hum |> print_endline;
  [%expect{| (Sum ((Prim a) (Prim b))) |}]

let%expect_test "ab" =
"ab" |> parse |> Expr.sexp_of_t |> Core.Sexp.to_string_hum |> print_endline;
[%expect{| (Prod ((Prim a) (Prim b))) |}]

let%expect_test "ab(c+d*)*" =
"ab(c+d*)*" |> parse |> Expr.sexp_of_t |> Core.Sexp.to_string_hum |> print_endline;
[%expect{| (Prod ((Prim a) (Prod ((Prim b) (Star (Sum ((Prim c) (Star (Prim d))))))))) |}]

let%expect_test "a0(c+1*)*" =
"a0(c+1*)*" |> parse |> Expr.sexp_of_t |> Core.Sexp.to_string_hum |> print_endline;
[%expect{| (Prod ((Prim a) (Prod (Zero (Star (Sum ((Prim c) (Star One)))))))) |}]

let%expect_test "1a1" = 
"1a1" |> parse |> Expr.sexp_of_t |> Core.Sexp.to_string_hum |> print_endline; 
[%expect{||}]
