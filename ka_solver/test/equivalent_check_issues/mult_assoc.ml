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

let%expect_test "x(yz) and (xy)z parse" = 
  print_parsed "x(yz)"; 
  print_parsed "(xy)z"; 
  [%expect {|
    (Prod ((Prim x) (Prod ((Prim y) (Prim z)))))
    (Prod ((Prod ((Prim x) (Prim y))) (Prim z))) |}]

let%expect_test "x(yz) and (xy)z aci normalize" = 
  print_normalized "x(yz)"; 
  print_normalized "(xy)z"; 
  [%expect {|
    (Prod ((Prod ((Prim x) (Prim y))) (Prim z)))
    (Prod ((Prod ((Prim x) (Prim y))) (Prim z))) |}]

let%expect_test "x(yz) brz_e" = 
  print_brze "x(yz)"; 
  [%expect {||}]

let%expect_test "x(yz) brz_d for x, y, z" = 
  print_brzd 'x' "x(yz)";
  print_brzd 'y' "x(yz)";
  print_brzd 'z' "x(yz)"; 
  [%expect {||}]

(* let%expect_test "x(yz) and (xy)z equivalent" = 
  print_equiv "x(yz)" "(xy)z"; 
  [%expect {||}] *)