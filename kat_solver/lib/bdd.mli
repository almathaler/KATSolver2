(** From fig. 2 of Pous. 'b is the type of the leaves and 'a is the 
    type of the decision nodes *)
type ('a, 'b) node = ('a, 'b) descr Hashcons.hash_consed 
and ('a, 'b) descr = V of 'b | N of 'a * ('a, 'b) node * ('a, 'b) node 

type ('a, 'b) t = ('a, 'b) node
