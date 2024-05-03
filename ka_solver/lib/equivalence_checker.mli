(** Associativity, Commutativity and Idempotence Normalization. 
    Also applies the following rules: 
    0x = x0 = 0
    1x = x1 = x 
    0+x = x+0 = x
*)
val aci_normalize : Expr.t -> Expr.t 


val are_equivalent : Expr.t -> Expr.t -> (bool * Expr.t option * Expr.t option)
