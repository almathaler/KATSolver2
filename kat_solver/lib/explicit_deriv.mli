(** A dictionary from 'n'-'z', mapping the KA primitive to ['a] *)
type 'a t 

(** Create a Explicit_deriv.t that maps all primitives ('n'-'z') to the same 
    BDD *)
val all : 'a -> 'a t 

val all_but_one : default:('a) -> exception_key:(char) -> exception_val:('a) -> 'a t 

val map : 'a t -> f:('a -> 'b) -> 'b t 

val map2 : 'a t -> 'a t -> f:('a -> 'a -> 'b) -> 'b t 