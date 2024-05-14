open Core 
open Kat_solver 

let parse (s : string) : Expr.t = 
  let lexbuf = Lexing.from_string s in 
  let exp = Parser.expr Lexer.read lexbuf in 
  exp 

let test str = 
  str |> parse |> Sym_expr.of_expr |> Sym_expr.sexp_of_t |> Core.Sexp.to_string_hum |> print_endline

let%expect_test "a" = 
  test "a";
  [%expect {| (Test (N a (V false) (V true))) |}]

let%expect_test "x+!(ab)+yz" = 
  test "x+!(ab)+yz";
  [%expect{|
    (Sum
     ((Sum
       ((Test (N a (V true) (N b (V true) (V false))))
        (Prod ((Prim y) (Prim z)))))
      (Prim x))) |}]

let%expect_test "x+!!(10)" = 
  test "x+!!(10)";
  [%expect {| (Sum ((Test (V false)) (Prim x))) |}]

let%expect_test "yz*+yz!(ab)+!(ab)zb*" = 
  test "yz*+yz!(ab)+!(ab)zb*";
  [%expect {|
    (Sum
     ((Sum
       ((Prod
         ((Test (N a (V true) (N b (V true) (V false))))
          (Prod ((Prim z) (Star (Test (N b (V false) (V true))))))))
        (Prod
         ((Prim y)
          (Prod ((Prim z) (Test (N a (V true) (N b (V true) (V false))))))))))
      (Prod ((Prim y) (Star (Prim z)))))) |}]

let%expect_test "x+y+!!((a+b+c)+(c+b+a)+abc+cba)" = 
  test "x+y+!!((a+b+c)+(c+b+a)+abc+cba)";
  [%expect{|
    (Sum
     ((Sum
       ((Test (N a (N b (N c (V false) (V true)) (V true)) (V true))) (Prim x)))
      (Prim y))) |}]

let%expect_test "z+y+x+w+v+u" = 
  test "z+y+x+w+u+v"; 
  [%expect {|
    (Sum
     ((Sum
       ((Sum ((Sum ((Sum ((Prim u) (Prim v))) (Prim w))) (Prim x))) (Prim y)))
      (Prim z))) |}]

let test_to_string str = 
  str |> parse |> Sym_expr.of_expr |> Sym_expr.to_string |> print_endline

let%expect_test "to_str x+!(ab)+yz" = 
  test_to_string "x+!(ab)+yz"; 
  [%expect {| (a[true](b[true][false]))+(y)(z)+x |}]

let%expect_test "to_str x+x+!(ab)+!(ab)+yz" = 
  test_to_string "x+x+!(ab)+!(ab)+yz"; 
  [%expect {| (a[true](b[true][false]))+(y)(z)+x |}]

