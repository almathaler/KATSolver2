type t = 
| Prim of char 
| Sum of (t * t)
| Prod of (t * t) 
| Star of t 
| Test of Test.t