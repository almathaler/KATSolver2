type t = 
| Zero 
| One 
| Plus of (t * t) 
| Times of (t * t) 
| Star of t

let leftmost_char _ = 
  failwith("TODO")

let compare e1 e2 = 
  Char.compare (leftmost_char e1) (leftmost_char e2) 