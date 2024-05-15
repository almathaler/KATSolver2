module Brz_e : sig 
    type t 

    val create : unit -> t
    val brz_e : t -> Sym_expr.t -> (char, bool) Bdd.t
end

module Brz_d : sig 
    type t 

    val create : unit -> t

    val brz_d: t ->
        Sym_expr.t ->
        (char, Sym_expr.t) Bdd.node Explicit_deriv.t 
end

val are_equivalent : Expr.t -> Expr.t -> (bool * Expr.t option * Expr.t option)
