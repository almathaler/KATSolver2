open Ka_solver

let parse (s : string) : Expr.t =
  let lexbuf = Lexing.from_string s in
  let exp = Parser.ka_expr Lexer.read lexbuf in
  exp

let display_ka_syntax () = 
  Format.printf "
This is a KA expression equivalence checker. It uses a bisimulation on the 
automata of regular sets to check equivalence of two KA expressions.


USAGE: 
In the [ka_solver] directory, run: 
'dune exec ka_solver \"<exp1>\" \"<exp2>\"'
or 
'dune exec ka_solver help'.

KA SYNTAX:
- Primitive actions : (a-z)
- Multiplication : Implicit
- Addition : (+)
- Kleene star: (*)
- Zero: (0)
- One: (1)
Precedence is:
Parenthesis > Kleene Star > Multiplication > Addition

EXAMPLE: 
dune exec ka_solver \"x(x+y)*ab\" \"xx*ayb\"

"

let () =
  match Sys.argv with 
  | [|_; exp1; exp2|] -> 
    (
    let p_exp1 = parse exp1  in 
    let p_exp2 = parse exp2 in 
    let (are_equivalent, witness1, witness2) = Equivalence_checker.are_equivalent p_exp1 p_exp2 in 
    match (are_equivalent, witness1, witness2) with 
    | true, None, None -> print_endline "Equivalent"
    | false, Some w1, Some w2 ->  
      let p_w1 =  Expr.to_string w1 in 
      let p_w2 =  Expr.to_string w2 in 
      Printf.printf "Not Equivalent. \n%s can reach %s \n%s can reach %s \nin the same sequence of steps, but these do not accept the same atoms \n"
       exp1 p_w1 exp2 p_w2
    | _ -> print_endline "Implementation Error. Equivalence and witness Option do not match"
    )
  | [|_; "help"|] | [|_; "-help"|] -> display_ka_syntax () 
  | _ -> 
    let args = Array.to_list Sys.argv |> List.tl |> List.rev in 
    Printf.printf "Expected 'dune exec ka_solver \"<exp1>\" \"<exp2>\"'\nOr 'dune exec ka_solver help'\nBut [%s] was passed\n" 
    (List.fold_right (fun x acc -> (x ^ "; " ^ acc)) (List.tl args) (List.hd args))