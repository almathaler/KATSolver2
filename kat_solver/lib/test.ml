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

let to_bdd t = 
  match t with 
  | Prim c -> Bdd.node c (Bdd.constant false) (Bdd.constant true)
  | _ -> failwith "todo"