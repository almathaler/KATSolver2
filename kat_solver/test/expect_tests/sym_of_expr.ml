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
  [%expect {| (Prim x) |}]

let%expect_test "yz*+yz!(ab)+!(ab)zb*" = 
  test "yz*+yz!(ab)+!(ab)zb*";
  [%expect {|
    (Sum
     ((Sum
       ((Prod
         ((Prod ((Test (N a (V true) (N b (V true) (V false)))) (Prim z)))
          (Star (Test (N b (V false) (V true))))))
        (Prod
         ((Prod ((Prim y) (Prim z)))
          (Test (N a (V true) (N b (V true) (V false))))))))
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

let%expect_test "to_str !(a+b)+z+z+x+x+y+y+!(a+b)" = 
  test_to_string "!(a+b)+z+z+x+x+y+y+!(a+b)";
  [%expect {| (a(b[true][false])[false])+x+y+z |}]

let%expect_test "to_str 0+1" = 
  test_to_string "0+1";
  [%expect {| [true] |}]

let%expect_test "to_str 0+a" = 
  test_to_string "0+a";
  [%expect {| (a[false][true]) |}]

let%expect_test "to_str 1+a" = 
  test_to_string "1+a";
  [%expect {| [true] |}]

let%expect_test "to_str 0+x" = 
  test_to_string "0+x";
  [%expect {| x |}]

let%expect_test "to_str 0+0+x" = 
  test_to_string "0+0+x";
  [%expect {| x |}]

let%expect_test "to_str 0+0+0+x" = 
  test_to_string "0+0+0+x";
  [%expect {| x |}]

let%expect_test "to_str x+0+x+0+x" = 
  test_to_string "x+0+x+0+x";
  [%expect {| x |}]

let%expect_test "to_str 0+0+1+0+x" = 
  test_to_string "0+0+1+0+x";
  [%expect {| [true]+x |}]

let%expect_test "to_str 1a" = 
  test_to_string "1a"; 
  [%expect {| (a[false][true]) |}]

let%expect_test "to_str 1x" = 
  test_to_string "1x"; 
  [%expect {| x |}]

let%expect_test "to_str x+y+1x+x1+0yx" = 
  test_to_string "x+y+1x+x1+0yx";
  [%expect {| x+y |}]

let%expect_test "to_str x+y+z+a+b+c" = 
  test_to_string "x+y+z+a+b+c";
  [%expect {| (a(b(c[false][true])[true])[true])+x+y+z |}]

(* sums should be ACI norm, with tests at the start, duplicates and zeroes 
   removed, tests merged *)
let%expect_test "to_str x+y+0+z+a+0+b+c+a" = 
  test_to_string "x+y+0+z+a+0+b+c+a";
  [%expect {| (a(b(c[false][true])[true])[true])+x+y+z |}]

(* products should be associated to the left, consecutive tests merged and also 
   idempotency for tests, ones removed, zeroes zeroeing out the product *)
let%expect_test "to_str xy10+x0+y0" = 
  test_to_string "xy10+x0+y0"; 
  [%expect {| [false] |}]

let%expect_test "to_str abc10+a0+b0" = 
  test_to_string "abc10+a0+b0"; 
  [%expect {| [false] |}]

let%expect_test "to_str x+a1+0a+ab0c+1" = 
  test_to_string "x+a1+0a+ab0c+1"; 
  [%expect {| [true]+x |}]

let%expect_test "to_str x+y+1" = 
  test_to_string "x+y+1";
  [%expect {| [true]+x+y |}]

let%expect_test "to_str x0" = 
  test_to_string "x0"; 
  [%expect {| [false] |}]

let%expect_test "to_str x1" = 
  test_to_string "x1"; 
  [%expect {| x |}]