open Core

type ('a, 'b) node = V of 'b | N of 'a * ('a, 'b) node * ('a, 'b) node 
[@@deriving sexp]
type ('a, 'b) t = ('a, 'b) node
[@@deriving sexp]

let sexp_of_t = sexp_of_t

let constant v = V (v) 

let node a l r = 
    if (phys_equal l r) then l else N (a, l, r)

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

        
        