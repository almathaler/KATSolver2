open Core

type ('a, 'b) node = V of 'b | N of 'a * ('a, 'b) node * ('a, 'b) node 
[@@deriving sexp]
type ('a, 'b) t = ('a, 'b) node
[@@deriving sexp]

let sexp_of_t = sexp_of_t

let constant v = V (v) 

let node a l r = 
    if (Stdlib.(=) l r) then l else N (a, l, r)

let rec apply (f: 'b -> 'b -> 'b) (left: ('a, 'b) t) (right : ('a, 'b) t) = 
    match (left, right) with 
    | V v, V w -> constant (f v w)
    | N(a, l, r), V _ -> node a (apply f l right) (apply f r right) 
    | V _, N(a, l, r) -> node a (apply f left l) (apply f left r)
    | N(a, l, r), N(a', l', r') -> 
        match Stdlib.compare a a' with 
        | 0 -> (node a (apply f l l') (apply f r r'))
        | -1 -> (node a (apply f l right) (apply f r right))
        | _ -> (node a' (apply f left l') (apply f left r'))

let rec apply_single (f: 'b -> 'b) (bdd : ('a, 'b) t) : ('a, 'b) t = 
    match bdd with 
    | V v -> constant (f v) 
    | N(a, l, r) -> node a (apply_single f l) (apply_single f r)
        
let negate bdd = apply_single (not) bdd

let logical_or l r = apply (||) l r

let logical_and l r = apply (&&) l r