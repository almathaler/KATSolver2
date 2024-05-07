open Core
open Ka_solver

let parse (s : string) : Expr.t =
  let lexbuf = Lexing.from_string s in
  let exp = Parser.ka_expr Lexer.read lexbuf in
  exp

let print_parsed str1 = 
  str1 |> parse |> Expr.sexp_of_t |> Core.Sexp.to_string_hum |> print_endline

let print_normalized str1 = 
  let expr = parse str1 in 
  expr |> Equivalence_checker.aci_normalize |> 
  Expr.sexp_of_t |> Core.Sexp.to_string_hum |> print_endline

let print_equiv str1 str2 = 
  let e1 = parse str1 in 
  let e2 = parse str2 in 
  let (equiv, _, _) = Equivalence_checker.are_equivalent e1 e2 in 
  Printf.printf "Are equivalent?: %b \n" equiv

let print_brze str1 = 
  let brz_e = Equivalence_checker.Brz_e.create in 
  let e1 = parse str1 in 
  let norm_e1 = Equivalence_checker.aci_normalize e1 in 
  norm_e1 |> (Equivalence_checker.Brz_e.brz_e brz_e) |> Printf.printf "brz_e: %i \n"

let print_brzd a str1 = 
  let brz_d = Equivalence_checker.Brz_d.create in 
  let e1 = parse str1 in 
  let norm_e1 = Equivalence_checker.aci_normalize e1 in 
  norm_e1 |> (Equivalence_checker.Brz_d.brz_d brz_d a) |> Expr.sexp_of_t 
          |> Core.Sexp.to_string_hum |> Printf.printf "brz_d, %c: %s \n" a

let%expect_test "x* and x** parsing"=
  print_endline "x*:"; 
  print_parsed "x*"; 
  print_endline "x**:";
  print_parsed "x**"; 
  [%expect {|
    x*:
    (Star (Prim x))
    x**:
    (Star (Star (Prim x))) |}]

let%expect_test "x* and x** normalize" = 
  print_endline "x*:"; 
  print_normalized "x*"; 
  print_endline "x**:";
  print_normalized "x**";
  [%expect {|
    x*:
    (Star (Prim x))
    x**:
    (Star (Star (Prim x))) |}] 

let%expect_test "x* and x** brz_e" =
  print_endline "x*:";
  print_brze "x*"; 
  print_endline "x**"; 
  print_brze "x**"; 
  [%expect {|
    x*:
    brz_e: 1
    x**
    brz_e: 1 |}]

let%expect_test "x* and x** brz_d x" =
  print_endline "x*:";
  print_brzd 'x' "x*"; 
  print_endline "x**"; 
  print_brzd 'x' "x**"; 
  [%expect {|
    x*:
    brz_d, x: (Star (Prim x))
    x**
    brz_d, x: (Prod ((Star (Prim x)) (Star (Star (Prim x))))) |}]