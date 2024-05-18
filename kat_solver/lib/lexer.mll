{  
    open Parser
}

let white = [' ' '\t']+
let tprim = ['a'-'j']
let kprim = ['k'-'z']

rule read = 
    parse 
    | white { read lexbuf }
    | "0" {ZERO}
    | "1" {ONE}
    | tprim {TPRIM (
        let str = Lexing.lexeme lexbuf in 
            if String.length str > 1 then failwith "test primitive read as more than one char"
            else String.get str 0
    )}
    | kprim {KPRIM (
        let str = Lexing.lexeme lexbuf in 
            if String.length str > 1 then failwith "test primitive read as more than one char"
            else String.get str 0
    )}
    | "~" {NOT}
    | "(" {LPAREN}
    | ")" {RPAREN}
    | "+" {PLUS}
    | "*" {STAR}
    | eof {EOF}
    | _ as c { failwith (Printf.sprintf "unexpected character: %C" c) }