type t = 
| Prim of char 
| Zero 
| One 
| Land of (t * t) 
| Lor of (t * t)
| Not of t 