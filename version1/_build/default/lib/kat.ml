type paction = char (* m - z *)
type ptest = char (* a - l *)

type test = 
| PTest of ptest 
| Zero 
| One 
| Conj of test * test (* ^ *)
| Disj of test * test (* v *)
| Neg of test 

(* Since boolean exprs count as action terms, let's just call this expr for 
   KAT expr. *)
type expr = 
| PAction of paction 
| Sum of expr * expr  
| Prod of expr * expr 
| Star of expr 
| Test of test 

let rec to_string exp = 
   "(" ^ (match exp with 
   | PAction p -> String.make 1 p  
   | Sum (e1, e2) -> (to_string e1) ^ "+" ^ (to_string e2)
   | Prod (e1, e2) -> (to_string e1) ^ (to_string e2) 
   | Star e1 -> (to_string e1) ^ "*" 
   | Test _ -> "TEST: TODO") ^ ")"