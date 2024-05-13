open Core 
open Kat_solver 

let parse (s : string) : Expr.t = 
  let lexbuf = Lexing.from_string s in 
  let exp = Parser.expr Lexer.read lexbuf in 
  exp 

let test str = 
  str |> parse |> Expr.to_bdd |> Bdd.sexp_of_t sexp_of_char sexp_of_bool |> Core.Sexp.to_string_hum |> print_endline

let%expect_test "a" = 
  test "a";
  [%expect {| (N a (V false) (V true)) |}]

let%expect_test "!a" = 
  test "!a";
  [%expect {| (N a (V true) (V false)) |}]

let%expect_test "!(a+b)" = 
  test "!(a+b)"; 
  [%expect {| (N a (N b (V true) (V false)) (V false)) |}]

let%expect_test "!!(a+b)" = 
  test "!!(a+b)"; 
  [%expect {| (N a (N b (V false) (V true)) (V true)) |}]

let%expect_test "!!(b+a)" = 
  test "!!(b+a)"; 
  [%expect {| (N a (N b (V false) (V true)) (V true)) |}]

let%expect_test "!!(a+b+!!(c+d))" = 
  test "!!(a+b+!!(c+d))";
  [%expect {|
    (N a (N b (N c (N d (V false) (V true)) (V true)) (V true)) (V true)) |}]

let%expect_test "!!(d+c+!!(b+a))" = 
  test "!!(d+c+!!(b+a))";
  [%expect {|
    (N a (N b (N c (N d (V false) (V true)) (V true)) (V true)) (V true)) |}]

let%expect_test "!!(ab)" = 
  test "!!(ab)"; 
  [%expect {| (N a (V false) (N b (V false) (V true))) |}]


let%expect_test "!!(fedcba)" = 
  test "!!(fedcba)";
  [%expect {|
    (N a (V false)
     (N b (V false)
      (N c (V false) (N d (V false) (N e (V false) (N f (V false) (V true))))))) |}]

let%expect_test "!!(f+e+d+!!(da+c+ba))" = 
  test "!!(f+e+d+!!(da+c+ba))";
  [%expect {|
    (N a (N c (N d (N e (N f (V false) (V true)) (V true)) (V true)) (V true))
     (N b (N c (N d (N e (N f (V false) (V true)) (V true)) (V true)) (V true))
      (V true))) |}]

let%expect_test "!!(1a)" = 
  test "!!(1 + a)"; 
  [%expect {| (V true) |}]

let%expect_test "!!(a+0)" = 
  test "!!(a+0)"; 
  [%expect {| (N a (V false) (V true)) |}]

let%expect_test "!!(1a)" = 
  test "!!(1a)"; 
  [%expect {| (N a (V false) (V true)) |}]

let%expect_test "!!(a0)" = 
  test "!!(a0)"; 
  [%expect {| (V false) |}]

let%expect_test "!!(aaa)" = 
  test "!!(aaa)"; 
  [%expect {| (N a (V false) (V true)) |}]