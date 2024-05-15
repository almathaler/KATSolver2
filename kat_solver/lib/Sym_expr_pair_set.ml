module Sym_expr_pair = struct 
  type t = (Sym_expr.t * Sym_expr.t) 

  let compare e1 e2 = 
    let (e1_l, e1_r) = e1 in 
    let (e2_l, e2_r) = e2 in 
    match (Sym_expr.compare e1_l e2_l) with 
    | 1 -> 1 
    | -1 -> -1 
    | 0 -> (Sym_expr.compare e1_r e2_r)
    | _ -> failwith "Non-{-1,0,1} compare value"
end 

module Underlying = Set.Make(Sym_expr_pair) (* Not really sure if this is the way to do it? *)

type t = Underlying.t
type elt = Underlying.elt
let empty = Underlying.empty  

let add = Underlying.add 

let mem = Underlying.mem  