(* Defina um registro "data" com campos inteiros para dia, mês e ano *)

type data = {
  dia : int;
  mes : int;
  ano : int;
};; 

(* Escreva uma função data_of_string que converte uma string contendo uma data no formato "DD/MM/AAAA 
   para uma data, retornando erros caso não tenha como converter "*)

exception TamanhoInvalido of string;;
exception AusenciaDeBarras of string;;

let data_of_string texto = 
  if String.length texto <> 10 
  then raise (TamanhoInvalido "O tamanho não corresponde ao modelo!")
  else 
    if texto.[2] != '/' || texto.[5] <> '/' then raise (AusenciaDeBarras "Barras ausentes!")
    else
    let conv ini tam = int_of_string (String.sub texto ini tam) in 
    let dia = conv 0 2 in 
    let mes = conv 3 2 in
    let ano = conv 6 4 in
    {dia; mes; ano}
;;

(* Faça o mesmo para printar *) (* Algum erro aqui, verificar fotos e arrumar *)
let programa_data () = 
  try 
    print_string "Digite uma data (DD/MM/AAAA): "; 
    let {dia; mes; ano} = data_of_string (read_line()) in 
    Printf.printf "Data no formato ISO: %04d-%02d-%02d\n" ano mes dia
  with 
  | TamanhoInvalido msg -> Printf.printf "Erro: %s\n" msg
;;