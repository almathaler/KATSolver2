{  
    open Parser
}

let white = [' ' '\t']+
let paction = ['m'-'z']
let ptest = ['a'-'l']

rule read = 
    parse 
    | white { read lexbuf }
    | "0" {ZERO}
    | "1" {ONE}
    | paction {PACTION (
        let str = Lexing.lexeme lexbuf in 
            if String.length str > 1 then failwith "paction/ptest read as more than one char"
            else String.get str 0
    )}
    | ptest {PTEST (
        let str = Lexing.lexeme lexbuf in 
            if String.length str > 1 then failwith "paction/ptest read as more than one char"
            else String.get str 0
    )}
    | "(" {LPAREN}
    | ")" {RPAREN}
    | "+" {PLUS}
    | "*" {STAR}
    | "!" {NEG}
    | eof {EOF}
    | _ as c { failwith (Printf.sprintf "unexpected character: %C" c) }