let programa () = 
  let p = Pilha.criar 0 in 
  let rec ler () = 
    try 
      print_string "# a empilhar (outra coisa p/ parar): ";
      Pilha.empilhar p (read_int());
      ler ()
    with 
    | Failure _ -> ()
  in 
  ler();
  while not (Pilha.vazia p) do 
    Printf.printf "Desempilhando: %d\n" (Pilha.desempilhar p)
  done
;;

programa ();;