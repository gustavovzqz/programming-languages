let rec maior_linha arquivo maior texto_ = 
  try 
    let texto = input_line arquivo in 
    let tam = String.length texto in 
    if tam > maior then maior_linha arquivo tam texto  else maior_linha arquivo maior texto_
  with
  | End_of_file -> print_endline texto_
;;

(* Essa função não é recursiva de cauda por conta do End_of_file (do try match), verificar o outro arquivo
   com a tail recursion *)


let programa () = 
  try
    print_string "Digite o nome arquivo: ";
    let arquivo = open_in (read_line ()) in (* open_in: string -> in_channel*)
    print_endline "Conteúdo do arquivo: ";
    print_endline "---------------------";
    maior_linha arquivo 0 "";
    print_endline "---------------------";
    close_in arquivo
  with 
  | Sys_error msg -> Printf.printf "Erro: %s\n" msg 

;;

programa();;