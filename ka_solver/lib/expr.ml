open Core

type t = 
| Zero 
| One 
| Prim of char
| Sum of (t * t) 
| Prod of (t * t) 
| Star of t
[@@deriving sexp]

(* Note: The behavior is a bit unintuitive, because for example the 
   string of "(a+b)+(ab)" is "a+b+(a)(b)". And so [compare a ab] gives 
   [a > ab] because [String.compare a (a)(b)] is 1. BUT I don't think this 
   needs to make sense to the user, the comparison is just used in ACI 
   normalization, so what's important is that it's standard for all expressions. 
   TODO: Come back to this later and think about it again *)
let rec to_string = function 
  | Zero -> "0"
  | One -> "1"
  | Prim c -> Char.to_string c 
  | Star e -> (to_string e) ^ "*"
  | Sum (e1, e2) -> (to_string e1) ^ "+" ^ (to_string e2) 
  | Prod (e1, e2) -> "(" ^ (to_string e1) ^ ")(" ^ (to_string e2) ^ ")"

let rec chars = function 
  | Zero -> "0" 
  | One -> "1" 
  | Prim c -> Char.to_string c 
  | Star e -> chars e
  | Sum (e1, e2) | Prod (e1, e2) -> (chars e1) ^ (chars e2)

let compare e1 e2 = 
  String.compare (to_string e1) (to_string e2)

let sexp_of_t = sexp_of_t