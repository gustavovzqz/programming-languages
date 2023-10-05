(* Escrever um programa que leia de um arquivo:
  Nome,CPF,Idade,Nota e retorna um registro pessoa:
  Nome : String
  CPF : String
  Idade : int
  Média : int *) 

type pessoa = {nome : string; cpf : string; idade : int; media : int };;

let rec gerar_registros arquivo = 
  try 
    let linha = input_line arquivo in
    match String.split_on_char ',' linha with 
    | nome :: cpf :: idade :: media :: [] -> {nome; cpf; idade = int_of_string idade; media = int_of_string media} :: gerar_registros arquivo
    | _ -> failwith "Arquivo inválido!"
  with
  | End_of_file -> []
;;

  


let programa() = 
  try 
    print_endline "Escreva o nome do arquivo a ser lido: ";
    let arquivo = open_in (read_line ()) in 
    let registros = gerar_registros arquivo in 
    close_in arquivo; 
    Some registros
  with
  | Sys_error msg -> None
;;