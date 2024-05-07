module Brz_e = struct 
  type t = (Expr.t, int) Hashtbl.t

  let create : t = Hashtbl.create 16 

  let rec brz_e t (expr : Expr.t) = 
    (* Printf.printf "brz_e of %s \n" (Expr.to_string expr); *)
    try Hashtbl.find t expr with 
    Not_found -> 
      let derivative = 
        (match expr with 
          | Prim _ -> 0 
          | Zero -> 0 
          | One -> 1 
          | Sum (e1, e2) -> Int.logor (brz_e t e1) (brz_e t e2)
          | Prod (e1, e2) -> Int.logand (brz_e t e1) (brz_e t e2) 
          | Star _ -> 1) in 
      Hashtbl.add t expr derivative; 
      (* Printf.printf "derivative: %i \n" (derivative); *)
      derivative


end

module Brz_d = struct 
  type t = ((char * Expr.t), Expr.t) Hashtbl.t 

  let brz_e = Brz_e.create 
  let create : t = Hashtbl.create 16 

  let rec brz_d t (a : char) (expr : Expr.t) : Expr.t = 
    try Hashtbl.find t (a, expr) with 
    Not_found -> 
      let derivative : Expr.t = (match expr with 
      | Prim b -> if (a=b) then One else Zero 
      | Zero -> Zero 
      | One -> Zero 
      | Sum (e1, e2) -> 
        (Sum((brz_d t a e1), (brz_d t a e2)))
      | Prod (e1, e2) -> (
        Sum (
          Prod (brz_d t a e1, e2), 
          Prod (Expr.int_to_expr (Brz_e.brz_e brz_e e1), brz_d t a e2)
        )
      )
      | Star s -> (
        Prod (brz_d t a s, Star s)
      )) in 
      Hashtbl.add t (a, expr) derivative; 
      derivative

end

let rec reassociate subterms constructor = 
  List.fold_left (fun acc subterm -> constructor acc (aci_normalize subterm)) 
    (subterms |> List.hd) (subterms |> List.tl)

and aci_plus expr  = 
  let subtermed_expr = Expr_with_sum_subterms.create_from_expr expr in 
  (* Now we want to delete duplicates, order alphabetically, 
     and re-associate to the left *)
  let subterms = Expr_with_sum_subterms.subterms subtermed_expr in 
  let no_dupes_subterms = Expr_set.to_list subterms in 
  let alphabetized_and_no_dupes_subterms = List.stable_sort Expr.compare no_dupes_subterms in
  reassociate alphabetized_and_no_dupes_subterms (fun e1 e2 -> Expr.Sum (e1, e2))

and aci_times expr =
  let subtermed_expr = Expr_with_prod_subterms.create_from_expr expr in 
  (* Now we want to re-associate to the left *)
  let subterms = Expr_with_prod_subterms.subterms subtermed_expr in 
  reassociate subterms (fun e1 e2 -> Expr.Prod (e1, e2))


and aci_normalize expr = 
  match expr with 
  | Expr.Prod (Zero, _)  | Expr.Prod (_, Zero) -> Zero 
  | Expr.Prod (One, e) | Expr.Prod (e, One) -> aci_normalize e 
  | Expr.Prod _ -> aci_times expr 
  | Expr.Sum (Zero, e) | Expr.Sum (e, Zero) -> aci_normalize e
  | Expr.Sum _ -> aci_plus expr
  | _ -> expr (* Nothing to normalize *)


(* From Pous. This func. attempts to find a bisimulation (r). If it encounters 
   two states (s1, s2) reached via the same input from e1 and e2 respectively 
   such that their obs is different, fails. If can explore the whole automata
   without violating that, then equivalent. *)
let are_equivalent e1 e2 = 
  let e1 = aci_normalize e1 in 
  let e2 = aci_normalize e2 in 
  Printf.printf "ACI normalized e1: %s \n" (Expr.to_string e1); 
  Printf.printf "ACI normalized e2: %s \n" (Expr.to_string e2);
  let brz_e = Brz_e.create in 
  let brz_d = Brz_d.create in 
  let unioned_alphabet = Expr.alphabet e1 |> List.append (Expr.alphabet e2) |> Core.List.dedup_and_sort ~compare:Char.compare in
  (* Printf.printf "Unioned alphabet: {%s} \n" (List.fold_left (fun acc a -> acc ^ (String.make 1 a) ^ "; ") "" unioned_alphabet); *)
  let r = ref Expr_pair_set.empty in 
  let todo : (Expr.t * Expr.t) Queue.t = Queue.create () in 
  Queue.push (e1, e2) todo;
  let ans = ref true in 
  let witness_state1 = ref Option.None in 
  let witness_state2 = ref Option.None in 
  while not (Queue.is_empty todo) do 
    let (s1, s2) = Queue.pop todo in 
    (* Printf.printf "s1: %s s2: %s \n" (Expr.to_string s1) (Expr.to_string s2); *)
    (if not (Expr_pair_set.mem (s1, s2) !r) then 
      (* Printf.printf "s1 and s2 not seen yet, getting derivatives... \n";       *)
      let e_s1 = Brz_e.brz_e brz_e (s1) in 
      let e_s2 = Brz_e.brz_e brz_e (s2) in 
      if e_s1 = e_s2 then 
        (List.iter (fun a -> 
                      Queue.push ((Brz_d.brz_d brz_d a s1), (Brz_d.brz_d brz_d a s2)) todo) unioned_alphabet;
        r := Expr_pair_set.add (s1, s2) !r)
      else 
        (
        (* Printf.printf "bzd_e not the same \n";   *)
        ans := false; 
        witness_state1 := Option.Some s1; 
        witness_state2 := Option.Some s2; 
        Queue.clear todo));
    (* Printf.printf "Size of todo: %i \n" (Queue.length todo); *)
  done;
  (!ans, !witness_state1, !witness_state2)