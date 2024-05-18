open Kat_solver

let parse (s : string) : Expr.t =
  let lexbuf = Lexing.from_string s in
  let exp = Parser.expr Lexer.read lexbuf in
  exp

let () =
  let num_args = (Array.length Sys.argv) - 1 in 
  if num_args = 2 then
    (
    let exp1 = Array.get Sys.argv 1 in 
    let exp2 = Array.get Sys.argv 2 in 
    let sym_exp1 = parse exp1 |> Sym_expr.of_expr in 
    let sym_exp2 = parse exp2 |> Sym_expr.of_expr in 
    let (are_equivalent, witness1, witness2) = Equivalence_checker.are_equivalent sym_exp1 sym_exp2 in 
    match (are_equivalent, witness1, witness2) with 
    | true, None, None -> print_endline "Equivalent"
    | false, Some w1, Some w2 ->  
      let p_w1 =  Sym_expr.to_string w1 in 
      let p_w2 =  Sym_expr.to_string w2 in 
      Printf.printf "Not Equivalent. \n%s can reach %s \n%s can reach %s \nin the same sequence of steps, but these do not accept the same atoms \n"
       exp1 p_w1 exp2 p_w2
    | _ -> print_endline "Error. Equivalence and witness Option do not match"
    )
  else
    Printf.printf "Expected 'dune exec bin/main.exe \"<exp1>\" \"<exp2>\"', but %i arguments were passed \n" num_args