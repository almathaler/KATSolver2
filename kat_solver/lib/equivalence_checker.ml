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

(* Unmemoized version *)
let rec brz_e se = 
  match se with 
  | Sym_expr.Test t -> t 
  | Prim _ -> Bdd.zero
  | Star _ -> Bdd.one 
  | Prod (se1, se2) -> Bdd.logical_and (brz_e se1) (brz_e se2)
  | Sum (se1, se2) -> Bdd.logical_or (brz_e se1) (brz_e se2)

module Brz_d = struct 
  type t = (Sym_expr.t, ((char, Sym_expr.t) Bdd.t) Explicit_deriv.t) Hashtbl.t

  let create () = Hashtbl.create 16

  let rec brz_d t se  : (char, Sym_expr.t) Bdd.node Explicit_deriv.t= 
    let test_zero = Sym_expr.Test Bdd.zero in 
    let test_one = Sym_expr.Test Bdd.one in 
    let derivative = 
      try Hashtbl.find t se with 
      Not_found -> 
        (
          match se with 
          | Sym_expr.Test _ -> Explicit_deriv.all (Bdd.constant test_zero) 
          | Prim p -> Explicit_deriv.all_but_one ~default:(Bdd.constant test_zero) ~exception_key:p ~exception_val:(Bdd.constant test_one)
          | Sum (se1, se2) -> 
            Explicit_deriv.map2 ~f:(fun s1 s2 -> Bdd.apply (Sym_expr.sum) s1 s2) (brz_d t se1) (brz_d t se2)
          | Star se -> 
            Explicit_deriv.map ~f:(Bdd.apply_single (fun x -> Sym_expr.prod x se)) (brz_d t se)
          | Prod (se1, se2) -> 
            let eps_se1 = brz_e se1 in 
            let sym_eps_se1 = Bdd.map ~f:(fun b -> if b then test_one else test_zero) eps_se1 in 
            let brz_d_se1 = brz_d t se1 in 
            let brz_d_se2 = brz_d t se2 in 
            let left = Explicit_deriv.map ~f:(Bdd.apply_single (fun x -> Sym_expr.prod x se2)) brz_d_se1 in 
            let right = Explicit_deriv.map ~f:(Bdd.apply (Sym_expr.prod) sym_eps_se1) brz_d_se2 in 
            Explicit_deriv.map2 ~f:(fun s1 s2 -> Bdd.apply (Sym_expr.sum) s1 s2) left right 
        )
      in 
      derivative

  
end

let are_equivalent _ _ = failwith "todo"