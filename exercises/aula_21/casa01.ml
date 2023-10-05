let redim v n novo_tam ini = 
  if novo_tam < n then raise (Failure "Tamanho inválido") else 
  let novo = Array.make novo_tam ini in 
  for i = 0 to n - 1 do 
    novo.(i) <- v.(i); 
  done; 
  novo 
;;

let rec inserir indice vetor = 
  try 
  let tam_vetor = Array.length vetor in 
  print_string "Número a inserir (ou outra coisa para parar): ";
  let num = read_int () in 
  if indice < tam_vetor then 
    begin 
      vetor.(indice) <- num;
      inserir (indice + 1) vetor
    end
  else
    let novo_vetor = redim vetor tam_vetor (2 * tam_vetor) 0 in 
    novo_vetor.(indice) <- num;
    inserir (indice + 1) novo_vetor
  with
  | Failure _ -> (indice - 1, vetor)
;;

let exibir () = 
  let (indice, vetor) = inserir 0 [|-1|] in 
  for i = 0 to indice do 
    Printf.printf "v[%d] = %d\n" i vetor.(i);
  done;
  Printf.printf "|v| = %d\n" (Array.length vetor)
;; 






