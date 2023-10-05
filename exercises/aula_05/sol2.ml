(* As seguintes operações devem existir no programa:
1) Inserção : digitar um nome, uma idade e inserir no cadastro, não deve haver nomes repetidos 
2) Consulta geral: imprimir todo o cadastro na tela
3) Consulta específica: informar idade a partir do nome digitado
4) Remoção: remover um elemento a partir do nome
5) Saida: sair do programa *)

(* Uma pessoa será uma tupla de nome e telefone *)

(* Inserir *)
let inserir l1 = 
    print_endline "Insira o nome: ";
    let nome = read_line () in 
    print_endline "Insira a idade:";
    let idade = read_int () in 
    let rec verificar_repetido l1 nome = 
      match l1 with 
      | [] -> true 
      | (a, _) :: t -> if a = nome then false else verificar_repetido t nome in 
    if verificar_repetido l1 nome then
      begin 
      print_endline "Nome inserido com sucesso!";
      (nome, idade) :: l1 
      end
    else
      begin
      print_endline "Não foi possível inserir o nome.";
      l1
      end
  ;;

(* Imprimir todo o cadastro na tela *)
let rec imprimir l1 = 
  match l1 with 
  | [] -> print_endline "Fim do cadastro!"
  | (nome, idade) :: t -> 
    Printf.printf("%s %d\n") nome idade;
    imprimir t
;;

let rec imprimir_nome l1 nome = 
  match l1 with 
  | [] -> print_endline "Fim dos dados."
  | (a, b) :: t ->
    if a = nome then 
      Printf.printf"O usuário %s possui %d anos\n" a b
    else
      imprimir_nome t nome;;

(* Impressão específica *)
let imprimir_por_nome l1 = 
  print_endline "Insira o nome: ";
  let nome = read_line () in 
  imprimir_nome l1 nome;;


let rec remover_elemento l1 elemento =  
  match l1 with 
  | [] -> print_endline "Não há elementos com esse nome "; []
  | (a, b) :: t -> if a = elemento then 
    begin
     print_endline "Elemento removido!";
     t  
    end
    else (a, b) :: remover_elemento t elemento 
;; 

(* Remoção por nome *)
let remover l1 = 
  print_endline "Insira o nome: ";
  let elemento = read_line () in
  remover_elemento l1 elemento;;

let rec programa status l1 =
  if status = 5 then () else 
    begin 
    print_string "-: ";
    let status = read_int () in
    match status with 
    | 1 -> programa 1 (inserir l1)
    | 2 -> imprimir l1; programa 2 l1
    | 3 -> imprimir_por_nome l1; programa 3 l1
    | 4 -> programa 4 (remover l1)
    | 5 -> programa 5 l1
    | _ -> ()
    end
  ;;

let () = 
  Printf.printf "[1] Inserir\n[2] Imprimir\n[3] Consulta\n[4] Remover\n[5] Sair\n";
  programa 0 [];;