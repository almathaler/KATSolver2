open Core
open Ka_solver

let parse (s : string) : Expr.t =
  let lexbuf = Lexing.from_string s in
  let exp = Parser.ka_expr Lexer.read lexbuf in
  exp

let print_parsed_and_normalized expr = 
  expr |> Expr.sexp_of_t |> Core.Sexp.to_string_hum |> print_endline; 
  print_endline "After aci_norm:"; 
  expr |> Equivalence_checker.aci_normalize |> 
  Expr.sexp_of_t |> Core.Sexp.to_string_hum |> print_endline

let test str = 
  let expr = parse str in 
  print_parsed_and_normalized expr

let%expect_test "abc" =
  test "abc";
  [%expect{|
    (Prod ((Prim a) (Prod ((Prim b) (Prim c)))))
    After aci_norm:
    (Prod ((Prod ((Prim a) (Prim b))) (Prim c))) |}]

let%expect_test "a(bc)de" =
  test "a(bc)de";
  [%expect{|
    (Prod
     ((Prim a) (Prod ((Prod ((Prim b) (Prim c))) (Prod ((Prim d) (Prim e)))))))
    After aci_norm:
    (Prod
     ((Prod ((Prod ((Prod ((Prim a) (Prim b))) (Prim c))) (Prim d))) (Prim e))) |}]

let%expect_test "a(b+c)de" =
  test "a(b+c)de";
  [%expect{|
    (Prod
     ((Prim a) (Prod ((Sum ((Prim b) (Prim c))) (Prod ((Prim d) (Prim e)))))))
    After aci_norm:
    (Prod
     ((Prod ((Prod ((Prim a) (Sum ((Prim b) (Prim c))))) (Prim d))) (Prim e))) |}]

let%expect_test "ab*c" =
  test "ab*c";
  [%expect{|
    (Prod ((Prim a) (Prod ((Star (Prim b)) (Prim c)))))
    After aci_norm:
    (Prod ((Prod ((Prim a) (Star (Prim b)))) (Prim c))) |}]

let%expect_test "ab*(c+d)e" =
  test "ab*(c+d)e";
  [%expect{|
    (Prod
     ((Prim a)
      (Prod ((Star (Prim b)) (Prod ((Sum ((Prim c) (Prim d))) (Prim e)))))))
    After aci_norm:
    (Prod
     ((Prod ((Prod ((Prim a) (Star (Prim b)))) (Sum ((Prim c) (Prim d)))))
      (Prim e))) |}]

let%expect_test "a(b+c)d(e*f(g+h))" =
  test "a(b+c)d(e*f(g+h))";
  [%expect{|
    (Prod
     ((Prim a)
      (Prod
       ((Sum ((Prim b) (Prim c)))
        (Prod
         ((Prim d)
          (Prod ((Star (Prim e)) (Prod ((Prim f) (Sum ((Prim g) (Prim h)))))))))))))
    After aci_norm:
    (Prod
     ((Prod
       ((Prod
         ((Prod ((Prod ((Prim a) (Sum ((Prim b) (Prim c))))) (Prim d)))
          (Star (Prim e))))
        (Prim f)))
      (Sum ((Prim g) (Prim h))))) |}]