type 'a t = (char * 'a) list 

let prims =  ['n'; 'o'; 'p'; 'q'; 'r'; 's';'t'; 'u'; 'v'; 'w';'x';'y';'z']


let all v = 
  List.map (fun c -> (c, v)) prims
let all_but_one ~default ~exception_key ~exception_val = 
  List.map (fun c -> if (c = exception_key) then (c, exception_val) else (c, default)) prims 

let map t ~f = 
  List.map (fun (c, v) -> (c, f v)) t 

let map2 t1 t2 ~f = 
  List.map2 (fun (c1, v1) (c2, v2) -> assert (c1 = c2); (c1, f v1 v2)) t1 t2 

let iter2 ~f t1 t2 = 
  List.iter2 (fun (c1, v1) (c2, v2) -> assert (c1 = c2); f v1 v2) t1 t2

let to_string t = 
  let af = Core.Char.to_string in 
  let bf = Sym_expr.to_string in 
  List.fold_left (fun acc (c, v) -> acc ^ (
    Printf.sprintf "(%c, %s)\n" c (Bdd.to_string af bf v) 
  )) "" t