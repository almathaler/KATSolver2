module Brz_e = struct 
  type t = (Sym_expr.t, (char, bool) Bdd.t) Hashtbl.t

  let create () = Hashtbl.create 16 

  let rec brz_e t (se : Sym_expr.t) = 
    try Hashtbl.find t se with 
    Not_found -> 
      let derivative = 
        (match se with 
        | Test t -> t 
        | Prim _ -> Bdd.zero
        | Star _ -> Bdd.one 
        | Prod (se1, se2) -> Bdd.logical_and (brz_e t se1) (brz_e t se2)
        | Sum (se1, se2) -> Bdd.logical_or (brz_e t se1) (brz_e t se2)) in 
      Hashtbl.add t se derivative; 
      derivative


end

let are_equivalent _ _ = failwith "todo"