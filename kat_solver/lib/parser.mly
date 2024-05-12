%token ZERO
%token ONE 
%token <char> KPRIM 
%token <char> TPRIM 
%token LPAREN 
%token RPAREN 
%token PLUS 
%token STAR 
%token NOT 
%token EOF 

%left PLUS 

%start <Expr.t> expr 

%% 

expr: 
| e = sum_or_subterm; EOF {e} 

sum_or_subterm:
| e = prod_or_subterm {e}
| e1 = sum_or_subterm; PLUS; e2 = sum_or_subterm {Expr.Sum (e1, e2)}

prod_or_subterm:
| e = subterm {e} 
| e1 = subterm; e2 = prod_or_subterm {Expr.Prod (e1, e2)}

subterm: 
| LPAREN; e = sum_or_subterm; RPAREN {e}
| e = subterm; STAR {Expr.Star e}
| x = KPRIM {Expr.Prim x}
| ZERO {Expr.Test (Test.Zero)}
| ONE {Expr.Test (Test.One)}
| NOT; t = test_subterm {Expr.Test (Test.Not t)}
| t = TPRIM {Expr.Test (Test.Prim t)}

test_subterm: 
| ZERO {Test.Zero}
| ONE {Test.One}
| LPAREN; t = test_sum_or_subterm; RPAREN {t}
| t = TPRIM {Test.Prim t}
| NOT; t = test_subterm {Test.Not t}

test_sum_or_subterm: 
| t = test_prod_or_subterm {t} 
| t1 = test_sum_or_subterm; PLUS; t2 = test_sum_or_subterm {Test.Lor (t1, t2)}

test_prod_or_subterm:
| t = test_subterm {t}
| t1 = test_subterm; t2 = test_prod_or_subterm {Test.Land (t1, t2)}