type t = Expr.t * Expr_set.t

let rec get_plus_subterms = function 
  | Expr.Sum (e1, e2) -> List.append (get_plus_subterms e1) (get_plus_subterms e2) 
  | e -> [e]
let create_from_expr expr = 
  let subterms_list = get_plus_subterms expr in 
  (* Printf.printf "Pre de-dupe subterms: %s \n" (subterms_list |> 
    Core.List.sexp_of_t Expr.sexp_of_t |> Core.Sexp.to_string_hum); *)
  (expr, Expr_set.of_list subterms_list)
let subterms t = 
  match t with 
  | (_, terms) -> (
    (* Printf.printf "No dupes subterms: %s \n" ((Expr_set.to_list terms) |> Core.List.sexp_of_t Expr.sexp_of_t|> Core.Sexp.to_string_hum); *)
    terms)