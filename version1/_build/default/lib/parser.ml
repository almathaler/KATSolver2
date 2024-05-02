
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | ZERO
    | STAR
    | RPAREN
    | PLUS
    | PACTION of (
# 7 "lib/parser.mly"
       (char)
# 19 "lib/parser.ml"
  )
    | ONE
    | LPAREN
    | EOF
  
end

include MenhirBasics

# 1 "lib/parser.mly"
  
    open Kat

# 33 "lib/parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_kat_expr) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: kat_expr. *)

  | MenhirState04 : (('s, _menhir_box_kat_expr) _menhir_cell1_LPAREN, _menhir_box_kat_expr) _menhir_state
    (** State 04.
        Stack shape : LPAREN.
        Start symbol: kat_expr. *)

  | MenhirState07 : (('s, _menhir_box_kat_expr) _menhir_cell1_kat_subterm, _menhir_box_kat_expr) _menhir_state
    (** State 07.
        Stack shape : kat_subterm.
        Start symbol: kat_expr. *)

  | MenhirState09 : ((('s, _menhir_box_kat_expr) _menhir_cell1_kat_subterm, _menhir_box_kat_expr) _menhir_cell1_kat_subterm, _menhir_box_kat_expr) _menhir_state
    (** State 09.
        Stack shape : kat_subterm kat_subterm.
        Start symbol: kat_expr. *)

  | MenhirState11 : (('s, _menhir_box_kat_expr) _menhir_cell1_kat_prod_or_subterm, _menhir_box_kat_expr) _menhir_state
    (** State 11.
        Stack shape : kat_prod_or_subterm.
        Start symbol: kat_expr. *)


and ('s, 'r) _menhir_cell1_kat_prod_or_subterm = 
  | MenhirCell1_kat_prod_or_subterm of 's * ('s, 'r) _menhir_state * (Kat.expr)

and ('s, 'r) _menhir_cell1_kat_subterm = 
  | MenhirCell1_kat_subterm of 's * ('s, 'r) _menhir_state * (Kat.expr)

and ('s, 'r) _menhir_cell1_LPAREN = 
  | MenhirCell1_LPAREN of 's * ('s, 'r) _menhir_state

and _menhir_box_kat_expr = 
  | MenhirBox_kat_expr of (Kat.expr) [@@unboxed]

let _menhir_action_01 =
  fun e ->
    (
# 19 "lib/parser.mly"
                              (e)
# 79 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_02 =
  fun e ->
    (
# 26 "lib/parser.mly"
                  (e)
# 87 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_03 =
  fun e1 e2 ->
    (
# 27 "lib/parser.mly"
                                     (Prod (e1, e2))
# 95 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_04 =
  fun () ->
    (
# 30 "lib/parser.mly"
       (Test Zero)
# 103 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_05 =
  fun () ->
    (
# 31 "lib/parser.mly"
      (Test One)
# 111 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_06 =
  fun e ->
    (
# 32 "lib/parser.mly"
                               (e)
# 119 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_07 =
  fun e ->
    (
# 33 "lib/parser.mly"
                        (Star e)
# 127 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_08 =
  fun x ->
    (
# 34 "lib/parser.mly"
              (PAction x)
# 135 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_09 =
  fun e ->
    (
# 22 "lib/parser.mly"
                          (e)
# 143 "lib/parser.ml"
     : (Kat.expr))

let _menhir_action_10 =
  fun e1 e2 ->
    (
# 23 "lib/parser.mly"
                                                           (Sum (e1, e2))
# 151 "lib/parser.ml"
     : (Kat.expr))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | EOF ->
        "EOF"
    | LPAREN ->
        "LPAREN"
    | ONE ->
        "ONE"
    | PACTION _ ->
        "PACTION"
    | PLUS ->
        "PLUS"
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
  
  let _menhir_run_17 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _v ->
      MenhirBox_kat_expr _v
  
  let rec _menhir_run_01 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_04 () in
      _menhir_goto_kat_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_kat_subterm : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState07 ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState00 ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState11 ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState04 ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_09 : type  ttv_stack. ((ttv_stack, _menhir_box_kat_expr) _menhir_cell1_kat_subterm as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_kat_subterm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EOF | PLUS ->
          let MenhirCell1_kat_subterm (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_03 e1 e2 in
          _menhir_goto_kat_prod_or_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_08 : type  ttv_stack. (ttv_stack, _menhir_box_kat_expr) _menhir_cell1_kat_subterm -> _ -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_kat_subterm (_menhir_stack, _menhir_s, e) = _menhir_stack in
      let _v = _menhir_action_07 e in
      _menhir_goto_kat_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_kat_prod_or_subterm : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState11 ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState00 ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState04 ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_12 : type  ttv_stack. (ttv_stack, _menhir_box_kat_expr) _menhir_cell1_kat_prod_or_subterm -> _ -> _ -> _ -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_kat_prod_or_subterm (_menhir_stack, _menhir_s, e1) = _menhir_stack in
      let e2 = _v in
      let _v = _menhir_action_10 e1 e2 in
      _menhir_goto_kat_sum_or_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_kat_sum_or_subterm : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState04 ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_15 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | EOF ->
          let e = _v in
          let _v = _menhir_action_01 e in
          _menhir_goto_kat_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_kat_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_17 _menhir_stack _v
      | MenhirState04 ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_13 : type  ttv_stack. (ttv_stack, _menhir_box_kat_expr) _menhir_cell1_LPAREN -> _ -> _ -> _ -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LPAREN (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_06 e in
          _menhir_goto_kat_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_05 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | EOF ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let e = _v in
          let _v = _menhir_action_01 e in
          _menhir_goto_kat_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_10 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          let _menhir_stack = MenhirCell1_kat_prod_or_subterm (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState11 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | ZERO ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | PACTION _v ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ONE ->
              _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | EOF ->
          let e = _v in
          let _v = _menhir_action_09 e in
          _menhir_goto_kat_sum_or_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_02 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let x = _v in
      let _v = _menhir_action_08 x in
      _menhir_goto_kat_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_03 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_05 () in
      _menhir_goto_kat_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LPAREN (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState04 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ZERO ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PACTION _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ONE ->
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_07 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_kat_expr) _menhir_state -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | ZERO ->
          let _menhir_stack = MenhirCell1_kat_subterm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState07
      | STAR ->
          let _menhir_stack = MenhirCell1_kat_subterm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PACTION _v_0 ->
          let _menhir_stack = MenhirCell1_kat_subterm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState07
      | ONE ->
          let _menhir_stack = MenhirCell1_kat_subterm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState07
      | LPAREN ->
          let _menhir_stack = MenhirCell1_kat_subterm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState07
      | EOF | PLUS ->
          let e = _v in
          let _v = _menhir_action_02 e in
          _menhir_goto_kat_prod_or_subterm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  let _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_kat_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState00 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ZERO ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PACTION _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ONE ->
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
end

let kat_expr =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_kat_expr v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
