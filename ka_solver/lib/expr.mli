(** The AST of a Kleene Algebra Expression*)
type t = 
| Zero 
| One 
| Plus of (t * t) 
| Times of (t * t) 
| Star of t

(** Unintuitively, this compares exprs alphabetically. So for example, 
    a > (b + a) 
    Even though of course in KA a <= b + a. 
    This is for ease of alphabetizing subterms in ACI normalization *)
val compare : t -> t -> int

val leftmost_char : t -> char 