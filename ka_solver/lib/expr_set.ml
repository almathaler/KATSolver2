module Underlying = Set.Make(Expr) (* Not really sure if this is the way to do it? *)

type t = Underlying.t
type elt = Underlying.elt
let empty = Underlying.empty  

let add = Underlying.add 

let singleton = Underlying.singleton

let to_list = Underlying.to_list

let of_list = Underlying.of_list
