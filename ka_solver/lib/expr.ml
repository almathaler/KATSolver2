open Core

type t = 
| Zero 
| One 
| Prim of char
| Sum of (t * t) 
| Prod of (t * t) 
| Star of t
[@@deriving sexp]

(* let rec leftmost_char = function 
  | Zero -> '0' 
  | One -> '1' 
  | Prim c -> c 
  | Sum (e1, _) -> leftmost_char e1 
  | Prod (e1, _) -> leftmost_char e1 
  | Star e -> leftmost_char e *)

let rec chars = function 
  | Zero -> "0" 
  | One -> "1" 
  | Prim c -> Char.to_string c 
  | Star e -> chars e
  | Sum (e1, e2) | Prod (e1, e2) -> (chars e1) ^ (chars e2)

let compare e1 e2 = 
  String.compare (chars e1) (chars e2)

let sexp_of_t = sexp_of_t