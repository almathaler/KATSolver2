%{
    open Expr
%}

%token ZERO 
%token ONE  
%token <char> PRIMITIVE 
%token LPAREN 
%token RPAREN 
%token PLUS 
%token STAR
%token EOF

%left PLUS

%start <Expr.t> ka_expr 

%%

ka_expr:
| e = ka_sum_or_subterm ; EOF {e}

ka_sum_or_subterm: 
| e = ka_prod_or_subterm   {e}
| e1 = ka_sum_or_subterm ; PLUS; e2 = ka_sum_or_subterm {Sum (e1, e2)}

ka_prod_or_subterm: 
| e = ka_subterm  {e} 
| e1 = ka_subterm ; e2 = ka_prod_or_subterm  {Prod (e1, e2)}

ka_subterm: 
| ZERO {Zero}
| ONE {One}
| LPAREN; e = ka_sum_or_subterm ; RPAREN {e}
| e = ka_subterm ; STAR {Star e}
| x = PRIMITIVE {Prim x}
