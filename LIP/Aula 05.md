Ex 01 Sala: Função que retorna a soma de inteiros de uma lista:
```ocaml
let rec somar l1 a = 
match l1 with
| [] -> a
| h :: t -> somar t (a + h);;

(* Poderiamos só ter feito assim: *)
let rec somar l1 = 
match l1 with
| [] -> 0
| h :: t -> h + somar t;;

```
Ex 02. Lista de strings e retorna a concatenação das strings da lista.
```ocaml
let rec concatenar l1 a = 
match l1 with
| [] -> a
| h :: t ->  concatenar t (a ^ h);;

(* Também poderia ser feito assim *)
let rec concatenar l1 concatenar = 
match l1 with
| [] -> ""
| h :: t ->  cabeca ^ (concate
```

Agora, podemos pensar na generalização das funções acima
```ocaml 
let rec fold op base lista = 
match lista with
| [] -> base
| h :: t -> op h (fold op base t)
;;
```

A função acima é a List.fold_right (já que as operações são aplicadas dois a dois da direita para a esquerda)
Ex: 03
Implementando o fold left:
```ocaml
let rec fold op base lista aux  = 
match lista with
| [] -> aux
| h :: t -> fold op base t (op h aux);;

let fold_left op base lista = fold op base lista base;;

(* Podemos perceber que temos algumas coisas desnecessárias na lista acima *)
let rec fold op lista base  = 
match lista with
| [] -> base
| h :: t -> fold op t (op h base);;


```


Contando os elementos de uma lista usando uma função de alta ordem.
Ex 04: Defina uma função que receba uma lista e que retorna o número de elementos dela usando fold_left.

Há algum erro no fold_left 
```ocaml
fold_left (fun cont_primeiros _ -> cont_primeiros + 1) 0 [1;2;3;4;5];;
(* Está resultando o número 6*)
``` 

Revisar os comandos a partir de 24 a 31. 

Exercícios para casa
1. Escreva em OCaml uma função que receba uma lista e que retorne uma versão ordenada (em ordem crescente) da lista recebida. (Neste exercício, você não deve se preocupar em implementar um algoritmo que execute em tempo O(n*lg n); realizar a ordenação corretamente é suficiente.)
2. Escreva em OCaml um programa que permita ao usuário editar um cadastro de nomes e idades. O cadastro começa vazio e o programa deve, repetidamente, permitir ao usuário fazer uma operação, que pode ser de (1) inserção (digitar um nome e uma idade e inserir no cadastro; o programa deve garantir que nunca haverá nomes repetidos no cadastro), (2) consulta geral (imprimir todo o cadastro na tela), (3) consulta específica (informar a idade a partir do nome digitado), (4) remoção (a partir do nome) e (5) sair do programa.
Solução no arquivo da disciplina.