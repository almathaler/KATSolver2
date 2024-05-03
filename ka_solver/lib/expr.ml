open Core

type t = 
| Zero 
| One 
| Prim of char
| Sum of (t * t) 
| Prod of (t * t) 
| Star of t
[@@deriving sexp]

let rec leftmost_char = function 
  | Zero -> '0' 
  | One -> '1' 
  | Prim c -> c 
  | Sum (e1, _) -> leftmost_char e1 
  | Prod (e1, _) -> leftmost_char e1 
  | Star e -> leftmost_char e

(* TODO: CHANGE THIS! *)
let compare e1 e2 = 
  Char.compare (leftmost_char e1) (leftmost_char e2) 

let sexp_of_t = sexp_of_t