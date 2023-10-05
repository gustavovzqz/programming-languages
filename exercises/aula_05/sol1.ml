(* Algoritmo de ordenação de uma lista *)
(* Ideia mais básica: itera a lista toda, remove o maior elemento e adiciona a uma nova lista,
   repete até que a lista esteja vazia *)

let rec maior_da_lista l1 maior = 
  match l1 with
  | [] -> maior 
  | h :: t -> if h > maior then maior_da_lista t h else maior_da_lista t maior
;;


let rec remover_elemento l1 elemento = 
  match l1 with 
  | [] -> []
  | h :: t -> if h = elemento then t else h :: remover_elemento t elemento 
;; 

(* Agora que já temos uma função que retorna o maior, precisamos de uma que retire o maior e adicione em uma 
   outra lista auxiliar *)

let rec ordenar l1 aux = 
  match l1 with
  | [] -> aux 
  | h :: t -> let maior = maior_da_lista l1 h in 
    ordenar (remover_elemento l1 maior) (maior :: aux)
;;

(* Exercício 2 : *)