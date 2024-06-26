open Core

type ('a, 'b) node = V of 'b | N of 'a * ('a, 'b) node * ('a, 'b) node 
[@@deriving sexp]
type ('a, 'b) t = ('a, 'b) node
[@@deriving sexp]

let sexp_of_t = sexp_of_t

let rec to_string a_ts b_ts t = 
    match t with 
    | V b ->  "["^ (b_ts b) ^ "]" 
    | N (a, n1, n2) -> "(" ^ (a_ts a) ^(to_string a_ts b_ts n1)^ (to_string a_ts b_ts n2)^")"

let constant v = V (v) 

let zero = V (false)
let one = V (true)

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
        
let rec map ~f (bdd : ('a, 'b) t) : ('a, 'c) t = 
    match bdd with 
    | V v -> constant (f v) 
    | N(a, l, r) -> node a (map ~f l) (map ~f r)

(* From Pous fig 5 *)
let rec iter2 ~f bdd1 bdd2 : unit = 
    match (bdd1, bdd2) with 
    | V v, V w -> f v w
    | V _, N(_, l, r) -> iter2 ~f bdd1 l; iter2 ~f bdd1 r
    | N(_, l, r), V _ -> iter2 ~f l bdd2; iter2 ~f r bdd2 
    | N(a, l, r), N(a', l', r') -> (
        match Stdlib.compare a a' with 
        | 0 -> iter2 ~f l l'; iter2 ~f r r' 
        | -1 -> iter2 ~f l bdd2; iter2 ~f r bdd2 
        | _ -> iter2 ~f bdd1 l'; iter2 ~f bdd1 r'
    )

let negate bdd = apply_single (not) bdd

let logical_or l r = apply (||) l r

let logical_and l r = apply (&&) l r