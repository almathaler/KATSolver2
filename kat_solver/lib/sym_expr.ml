type t = 
| Prim of char 
| Sum of (t * t)
| Prod of (t * t) 
| Star of t 
| Test of (char, bool) Bdd.t 

let of_expr (_ : Expr.t) : t = failwith "todo"