open Core 
open Kat_solver 

let parse (s : string) : Expr.t = 
  let lexbuf = Lexing.from_string s in 
  let exp = Parser.expr Lexer.read lexbuf in 
  exp 

let test str1 str2 = 
  let sym_expr1 = str1 |> parse |> Sym_expr.of_expr in 
  let sym_expr2 = str2 |> parse |> Sym_expr.of_expr in 
  let (ans, w1, w2) = Equivalence_checker.are_equivalent sym_expr1 sym_expr2 in 
  let str_w w = match w with 
  | None -> "None"
  | Some w -> Sym_expr.to_string w 
  in 
  Printf.printf "ans: %b, w1: %s, w2: %s" ans (str_w w1) (str_w w2)

let%expect_test "a, a" = 
  test "a" "a"; 
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "a, b" = 
  test "a" "b"; 
  [%expect {|
    ans: false, w1: (a[false][true]), w2: (b[false][true]) |}]

let%expect_test "1a, a" = 
  test "1a" "a"; 
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "!a, a" = 
  test "!a" "a"; 
  [%expect {|
    ans: false, w1: (a[true][false]), w2: (a[false][true]) |}]

let%expect_test "ab+!b, ab" = 
  test "ab+!b" "ab"; 
  [%expect {|
    ans: false, w1: (a(b[true][false])[true]), w2: (a[false](b[false][true])) |}]

let%expect_test "ax0, ax" = 
  test "ax0" "ax"; 
  [%expect {|
    ans: false, w1: [false], w2: [true] |}]

let%expect_test "1, x*" = 
  test "1" "x*"; 
  [%expect {|
    ans: false, w1: [false], w2: x* |}]

let%expect_test "1+x*, x*" = 
  test "1+x*" "x*"; 
  [%expect {| ans: true, w1: None, w2: None |}]

(* From Sec. 4 of Pous, some simple laws from KAT *)
let%expect_test "a + !a = 1" = 
  test "a+!a" "1"; 
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "a(!a+b) = ab" = 
  test "a(!a+b)" "ab";
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "ab = !(!a+!b)" = 
  test "!(!a+!b)" "ab"; 
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "a(!a+b) = !(!a+!b)" = 
  test "a(!a+b)" "!(!a+!b)"; 
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "x*x* = x*" = 
  test "x*x*" "x*"; 
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "(x+y)* = x*(yx*)*" = 
  test "(x+y)*" "x*(yx*)*"; 
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "a(!ax)* = a" = 
  test "a(!ax)*" "a"; 
  [%expect {| ans: true, w1: None, w2: None |}]

(* Examples from https://perso.ens-lyon.fr/damien.pous/symbolickat/ *)
let%expect_test "(p+q)* = p*(qp*)*" = 
  test "(p+q)*" "p*(qp*)*";
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "(p+q)* = ((1+p)(1+q))*" = 
  test "(p+q)*" "((1+p)(1+q))*"; 
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "(pp)*(ppp)* = (ppp)*(pp)*" = 
  test "(pp)*(ppp)*" "(ppp)*(pp)*"; 
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "(pp)*+p* = (ppp)*+p*" =
  test "(pp)*+p*" "(ppppp)*+p*"; 
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "(ar!a)*, 1+ar!a" = 
  test "(ar!a)*" "1+ar!a"; 
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "(bc+!b!c)(brs+!brt) = bcrs+!b!crt" = 
  test "(bc+!b!c)(brs+!brt)" "bcrs+!b!crt"; 
  [%expect {| ans: true, w1: None, w2: None |}]

(* WRONG *)
let%expect_test "arp*+!arp** = brp*+!brp**" = 
  test "arp*+!arp**" "brp*+!brp**"; 
  [%expect {|
    ans: true, w1: None, w2: None |}]

let%expect_test "arp**+brq** = arp*+brq*" = 
  test "arp**+brq**" "arp*+brq*"; 
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "(ap)*!a(ap)*!a = (ap)*!a" = 
  test "(ap)*!a(ap)*!a" "(ap)*!a"; 
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "a(ap!a+!aqa)*a = a(p!aqa)*" = 
  test "a(ap!a+!aqa)*a" "a(p!aqa)*"; 
  [%expect {| ans: true, w1: None, w2: None |}]

let%expect_test "a(cpq+!cp)+!a(cpq+!cp) = c(bpq+!bpq)+!cp" = 
  test "a(cpq+!cp)+!a(cpq+!cp)" "c(bpq+!bpq)+!cp";
  [%expect {| ans: true, w1: None, w2: None |}]








