(* A) Defina um tipo polimórfico para árvores binárias. 
   Uma árvore ou é vazia ou tem um elemento, uma subárvore esquerda e uma subárvore direita.*)

type 'a arvore = Vazia | Node of 'a * 'a arvore * 'a arvore;;

(* B) Defina uma função que receba uma árvore binária de busca e um elemento,
 e que retorne ("Some" de) a altura do elemento na árvore, ou então "None", se ele não estiver na árvore. A altura das folhas é 1.*)
let a = Node(8, Node(3, Node(1, Vazia, Vazia), Node(6, Node(4, Vazia, Vazia), Node(7, Vazia, Vazia))), Node(10, Vazia, Node(14, Node(13, Vazia, Vazia), Vazia)));;

let altura_arvore arvore = 
  let rec encontrar_altura arvore =
    match arvore with 
    | Vazia -> -1 
    | Node(_, esq, dir) -> let altura_esquerda = 1 + encontrar_altura esq in 
                          let altura_direita = 1 + encontrar_altura dir in 
                          if altura_esquerda > altura_direita then altura_esquerda else altura_direita 
  in encontrar_altura arvore + 1
;;

let altura abb elem = 
  let h = altura_arvore abb in 
  let rec profundidade abb elem cont = 
    match abb with 
    | Vazia -> None 
    | Node(valor, esq, dir) -> if elem = valor then Some (h - cont)  else 
      if elem < valor then 
        profundidade esq elem (cont + 1)
      else
        profundidade dir elem (cont + 1)
  in 
  profundidade abb elem 0
;; 

(* 
A) Defina uma variação da função "fold" que funcione para as árvores binárias definidas na questão anterior.
 Quando aplicada sobre uma árvore vazia, a função deve retornar o elemento base.
 Quando aplicada sobre uma árvore não vazia, o fold deve operar com o elemento
  atual e com o resultado das chamadas recursivas à esquerda e direita.
  Naturalmente, o elemento base e a operação (que recebe 3 argumentos) devem ser recebidos como argumentos pela função "fold",
   assim como a própria árvore.*)

let rec fold_tree arvore op base  = 
  match arvore with 
  | Vazia -> base 
  | Node(valor, esq, dir) -> op valor (fold_tree esq op base) (fold_tree dir op base)
;;

let contar_nos _ b c = 1 + b + c;;

