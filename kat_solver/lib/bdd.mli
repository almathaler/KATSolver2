open Core

(** 'a is the type of decision nodes and 'b is the type of leaves. For example, 
    Sym_kat tests are stored as (char, bool) BDDs *)
type ('a, 'b) node = V of 'b | N of 'a * ('a, 'b) node * ('a, 'b) node 
[@@deriving sexp]
type ('a, 'b) t = ('a, 'b) node
[@@deriving sexp]

val sexp_of_t : ('a -> Sexp.t) -> ('b -> Sexp.t) -> ('a, 'b) t -> Sexp.t
(* I'm just going to skip the memoisation in Pous' paper, because I don't 
   really understand it *)

(** Creates a leaf node *)
val constant : 'b -> (_, 'b) t 

(** Creates a decision node. If the right and left children are equal, 
    just gives the right node *)
val node : 'a -> ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t

(** From Pous Fig. 2, but less polymorphic *)
val apply : ('b -> 'b -> 'b) -> ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t 

val apply_single : ('b -> 'b) -> ('a, 'b) t -> ('a, 'b) t

(** Negates a boolean tree. Just negates all the leaves *)
val negate : ('a, bool) t -> ('a, bool) t

(** LORs two boolean trees *)
val logical_or : ('a, bool) t -> ('a, bool) t -> ('a, bool) t 

(** LANDs two boolean trees *)
val logical_and : ('a, bool) t -> ('a, bool) t -> ('a, bool) t

