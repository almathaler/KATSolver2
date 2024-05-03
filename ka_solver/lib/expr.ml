open Core

type t = 
| Zero 
| One 
| Prim of char
| Sum of (t * t) 
| Prod of (t * t) 
| Star of t
[@@deriving sexp]

let leftmost_char _ = 
  failwith("TODO")

let compare e1 e2 = 
  Char.compare (leftmost_char e1) (leftmost_char e2) 

let sexp_of_t = sexp_of_t