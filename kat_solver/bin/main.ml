open Kat_solver

let parse (s : string) : Expr.t =
  let lexbuf = Lexing.from_string s in
  let exp = Parser.expr Lexer.read lexbuf in
  exp

let display_kat_syntax () = 
  Format.printf "
This is a KAT expression equivalence checker. It uses a bisimulation on the 
automata of guarded string languages to check equivalence of two KAT expressions.


USAGE: 
In the [kat_solver] directory, run: 
'dune exec kat_solver \"<exp1>\" \"<exp2>\"'
or 
'dune exec kat_solver help'.

KAT SYNTAX:
- Primitive actions : (k-z)
- Primitive tests : (a-j)
- Multiplication / Conjunction: Implicit
- Addition / Disjunction: (+)
- Kleene star: (*)
- Negation: (~) [tilde]
- Zero: (0)
- One: (1)
Precedence is:
Parenthesis > Negation > Kleene Star > Multiplication > Addition

EXAMPLE: 
dune exec kat_solver \"x(x+y)*~ab\" \"xx*~ayb\"

"

let () =
  match Sys.argv with 
  | [|_; exp1; exp2|] -> 
    (
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
  | [|_; "help"|] | [|_; "-help"|] -> display_kat_syntax () 
  | _ -> 
    let args = Array.to_list Sys.argv |> List.tl |> List.rev in 
    Printf.printf "Expected 'dune exec kat_solver \"<exp1>\" \"<exp2>\"'\nOr 'dune exec kat_solver help'\nBut [%s] was passed\n" 
    (List.fold_right (fun x acc -> (x ^ "; " ^ acc)) (List.tl args) (List.hd args))