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
    let parsed_exp1 = parse exp1 |> Expr.sexp_of_t |> Core.Sexp.to_string_hum in 
    let parsed_exp2 = parse exp2 |> Expr.sexp_of_t |> Core.Sexp.to_string_hum in
    Printf.printf "First expression parsed: %s \n" parsed_exp1;
    Printf.printf "Second expression parsed: %s \n" parsed_exp2
  )
  else
    Printf.printf "Expected 'dune exec bin/main.exe <exp1> <exp2>', but %i arguments were passed \n" num_args