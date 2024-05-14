open Core 

type t = 
| Prim of char 
| Sum of (t * t)
| Prod of (t * t) 
| Star of t 
| Test of (char, bool) Bdd.t 
[@@deriving sexp]

let sexp_of_t = sexp_of_t

let rec to_string = function 
| Prim c -> Char.to_string c 
| Star e -> (to_string e) ^ "*"
| Sum (e1, e2) -> (to_string e1) ^ "+" ^ (to_string e2) 
| Prod (e1, e2) -> "(" ^ (to_string e1) ^ ")(" ^ (to_string e2) ^ ")"
| Test t -> Bdd.to_string Char.to_string Bool.to_string t 

(* Because the symbolic Bzd_d constructs new sym_exprs from old sym_exprs, it's 
   better to have Sum and Prod constructors that do the normalization 
   (ACI + merging consecutive tests) for us, expecting the old sym_exprs to be 
   already normalized, rather than re-running something like "aci_normalize" from 
   KA version multiple times on input that is already close to normalized. *)

(* Also, BDDs are de-facto ACI normalized with duplicates removed because 
   of the [node] function *)

let rec get_plus_subterms se = 
  match se with 
  | Sum (se1, se2) -> List.append (get_plus_subterms se1) (get_plus_subterms se2)
  | _ -> [se] 

(** Precondition: acc = (acc', buffer). Buffer is a test => acc' a test. 
    to_add a test => Buffer a test *)
let sum_builder (acc:(t option * t)) (to_add : t) = 
  let (acc, buffer) = acc in 
  match acc with 
  | None -> (Some buffer, to_add)
  | Some acc -> 
    (match acc with 
    | Test t -> 
      (match buffer with 
      | Test t2 -> (Some (Test (Bdd.logical_or t t2)), to_add)
      | _ -> if (Stdlib.(=) buffer to_add) then (Some acc, buffer) else (Some (Sum (acc, buffer)), to_add))
    | _ -> 
      match buffer with 
      | Test _ -> failwith "precondition violated, buffer is test while acc is not"
      | _ -> 
        if (Stdlib.(=) buffer to_add) then (Some acc, buffer) else  
          match to_add with 
          | Test _ -> failwith "precondition violated, to_add is test while buffer is not"
          | _ -> (Some (Sum (acc, buffer)), to_add))

(** ACI Normalizing sum constructor. Sorst and associates to the left, 
    consecutive tests merged, duplicate tests and zeroes removed
    Precondition: [se1] and [se2] are already ACI normalized *)
let sum se1 se2 = 
  match (se1, se2) with 
  | Prim c1, Prim c2 -> 
    (match Stdlib.compare c1 c2 with 
    | 0 -> Prim c1 (*idempotency*)
    | -1 -> Sum (se1, se2)
    | _ -> Sum (se2, se1))
  | Test t1, Test t2 -> Test (Bdd.logical_or t1 t2) 
  | _, _ -> 
    let se1_subterms = get_plus_subterms se1 in 
    let se2_subterms = get_plus_subterms se2 in 
    let subterms = 
      (List.append se1_subterms se2_subterms) |> List.sort ~compare:(fun se1 se2 -> Stdlib.compare (to_string se1) (to_string se2)) in 
    assert (List.length subterms > 1); 
    let almost_sum = List.fold_left (Stdlib.List.tl subterms) ~f:sum_builder ~init:(None, Stdlib.List.hd subterms) in 
    match almost_sum with 
    | (Some se1, se2) -> (
      match se1 with 
      | Test t1 -> (
        match se2 with 
        | Test t2 -> Test (Bdd.logical_or t1 t2)
        | _ -> Sum (se1, se2)
      )
      | _ -> Sum (se1, se2)
    )
    | _ -> failwith "Couldn't build symbolic sum"

let rec of_expr expr = 
  match expr with 
  | Expr.Prim c -> Prim c 
  | Expr.Sum (e1, e2) -> sum (of_expr e1) (of_expr e2)
  | Expr.Prod (e1, e2) -> Prod (of_expr e1, of_expr e2)
  | Expr.Star e -> Star (of_expr e)
  | Expr.Test t -> Test (Test.to_bdd t)
    