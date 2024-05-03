let _e_memo : (Expr.t, int) Hashtbl.t = Hashtbl.create 16 
let _d_memo : (Expr.t, Expr.t) Hashtbl.t = Hashtbl.create 16 

let _brz_e _ : Expr.t -> int = failwith "todo"

let _brz_d _ _ : char -> Expr.t -> Expr.t = failwith "todo"

let rec reassociate subterms constructor = 
  List.fold_left (fun acc subterm -> constructor acc (aci_normalize subterm)) (subterms |> List.hd) (subterms |> List.tl)

and aci_plus _  = failwith "todo"

and aci_times expr =
  let subtermed_expr = Expr_with_times_subterms.create_from_expr expr in 
  (* Now we want to re-associate to the left *)
  let subterms = Expr_with_times_subterms.subterms subtermed_expr in 
  reassociate (Expr_set.to_list subterms) (fun e1 e2 -> Expr.Prod (e1, e2))


and aci_normalize expr = 
  match expr with 
  | Expr.Prod _ -> aci_times expr 
  | Expr.Sum _ -> aci_plus expr
  | _ -> expr (* Nothing to normalize *)

let are_equivalent _ _ = failwith "todo"