(* Receber nomes -> imprimir os nomes que começam com vogais *)

let rec receber_nomes () = 
  print_endline "Insira um nome ou vazio pra sair";
  let nome = read_line () in 
  if nome = "" then [] else nome :: receber_nomes ();;

let rec printar_vogais lista = 
  match lista with
  | [] -> ()
  | h :: t -> let primeira_letra = h.[0] in 
  match primeira_letra with 
  | 'A' | 'E' | 'I' | 'O' | 'U' -> print_endline h; printar_vogais t 
  | _ -> printar_vogais t 
;;

let programa_1 () = 
  let l = receber_nomes () in 
  printar_vogais l
;;

(* Função que recebe um predicado e aplica a elementos de tuplas
   retorna uma lista dos elementos das tuplas que são verdade para o pred*)

let rec filtrar pred lista = 
  match lista with 
  | [] -> [] 
  | (a, b) :: t -> if (pred a && pred b) then a :: (b :: filtrar pred t)
  else if pred a then a :: filtrar pred t else if pred b then b :: filtrar pred t 
  else filtrar pred t;;

(* Fazendo de uma maneira mais inteligente *)
let rec filtrar2 pred lista = 
  match lista with 
  | [] -> [] 
  | (prim, seg) :: t -> let res_cauda = filtrar2 pred t in 
  let res_seg = if pred seg then seg :: res_cauda else res_cauda in 
  if pred prim then prim :: res_seg else res_seg
;;