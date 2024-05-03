open Ka_solver

let parse (s : string) : Expr.t =
  let lexbuf = Lexing.from_string s in
  let exp = Parser.ka_expr Lexer.read lexbuf in
  exp

let () =
  let num_args = (Array.length Sys.argv) - 1 in 
  if num_args = 2 then
    (
    let exp1 = Array.get Sys.argv 1 in 
    let exp2 = Array.get Sys.argv 2 in 
    Printf.printf "First expression: %s \n" exp1;
    Printf.printf "Second expression: %s \n" exp2;
    let parsed_exp1 = parse exp1 in 
    let printable_exp1 = parsed_exp1|> Expr.sexp_of_t |> Core.Sexp.to_string_hum in 
    let parsed_exp2 = parse exp2 in 
    let printable_exp2 = parsed_exp2 |> Expr.sexp_of_t |> Core.Sexp.to_string_hum in
    Printf.printf "First expression parsed: %s \n" printable_exp1;
    Printf.printf "Second expression parsed: %s \n" printable_exp2; 
    let (are_equivalent, witness1, witness2) = Equivalence_checker.are_equivalent parsed_exp1 parsed_exp2 in 
    match (are_equivalent, witness1, witness2) with 
    | true, None, None -> print_endline "Equivalent"
    | false, Some w1, Some w2 -> 
      let printable_w1 =  w1 |> Expr.sexp_of_t |> Core.Sexp.to_string_hum in 
      let printable_w2 =  w2 |> Expr.sexp_of_t |> Core.Sexp.to_string_hum in 
      Printf.printf "Exp1 can reach %s, Exp2 reaches %s in the same sequence of steps, but these do not have the same EWP \n" printable_w1 printable_w2
    | _ -> print_endline "Error. Equivalence and witness Option do not match"
    )
  else
    Printf.printf "Expected 'dune exec bin/main.exe <exp1> <exp2>', but %i arguments were passed \n" num_args