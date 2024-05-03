%{
    open Kat
%}

%token ZERO 
%token ONE  
%token <char> PACTION 
%token <char> PTEST
%token LPAREN 
%token RPAREN 
%token PLUS 
%token STAR
%token NEG
%token EOF

%left PLUS

%start <Kat.expr> kat_expr 

%%

kat_expr:
| e = kat_sum_or_subterm ; EOF {e}

kat_sum_or_subterm: 
| e = kat_prod_or_subterm   {e}
| e1 = kat_sum_or_subterm ; PLUS; e2 = kat_sum_or_subterm {Sum (e1, e2)}

kat_prod_or_subterm: 
| e = kat_subterm  {e} 
| e1 = kat_subterm ; e2 = kat_prod_or_subterm  {Prod (e1, e2)}

kat_subterm: 
| ZERO {Test Zero}
| ONE {Test One}
| LPAREN; e = kat_sum_or_subterm ; RPAREN {e}
| e = kat_subterm ; STAR {Star e}
| x = PACTION {PAction x}
| a = PTEST {Test (PTest a)}
| NEG; t = test_prim_or_paren  {Test (Neg t)}

test_prim_or_paren: 
| LPAREN; t = test_sum_or_subterm ; RPAREN {t}
| ZERO {Zero}
| ONE {One}
| NEG; t = test_prim_or_paren  {Neg t}
| a = PTEST {PTest a}


test_sum_or_subterm: 
| t1 = test_sum_or_subterm ; PLUS; t2 = test_sum_or_subterm  {Disj (t1, t2)}
| t = test_prod_or_subterm  {t}

test_prod_or_subterm: 
| t1 = test_prim_or_paren ; t2 = test_prod_or_subterm  {Conj (t1, t2)}
| t = test_prim_or_paren  {t}
