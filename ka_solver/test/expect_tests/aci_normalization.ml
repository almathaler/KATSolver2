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
  Printf.printf "to_string of parsed: %s \n" (expr |> Expr.to_string);
  print_parsed_and_normalized expr

let%expect_test "x(yz)" = 
  test "x(yz)"; 
  [%expect {|
    to_string of parsed: (x)((y)(z))
    (Prod ((Prim x) (Prod ((Prim y) (Prim z)))))
    After aci_norm:
    (Prod ((Prod ((Prim x) (Prim y))) (Prim z))) |}]

let%expect_test "(xy)z" = 
  test "(xy)z"; 
  [%expect {|
    to_string of parsed: ((x)(y))(z)
    (Prod ((Prod ((Prim x) (Prim y))) (Prim z)))
    After aci_norm:
    (Prod ((Prod ((Prim x) (Prim y))) (Prim z))) |}]

let%expect_test "1a1" = 
  test "1a1"; 
  [%expect {|
    to_string of parsed: (1)((a)(1))
    (Prod (One (Prod ((Prim a) One))))
    After aci_norm:
    (Prim a) |}]
  
let%expect_test "abc" =
  test "abc";
  [%expect{|
    to_string of parsed: (a)((b)(c))
    (Prod ((Prim a) (Prod ((Prim b) (Prim c)))))
    After aci_norm:
    (Prod ((Prod ((Prim a) (Prim b))) (Prim c))) |}]

let%expect_test "a(bc)de" =
  test "a(bc)de";
  [%expect{|
    to_string of parsed: (a)(((b)(c))((d)(e)))
    (Prod
     ((Prim a) (Prod ((Prod ((Prim b) (Prim c))) (Prod ((Prim d) (Prim e)))))))
    After aci_norm:
    (Prod
     ((Prod ((Prod ((Prod ((Prim a) (Prim b))) (Prim c))) (Prim d))) (Prim e))) |}]

let%expect_test "a(b+c)de" =
  test "a(b+c)de";
  [%expect{|
    to_string of parsed: (a)((b+c)((d)(e)))
    (Prod
     ((Prim a) (Prod ((Sum ((Prim b) (Prim c))) (Prod ((Prim d) (Prim e)))))))
    After aci_norm:
    (Prod
     ((Prod ((Prod ((Prim a) (Sum ((Prim b) (Prim c))))) (Prim d))) (Prim e))) |}]

let%expect_test "ab*c" =
  test "ab*c";
  [%expect{|
    to_string of parsed: (a)((b*)(c))
    (Prod ((Prim a) (Prod ((Star (Prim b)) (Prim c)))))
    After aci_norm:
    (Prod ((Prod ((Prim a) (Star (Prim b)))) (Prim c))) |}]

let%expect_test "ab*(c+d)e" =
  test "ab*(c+d)e";
  [%expect{|
    to_string of parsed: (a)((b*)((c+d)(e)))
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
    to_string of parsed: (a)((b+c)((d)((e*)((f)(g+h)))))
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

let%expect_test "b + a" = 
  test "b + a"; 
  [%expect{|
    to_string of parsed: b+a
    (Sum ((Prim b) (Prim a)))
    After aci_norm:
    (Sum ((Prim a) (Prim b))) |}]

let%expect_test "a + b" = 
  test "a+b";
  [%expect{|
    to_string of parsed: a+b
    (Sum ((Prim a) (Prim b)))
    After aci_norm:
    (Sum ((Prim a) (Prim b))) |}]

let%expect_test "a + a + a + a" = 
  test "a+a+a+a";
  [%expect{|
    to_string of parsed: a+a+a+a
    (Sum ((Sum ((Sum ((Prim a) (Prim a))) (Prim a))) (Prim a)))
    After aci_norm:
    (Prim a) |}]

let%expect_test "a+b+c+a+c+b" = 
  test "a+b+c+a+c+b";
  [%expect{|
    to_string of parsed: a+b+c+a+c+b
    (Sum
     ((Sum
       ((Sum ((Sum ((Sum ((Prim a) (Prim b))) (Prim c))) (Prim a))) (Prim c)))
      (Prim b)))
    After aci_norm:
    (Sum ((Sum ((Prim a) (Prim b))) (Prim c))) |}]

let%expect_test "a+dc+bc" = 
  test "a+dc+bc";
  [%expect{|
    to_string of parsed: a+(d)(c)+(b)(c)
    (Sum
     ((Sum ((Prim a) (Prod ((Prim d) (Prim c))))) (Prod ((Prim b) (Prim c)))))
    After aci_norm:
    (Sum
     ((Sum ((Prod ((Prim b) (Prim c))) (Prod ((Prim d) (Prim c))))) (Prim a))) |}]
 
let%expect_test "a+d*c+bc" = 
  test "a+d*c+bc";
  [%expect{|
    to_string of parsed: a+(d*)(c)+(b)(c)
    (Sum
     ((Sum ((Prim a) (Prod ((Star (Prim d)) (Prim c)))))
      (Prod ((Prim b) (Prim c)))))
    After aci_norm:
    (Sum
     ((Sum ((Prod ((Prim b) (Prim c))) (Prod ((Star (Prim d)) (Prim c)))))
      (Prim a))) |}]

let%expect_test "z + x + y" = 
  test "z + x + y";
  [%expect{|
    to_string of parsed: z+x+y
    (Sum ((Sum ((Prim z) (Prim x))) (Prim y)))
    After aci_norm:
    (Sum ((Sum ((Prim x) (Prim y))) (Prim z))) |}]

let%expect_test "ac + ab" = 
  test "ac + ab";
  [%expect {|
    to_string of parsed: (a)(c)+(a)(b)
    (Sum ((Prod ((Prim a) (Prim c))) (Prod ((Prim a) (Prim b)))))
    After aci_norm:
    (Sum ((Prod ((Prim a) (Prim b))) (Prod ((Prim a) (Prim c))))) |}]

let%expect_test "abc* + abc* + (cxy(z+a))" = 
  test "abc* + abc* + (cxy(z+a))";
  [%expect{|
    to_string of parsed: (a)((b)(c*))+(a)((b)(c*))+(c)((x)((y)(z+a)))
    (Sum
     ((Sum
       ((Prod ((Prim a) (Prod ((Prim b) (Star (Prim c))))))
        (Prod ((Prim a) (Prod ((Prim b) (Star (Prim c))))))))
      (Prod
       ((Prim c) (Prod ((Prim x) (Prod ((Prim y) (Sum ((Prim z) (Prim a)))))))))))
    After aci_norm:
    (Sum
     ((Prod ((Prim a) (Prod ((Prim b) (Star (Prim c))))))
      (Prod
       ((Prod ((Prod ((Prim c) (Prim x))) (Prim y))) (Sum ((Prim a) (Prim z))))))) |}]

let%expect_test "abc* + abc* + (axy(z+a))" = 
  test "abc* + abc* + (axy(z+a))";
  [%expect{|
    to_string of parsed: (a)((b)(c*))+(a)((b)(c*))+(a)((x)((y)(z+a)))
    (Sum
     ((Sum
       ((Prod ((Prim a) (Prod ((Prim b) (Star (Prim c))))))
        (Prod ((Prim a) (Prod ((Prim b) (Star (Prim c))))))))
      (Prod
       ((Prim a) (Prod ((Prim x) (Prod ((Prim y) (Sum ((Prim z) (Prim a)))))))))))
    After aci_norm:
    (Sum
     ((Prod ((Prim a) (Prod ((Prim b) (Star (Prim c))))))
      (Prod
       ((Prod ((Prod ((Prim a) (Prim x))) (Prim y))) (Sum ((Prim a) (Prim z)))))))
    |}]

let%expect_test "(a+b)+(ab)" = 
  test "(a+b)+(ab)"; 
  [%expect {|
    to_string of parsed: a+b+(a)(b)
    (Sum ((Sum ((Prim a) (Prim b))) (Prod ((Prim a) (Prim b)))))
    After aci_norm:
    (Sum ((Sum ((Prod ((Prim a) (Prim b))) (Prim a))) (Prim b))) |}]

let%expect_test "(a*)+a" = 
  test "(a*)+a"; 
  [%expect {|
    to_string of parsed: a*+a
    (Sum ((Star (Prim a)) (Prim a)))
    After aci_norm:
    (Sum ((Prim a) (Star (Prim a)))) |}]
