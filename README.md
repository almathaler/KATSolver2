# KATSolver2
## Running Instructions:
[core], [menhir], and [ocamllex] are needed for both implementations (as is 
a version of the OCaml compiler. This was made with Ocaml 5.1.1). 

To install [core], run:
[opam install core]

To install [menhir], run:
[opam instasll menhir]

To use [ka_solver], run: 
[dune exec ka_solver help]
from the [ka_solver] directory

To use [kat_solver], run: 
[dune exec kat_solver help]
from [kat_solver]

## More info:

[ka_solver] is a simple implementation of a kleene algebra expression equivalence
checker, using bisimulations on regular set automatons to determine equivalence.
This uses ideas from class and from https://www.cs.cornell.edu/courses/cs6861/2024sp/Papers/Pous.pdf.

[kat_solver] is also a simple implementation of a KAT expression equivalence 
checker, using bisimulations on guarded string set automatons to determine 
equivalence. This uses more ideas from https://www.cs.cornell.edu/courses/cs6861/2024sp/Papers/Pous.pdf, 
except memoization. 

There already exists a KAT expression equivalence checker made by Pous at 
https://perso.ens-lyon.fr/damien.pous/symbolickat/. I don't add anything new and 
this implementation is not nearly as fast or efficient; regardless, this was a 
useful and time-intensive exercise. In this project I thought about 
translating concepts from class (automaton exploration, bisimulations + coalgebras, 
Brzozowski derivatives) into actual code. Most of all it took a while to plan 
the data structures needed for representing symbolic derivatives. Even though 
the paper is quite explicit it took a few read-throughs for me to understand 
what objects the symbolic derivatives dealt with. 



