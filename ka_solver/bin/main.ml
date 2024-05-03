let () =
  let num_args = (Array.length Sys.argv) - 1 in 
  if num_args = 2 then
    (Printf.printf "First expression: %s \n" (Array.get Sys.argv 1);
    Printf.printf "Second expression: %s \n" (Array.get Sys.argv 2))
  else
    Printf.printf "Expected 'dune exec bin/main.exe <exp1> <exp2>', but %i arguments were passed \n" num_args