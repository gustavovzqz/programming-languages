(* Ler notas de estudantes *) (* Começar do zero em casa hoje à noite*)

exception ValidarNota of string;;

let validar_qtd qtd = 
    let qtd = int_of_string qtd in 
    if qtd <= 0 then raise (ValidarNota "O número não atende a restrição") else qtd
;;


let rec media lista qtd i = 
  match lista with 
  | [] -> 0.
  | h :: t -> if i < qtd then (float_of_string h /. qtd) +. media t qtd (i+.1.) else 0.
;;


let rec mostrar_medias lista qtd i = 
  match lista with 
  | [] -> ()
  | h :: t -> if (i = 0 || i mod (qtd+1) = 0) then
    begin 
      Printf.printf "A média de %s é %g\n" h (media t (float_of_int qtd)  0.);
      mostrar_medias t qtd (i+1)
    end
  else mostrar_medias t qtd (i+1)
;;

let rec validar_notas notas = 
  match notas with 
  | [] -> ()
  | h :: t -> float_of_string h; validar_notas t;; (* O programa está fundamentalmente errado*)

let validar_registro reg qtd = 
  if List.length reg < qtd + 1 
    then raise (Failure "Erro, registro não lido: dados insuficientes")
  else 
    if List.length reg > qtd + 1 then raise (Failure "Erro, registro não lido: dados em excesso")
  else 
    try 
    match reg with 
    | [] -> raise (Failure "Registro inválido!")
    | h :: t -> validar_notas t
    with
    | Failure "float_of_string" -> raise (Failure "Erro, registro não lido: erro ao ler número")
;;




let rec receber_notas qtd  = 
  print_string "Digite um novo registro ('nome nota1 nota2') ou 'enter' para encerrar a entrada:";
  let reg = String.split_on_char ' ' (read_line ()) in
  if reg = [""] then [] else 
  begin 
    try 
    validar_registro reg qtd; (reg  @ (receber_notas qtd))
    with
    | Failure msg -> print_endline msg; receber_notas qtd
  end 
;;

let rec ler_notas () =
  try
  print_string "Digite o número de notas por estudante (> 0):";
  let qtd = validar_qtd (read_line ()) in 
  let a = receber_notas qtd in 
  mostrar_medias a qtd 0
  with 
  | ValidarNota msg -> print_endline msg; ler_notas()
  | Failure "int_of_string" -> print_endline "Erro de leitura"; ler_notas()
;;






  