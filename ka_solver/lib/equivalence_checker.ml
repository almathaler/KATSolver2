let _e_memo : (Expr.t, int) Hashtbl.t = Hashtbl.create 16 
let _d_memo : (Expr.t, Expr.t) Hashtbl.t = Hashtbl.create 16 

let _brz_e _ : Expr.t -> int = failwith "todo"

let _brz_d _ _ : char -> Expr.t -> Expr.t = failwith "todo"

let rec reassociate subterms constructor = 
  List.fold_left (fun acc subterm -> constructor acc (aci_normalize subterm)) 
    (subterms |> List.hd) (subterms |> List.tl)

    (* TODO *)
and aci_plus expr  = 
  let subtermed_expr = Expr_with_sum_subterms.create_from_expr expr in 
  (* Now we want to delete duplicates, order alphabetically, 
     and re-associate to the left *)
  let subterms = Expr_with_sum_subterms.subterms subtermed_expr in 
  let no_dupes_subterms = Expr_set.to_list subterms in 
  let alphabetized_and_no_dupes_subterms = List.stable_sort Expr.compare no_dupes_subterms in
  reassociate alphabetized_and_no_dupes_subterms (fun e1 e2 -> Expr.Sum (e1, e2))

and aci_times expr =
  let subtermed_expr = Expr_with_prod_subterms.create_from_expr expr in 
  (* Now we want to re-associate to the left *)
  let subterms = Expr_with_prod_subterms.subterms subtermed_expr in 
  reassociate subterms (fun e1 e2 -> Expr.Prod (e1, e2))


and aci_normalize expr = 
  match expr with 
  | Expr.Prod (Zero, _)  | Expr.Prod (_, Zero) -> Zero 
  | Expr.Prod (One, e) | Expr.Prod (e, One) -> e 
  | Expr.Prod _ -> aci_times expr 
  | Expr.Sum (Zero, e) | Expr.Sum (e, Zero) -> e
  | Expr.Sum _ -> aci_plus expr
  | _ -> expr (* Nothing to normalize *)

let are_equivalent _ _ = failwith "todo"