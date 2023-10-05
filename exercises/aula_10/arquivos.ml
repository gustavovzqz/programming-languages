let rec ler_e_escrever arquivo = 
  try 
    let linha = input_line arquivo in 
    print_endline linha;
    ler_e_escrever arquivo
  with
  | End_of_file -> ()
;;





let programa () = 
  try
    print_string "Digite o nome arquivo: ";
    let arquivo = open_in (read_line ()) in (* open_in: string -> in_channel*)
    print_endline "Conteúdo do arquivo: ";
    print_endline "---------------------";
    ler_e_escrever arquivo;
    print_endline "---------------------";
    close_in arquivo
  with 
  | Sys_error msg -> Printf.printf "Erro: %s\n" msg 

;;

programa();;