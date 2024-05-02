%{
    open Kat
%}

%token ZERO 
%token ONE  
%token <char> PACTION 
%token LPAREN 
%token RPAREN 
%token PLUS 
%token STAR
%token EOF

%start <Kat.expr> kat_expr 

%%

kat_expr: 
| e = kat_sum_or_subterm; EOF {e}

kat_sum_or_subterm:
| e = kat_prod_or_subterm {e}
| e1 = kat_prod_or_subterm; PLUS; e2 = kat_prod_or_subterm {Sum (e1, e2)}

kat_prod_or_subterm: 
| e = kat_subterm {e} 
| e1 = kat_subterm; e2 = kat_subterm {Prod (e1, e2)}

kat_subterm:
| ZERO {Test Zero}
| ONE {Test One}
| LPAREN; e = kat_expr; RPAREN {e}
| e = kat_subterm; STAR {Star e}
| x = PACTION {PAction x}

(* TODO: Add grammar for the T part of KAT, right now just have KA *)