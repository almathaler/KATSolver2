type t 

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
val create_from_expr : Expr.t -> t

val subterms : t -> Expr_set.t