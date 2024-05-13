open Core 

type t = 
| Prim of char 
| Zero 
| One 
| Land of (t * t) 
| Lor of (t * t)
| Not of t 
[@@deriving sexp]

let sexp_of_t = sexp_of_t

let t_of_sexp = t_of_sexp

let prim_to_bdd c = 
  Bdd.node c (Bdd.constant false) (Bdd.constant true)
let rec to_bdd t = 
  match t with 
  | Prim c -> prim_to_bdd c
  | Zero -> (Bdd.constant false)
  | One -> (Bdd.constant true) 
  | Land (l, r) -> Bdd.logical_and (to_bdd l) (to_bdd r)
  | Lor (l, r) -> Bdd.logical_or (to_bdd l) (to_bdd r)
  | Not t -> Bdd.negate (to_bdd t)
