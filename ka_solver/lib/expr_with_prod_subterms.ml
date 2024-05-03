type t = Expr.t * Expr.t list (* This should NOT be a set, b/c idempotency doesn't work for times! *)

(* TODO: Make this recursion better *)
let rec get_times_subterms = function 
  | Expr.Prod (e1, e2) -> List.append (get_times_subterms e1) (get_times_subterms e2) 
  | e -> [e]

(** Populates the set of subterms with the subterms of the highest-level 
    TIMES. For example, the following expression: 
    a(b(c+b)d* + a)cd
    Parses to something like 
    TIMES (a, TIMES(PLUS(... b(c+b)d*, a), TIMES(c,d)))
    So, the subterms for this should be 
    {a, b(c+b)d*+a, c, d}
    That is, we get all the subterms from the top level of nested TIMES, 
    but any non-TIMES that we encounter is not entered, and instead is taken 
    as a subterm, regardless of whether it contains TIMES subterms itself.   
*)
let create_from_expr expr = 
  (expr, get_times_subterms expr)

let subterms t = 
  match t with 
  | (_, terms) -> terms 