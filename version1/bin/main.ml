open Version1

let welcome_message () = 
  print_endline "Welcome to v1 of the KATSolver!"

let display_kat_syntax () = 
  Format.printf "
KAT SYNTAX:
- Primitive actions : (m-z)
- Primitive tests : (a-l)
- Multiplication / Conjunction: Implicit
- Addition / Disjunction: (+)
- Kleene star: (*)
- Negation: (!)
- Zero: (0)
- One: (1)
Precedence is:
Parenthesis > Negation > Kleene Star > Multiplication > Addition
Example expression: 
x(x+y)*!ab
"

let parse (s : string) : Kat.expr =
  let lexbuf = Lexing.from_string s in
  let exp = Parser.kat_expr Lexer.read lexbuf in
  exp

let request_and_parse_exprs () = 
  print_endline "Please input the first expression, or enter `#` to print KAT syntax";
  let user_inp = read_line () in 
  let expr1 = 
    if (user_inp = "#") then 
      (display_kat_syntax (); 
      print_endline "Please input the first expression";
      read_line ()) 
    else 
      user_inp 
  in 
  let expr2 = 
    print_endline "Please input the second expression";
    read_line () 
  in 
  Format.printf "exp1: %s
exp2: %s
" expr1 expr2;
  let parsed_expr1 = parse expr1 in 
  let parsed_expr2 = parse expr2 in 
  Format.printf "parsed exp1: 
  %s 
  parsed exp2: 
  %s 
  " (Kat.to_string parsed_expr1) (Kat.to_string parsed_expr2)

let _ = 
  welcome_message ();
  request_and_parse_exprs ()