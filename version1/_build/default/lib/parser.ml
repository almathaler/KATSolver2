
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | ZERO
    | STAR
    | RPAREN
    | PTEST of (
# 8 "lib/parser.mly"
       (char)
# 18 "lib/parser.ml"
  )
    | PLUS
    | PACTION of (
# 7 "lib/parser.mly"
       (char)
# 24 "lib/parser.ml"
  )
    | ONE
    | NEG
    | LPAREN
    | EOF
  
end

include MenhirBasics

# 1 "lib/parser.mly"
  
    open Kat

# 39 "lib/parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_kat_expr) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: kat_expr. *)

  | MenhirState05 : (('s, _menhir_box_kat_expr) _menhir_cell1_NEG, _menhir_box_kat_expr) _menhir_state
    (** State 05.
        Stack shape : NEG.
        Start symbol: kat_expr. *)

  | MenhirState09 : (('s, _menhir_box_kat_expr) _menhir_cell1_NEG, _menhir_box_kat_expr) _menhir_state
    (** State 09.
        Stack shape : NEG.
        Start symbol: kat_expr. *)

  | MenhirState10 : (('s, _menhir_box_kat_expr) _menhir_cell1_LPAREN, _menhir_box_kat_expr) _menhir_state
    (** State 10.
        Stack shape : LPAREN.
        Start symbol: kat_expr. *)

  | MenhirState13 : (('s, _menhir_box_kat_expr) _menhir_cell1_test_sum_or_subterm, _menhir_box_kat_expr) _menhir_state
    (** State 13.
        Stack shape : test_sum_or_subterm.
        Start symbol: kat_expr. *)

  | MenhirState16 : (('s, _menhir_box_kat_expr) _menhir_cell1_test_prim_or_paren, _menhir_box_kat_expr) _menhir_state
    (** State 16.
        Stack shape : test_prim_or_paren.
        Start symbol: kat_expr. *)

  | MenhirState20 : (('s, _menhir_box_kat_expr) _menhir_cell1_LPAREN, _menhir_box_kat_expr) _menhir_state
    (** State 20.
        Stack shape : LPAREN.
        Start symbol: kat_expr. *)

  | MenhirState23 : (('s, _menhir_box_kat_expr) _menhir_cell1_kat_subterm, _menhir_box_kat_expr) _menhir_state
    (** State 23.
        Stack shape : kat_subterm.
        Start symbol: kat_expr. *)

  | MenhirState29 : (('s, _menhir_box_kat_expr) _menhir_cell1_kat_expr, _menhir_box_kat_expr) _menhir_state
    (** State 29.
        Stack shape : kat_expr.
        Start symbol: kat_expr. *)


and ('s, 'r) _menhir_cell1_kat_expr = 
  | MenhirCell1_kat_expr of 's * ('s, 'r) _menhir_state * (Kat.expr)

and ('s, 'r) _menhir_cell1_kat_subterm = 
  | MenhirCell1_kat_subterm of 's * ('s, 'r) _menhir_state * (Kat.expr)

and ('s, 'r) _menhir_cell1_test_prim_or_paren = 
  | MenhirCell1_test_prim_or_paren of 's * ('s, 'r) _menhir_state * (Kat.test)

and ('s, 'r) _menhir_cell1_test_sum_or_subterm = 
  | MenhirCell1_test_sum_or_subterm of 's * ('s, 'r) _menhir_state * (Kat.test)

and ('s, 'r) _menhir_cell1_LPAREN = 
  | MenhirCell1_LPAREN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_NEG = 
  | MenhirCell1_NEG of 's * ('s, 'r) _menhir_state

and _menhir_box_kat_expr = 
  | MenhirBox_kat_expr of (Kat.expr) [@@unboxed]

let _menhir_action_01 =
  fun e ->
    (
# 21 "lib/parser.mly"
                              (e)
# 114 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_02 =
  fun e ->
    (
# 28 "lib/parser.mly"
                  (e)
# 122 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_03 =
  fun e1 e2 ->
    (
# 29 "lib/parser.mly"
                                             (Prod (e1, e2))
# 130 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_04 =
  fun () ->
    (
# 32 "lib/parser.mly"
       (Test Zero)
# 138 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_05 =
  fun () ->
    (
# 33 "lib/parser.mly"
      (Test One)
# 146 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_06 =
  fun e ->
    (
# 34 "lib/parser.mly"
                               (e)
# 154 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_07 =
  fun e ->
    (
# 35 "lib/parser.mly"
                        (Star e)
# 162 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_08 =
  fun x ->
    (
# 36 "lib/parser.mly"
              (PAction x)
# 170 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_09 =
  fun a ->
    (
# 37 "lib/parser.mly"
            (Test (PTest a))
# 178 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_10 =
  fun t ->
    (
# 38 "lib/parser.mly"
                              (Test (Neg t))
# 186 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_11 =
  fun e ->
    (
# 24 "lib/parser.mly"
                          (e)
# 194 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_12 =
  fun e1 e2 ->
    (
# 25 "lib/parser.mly"
                                     (Sum (e1, e2))
# 202 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_13 =
  fun t ->
    (
# 41 "lib/parser.mly"
                                          (t)
# 210 "lib/parser.ml"
     : (Kat.test))

let _menhir_action_14 =
  fun () ->
    (
# 42 "lib/parser.mly"
       (Zero)
# 218 "lib/parser.ml"
     : (Kat.test))

let _menhir_action_15 =
  fun () ->
    (
# 43 "lib/parser.mly"
      (One)
# 226 "lib/parser.ml"
     : (Kat.test))

let _menhir_action_16 =
  fun t ->
    (
# 44 "lib/parser.mly"
                              (Neg t)
# 234 "lib/parser.ml"
     : (Kat.test))

let _menhir_action_17 =
  fun a ->
    (
# 45 "lib/parser.mly"
            (PTest a)
# 242 "lib/parser.ml"
     : (Kat.test))

let _menhir_action_18 =
  fun t1 t2 ->
    (
# 53 "lib/parser.mly"
                                                     (Conj (t1, t2))
# 250 "lib/parser.ml"
     : (Kat.test))

let _menhir_action_19 =
  fun t ->
    (
# 54 "lib/parser.mly"
                         (t)
# 258 "lib/parser.ml"
     : (Kat.test))

let _menhir_action_20 =
  fun t1 t2 ->
    (
# 49 "lib/parser.mly"
                                                           (Disj (t1, t2))
# 266 "lib/parser.ml"
     : (Kat.test))

let _menhir_action_21 =
  fun t ->
    (
# 50 "lib/parser.mly"
                           (t)
# 274 "lib/parser.ml"
     : (Kat.test))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | EOF ->
        "EOF"
    | LPAREN ->
        "LPAREN"
    | NEG ->
        "NEG"
    | ONE ->
        "ONE"
    | PACTION _ ->
        "PACTION"
    | PLUS ->
        "PLUS"
    | PTEST _ ->
        "PTEST"
    | RPAREN ->
        "RPAREN"
    | STAR ->
        "STAR"
    | ZERO ->
        "ZERO"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let rec _menhir_run_01 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_04 () in
      _menhir_goto_kat_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_kat_subterm : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | ZERO ->
          let _menhir_stack = MenhirCell1_kat_subterm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState23
      | STAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let e = _v in
          let _v = _menhir_action_07 e in
          _menhir_goto_kat_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PTEST _v_0 ->
          let _menhir_stack = MenhirCell1_kat_subterm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState23
      | PACTION _v_1 ->
          let _menhir_stack = MenhirCell1_kat_subterm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState23
      | ONE ->
          let _menhir_stack = MenhirCell1_kat_subterm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState23
      | NEG ->
          let _menhir_stack = MenhirCell1_kat_subterm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState23
      | LPAREN ->
          let _menhir_stack = MenhirCell1_kat_subterm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState23
      | EOF ->
          let e = _v in
          let _v = _menhir_action_02 e in
          _menhir_goto_kat_prod_or_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_02 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let a = _v in
      let _v = _menhir_action_09 a in
      _menhir_goto_kat_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_03 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let x = _v in
      let _v = _menhir_action_08 x in
      _menhir_goto_kat_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_05 () in
      _menhir_goto_kat_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_05 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_NEG (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState05 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ZERO ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PTEST _v ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ONE ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NEG ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_06 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_14 () in
      _menhir_goto_test_prim_or_paren _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_test_prim_or_paren : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState05 ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState09 ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState10 ->
          _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState16 ->
          _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState13 ->
          _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_19 : type  ttv_stack. (ttv_stack, _menhir_box_kat_expr) _menhir_cell1_NEG -> _ -> _ -> _ -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_NEG (_menhir_stack, _menhir_s) = _menhir_stack in
      let t = _v in
      let _v = _menhir_action_10 t in
      _menhir_goto_kat_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_18 : type  ttv_stack. (ttv_stack, _menhir_box_kat_expr) _menhir_cell1_NEG -> _ -> _ -> _ -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_NEG (_menhir_stack, _menhir_s) = _menhir_stack in
      let t = _v in
      let _v = _menhir_action_16 t in
      _menhir_goto_test_prim_or_paren _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_16 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | ZERO ->
          let _menhir_stack = MenhirCell1_test_prim_or_paren (_menhir_stack, _menhir_s, _v) in
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState16
      | PTEST _v_0 ->
          let _menhir_stack = MenhirCell1_test_prim_or_paren (_menhir_stack, _menhir_s, _v) in
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState16
      | ONE ->
          let _menhir_stack = MenhirCell1_test_prim_or_paren (_menhir_stack, _menhir_s, _v) in
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState16
      | NEG ->
          let _menhir_stack = MenhirCell1_test_prim_or_paren (_menhir_stack, _menhir_s, _v) in
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState16
      | LPAREN ->
          let _menhir_stack = MenhirCell1_test_prim_or_paren (_menhir_stack, _menhir_s, _v) in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState16
      | PLUS | RPAREN ->
          let t = _v in
          let _v = _menhir_action_19 t in
          _menhir_goto_test_prod_or_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_07 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let a = _v in
      let _v = _menhir_action_17 a in
      _menhir_goto_test_prim_or_paren _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_08 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_15 () in
      _menhir_goto_test_prim_or_paren _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_09 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_NEG (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState09 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ZERO ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PTEST _v ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ONE ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NEG ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_10 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LPAREN (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState10 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ZERO ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PTEST _v ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ONE ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NEG ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_test_prod_or_subterm : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState16 ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState10 ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState13 ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_17 : type  ttv_stack. (ttv_stack, _menhir_box_kat_expr) _menhir_cell1_test_prim_or_paren -> _ -> _ -> _ -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_test_prim_or_paren (_menhir_stack, _menhir_s, t1) = _menhir_stack in
      let t2 = _v in
      let _v = _menhir_action_18 t1 t2 in
      _menhir_goto_test_prod_or_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_15 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let t = _v in
      let _v = _menhir_action_21 t in
      _menhir_goto_test_sum_or_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_test_sum_or_subterm : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState13 ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState10 ->
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_14 : type  ttv_stack. ((ttv_stack, _menhir_box_kat_expr) _menhir_cell1_test_sum_or_subterm as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          let _menhir_stack = MenhirCell1_test_sum_or_subterm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RPAREN ->
          let MenhirCell1_test_sum_or_subterm (_menhir_stack, _menhir_s, t1) = _menhir_stack in
          let t2 = _v in
          let _v = _menhir_action_20 t1 t2 in
          _menhir_goto_test_sum_or_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_13 : type  ttv_stack. (ttv_stack, _menhir_box_kat_expr) _menhir_cell1_test_sum_or_subterm -> _ -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState13 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ZERO ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PTEST _v ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ONE ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NEG ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_11 : type  ttv_stack. ((ttv_stack, _menhir_box_kat_expr) _menhir_cell1_LPAREN as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LPAREN (_menhir_stack, _menhir_s) = _menhir_stack in
          let t = _v in
          let _v = _menhir_action_13 t in
          _menhir_goto_test_prim_or_paren _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_test_sum_or_subterm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_20 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LPAREN (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState20 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ZERO ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PTEST _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PACTION _v ->
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ONE ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NEG ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_kat_prod_or_subterm : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState29 ->
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState20 ->
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState23 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_26 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let e = _v in
      let _v = _menhir_action_11 e in
      _menhir_goto_kat_sum_or_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_kat_sum_or_subterm : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let e = _v in
      let _v = _menhir_action_01 e in
      _menhir_goto_kat_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_kat_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState29 ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState20 ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_31 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_kat_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_29 : type  ttv_stack. (ttv_stack, _menhir_box_kat_expr) _menhir_cell1_kat_expr -> _ -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState29 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ZERO ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PTEST _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PACTION _v ->
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ONE ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NEG ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_30 : type  ttv_stack. ((ttv_stack, _menhir_box_kat_expr) _menhir_cell1_kat_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          let _menhir_stack = MenhirCell1_kat_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EOF ->
          let MenhirCell1_kat_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_12 e1 e2 in
          _menhir_goto_kat_sum_or_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_27 : type  ttv_stack. ((ttv_stack, _menhir_box_kat_expr) _menhir_cell1_LPAREN as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LPAREN (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_06 e in
          _menhir_goto_kat_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_kat_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_25 : type  ttv_stack. (ttv_stack, _menhir_box_kat_expr) _menhir_cell1_kat_subterm -> _ -> _ -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_kat_subterm (_menhir_stack, _menhir_s, e1) = _menhir_stack in
      let e2 = _v in
      let _v = _menhir_action_03 e1 e2 in
      _menhir_goto_kat_prod_or_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  let _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState00 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ZERO ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PTEST _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | PACTION _v ->
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ONE ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NEG ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
end

let kat_expr =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_kat_expr v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
