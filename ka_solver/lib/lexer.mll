{  
    open Parser
}

let white = [' ' '\t']+
let primitive = ['a'-'z']

rule read = 
    parse 
    | white { read lexbuf }
    | "0" {ZERO}
    | "1" {ONE}
    | primitive {PRIMITIVE (
        let str = Lexing.lexeme lexbuf in 
            if String.length str > 1 then failwith "primitive read as more than one char"
            else String.get str 0
    )}
    | "(" {LPAREN}
    | ")" {RPAREN}
    | "+" {PLUS}
    | "*" {STAR}
    | eof {EOF}
    | _ as c { failwith (Printf.sprintf "unexpected character: %C" c) }