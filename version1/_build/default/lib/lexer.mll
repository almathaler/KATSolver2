{  
    open Parser
}

let white = [' ' '\t']+
let paction = ['m'-'z']

rule read = 
    parse 
    | white { read lexbuf }
    | "0" {ZERO}
    | "1" {ONE}
    | paction {PACTION (let str = Lexing.lexeme lexbuf in 
                        if String.length str > 1 then failwith "paction read as more than one char"
                        else String.get str 0)}
    | "(" {LPAREN}
    | ")" {RPAREN}
    | "+" {PLUS}
    | "*" {STAR}
    | eof {EOF}