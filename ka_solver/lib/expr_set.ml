module Underlying = Set.Make(Expr) (* Not really sure if this is the way to do it? *)

type t = Underlying.t
type elt = Underlying.elt
let empty = Underlying.empty  

let add = Underlying.add 

let singleton = Underlying.singleton
