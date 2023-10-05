(*Exercícios para Casa da Aula 10:

    Escreva em OCaml um programa que leia do usuário o nome de um arquivo e que em seguida imprima na tela 
    (a) o número de caracteres do arquivo, 
    (b) o número de linhas e 
    (c) o número de palavras, entendendo-se por palavra uma sequência de 1 ou 
    mais caracteres não brancos delimitados por espaço em branco ou borda de linha. 
    Se certifique de que o seu programa funciona mesmo caso haja dois ou mais espaços separando duas palavras. 
    Você não precisa se preocupar com a corretude da contagem de caracteres acentuados ou outros símbolos
     que ocupem mais de 1 byte.
*)

let rec contar_palavras lista = 
  match lista with 
  | [] -> 0 
  | h :: t -> let qtd_palavras =  contar_palavras t in 
                if h <> "" then 1 + qtd_palavras else qtd_palavras

let rec processar arq_in caracteres palavras = 
  try 
    let linha = input_line arq_in in 
    let qtd_caracteres = String.length linha in 
    let vetor_linha = String.split_on_char ' ' linha in (* Ainda não é o número de palavras da linha *)
    let qtd_palavras = contar_palavras vetor_linha in 
    processar arq_in (caracteres + qtd_caracteres) (palavras + qtd_palavras)

  with
  | End_of_file -> Printf.printf "Número de caracteres: %d\nNúmero de palavras: %d\n" caracteres palavras
;;



let programa () = 
  try 
    print_endline "Insira o nome do arquivo a ser lido: ";
    let arquivo = open_in (read_line()) in 
    processar arquivo 0 0; 
    close_in arquivo
  with
  | Sys_error msg -> Printf.printf "Erro: %s\n" msg
;;

programa ();;