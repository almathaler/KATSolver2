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