open Core 

type t = 
| Prim of char 
| Sum of (t * t)
| Prod of (t * t) 
| Star of t 
| Test of Test.t
[@@deriving sexp]

let sexp_of_t = sexp_of_t

let rec to_string = function 
  | Prim c -> Char.to_string c 
  | Star e -> (to_string e) ^ "*"
  | Sum (e1, e2) -> (to_string e1) ^ "+" ^ (to_string e2) 
  | Prod (e1, e2) -> "(" ^ (to_string e1) ^ ")(" ^ (to_string e2) ^ ")"
  | Test t -> "(" ^ (Test.to_string t) ^ ")"

let to_bdd = function 
| Test t -> Test.to_bdd t 
| _ -> failwith "Can't transform non-test to bdd"