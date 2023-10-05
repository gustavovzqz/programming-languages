(* Faça um programa que abre um arquivo para leitura, *)

let listar_funcionarios () = 
  let arq = open_in "funcionarios.txt" in 
  let rec mostrar_func arquivo = 
    try
      let texto = String.split_on_char ',' (input_line arquivo) in 
      match texto with 
      | nome :: carg :: sal :: [] -> Printf.printf "%s - %s - %s\n" nome carg sal; mostrar_func arq
      | _ -> failwith "Texto no formato inválido"
    with
    | End_of_file -> ()
  in 
  mostrar_func arq;
  close_in arq
;;

let escrever_arquivo () = 
  let arq_in = open_in "funcionarios.txt" in 
  let rec aux arq_in linha = 
    try 
      aux arq_in (linha ^ "\n" ^ input_line arq_in)
    with
    | End_of_file -> linha 
  in 
  let linha1 = 
  try 
    input_line arq_in
  with
  | End_of_file -> "" 
  in
  let texto = aux arq_in linha1 in 
  print_endline "Insira o novo funcionário a ser inserido: " ;
  let novo = read_line () in 
  close_in arq_in; 
  let arq_out = open_out "funcionarios.txt" in 
  output_string arq_out (texto ^ "\n" ^ novo);
  close_out arq_out
;;
