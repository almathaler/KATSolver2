(** Associativity, Commutativity and Idempotence Normalization. 
    Also applies the following rules: 
    0x = x0 = 0
    1x = x1 = x 
    0+x = x+0 = x
*)
val aci_normalize : Expr.t -> Expr.t 

module Brz_e : sig 
    type t 

    val create : t
    val brz_e : t -> Expr.t -> int
end

module Brz_d : sig 
    type t 

    val brz_e : Brz_e.t
    val create : t

    val brz_d :
        t ->
        char ->
        Expr.t ->
        Expr.t
end

val are_equivalent : Expr.t -> Expr.t -> (bool * Expr.t option * Expr.t option)
