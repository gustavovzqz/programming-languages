Ex_01 sala: Receba uma lista inteiros e imprime os pares
```ocaml
let rec print_pares l1 = 
match l1 with
| [] -> print_endline "Fim da lista!"
| h :: t -> if h mod 2 = 0 then
begin
print_int h;
print_endline "";
print_pares t
end
else
print_pares t;;
```
Ex_02 sala: receba uma lista de inteiros e retorna uma lista com os pares
```ocaml
let rec lista_pares l1 = 
match l1 with
| [] -> []
| h :: t -> if h mod 2 = 0
then
h :: lista_pares t
else
lista_pares t;;
```

Ex_01 (VERSÃO PABLO)
```ocaml
let rec imprimir_pares lista = 
match lista with
| [] -> ()
| cabeca :: cauda -> 
	if cabeca mod 2 = 0 then Printf.printf "%d\n" cabeca; (*Esquece o valor do if. Não precisamos do else por que o tipo de retorno é unit *)
	imprimir_pares cauda;;
	```

Ex_02 (VERSÃO PABLO)
```ocaml
let rec lista_dos_pares lista = 
match lista with
| [] -> []
| cabeca :: cauda ->
	let pares_da_cauda = lista_dos_pares cauda in (* Guarda a variável antes *)
	if cabeca mod 2 = 0
	then cabeca :: pares_da_cauda
	else pares_da_cauda;;
```

Algoritmo de "filtrar" que recebe uma função predicado
```ocaml
let rec filtrar predicado lista
match lista with
| [] -> []
| cabeca :: cauda ->
	let rec_cauda = filtrar predicado cauda in
	if predicado cabeca
	then cabeca :: rec_cauda
	else rec_cauda;;

let elem_iguais (x,y) = (x = y) (* Escrevendo apenas para mostrar a sintaxe de extrair elementos de tuplas *)
```

Já existe isso na biblioteca padrão: List.filter que é o mesmo da de cima. 

Podemos também, em vez de ter que escrever a função anteriormente, escrever na chamada do filter.
```ocaml
filtrar (fun i -> i mod 2 = 0) [1;2;3;4;5;6];;
filtrar (fun (x, y) -> (x = y) [1;2;3;4;5;6];;
(* Também podemos fazer coisas assim *)
let eh_par_2 = fun i -> i mod 2 = 0;;
```

Podemos alterar o primeiro exercício da aula de hoje para receber uma função qualquer:
```ocaml
let rec iterar funcao lista = 
match lista with
| [] -> ()
| h :: t -> funcao h ; iterar funcao t;;

iterar (fun i -> if mod 2 = 0 then Printf.printf "%d\n" i) [1;2;3;4;5;6];;

```

A função acima também já está em um módulo padrão da linguagem.
List.iter ... 

Tarefa 03 - Sala Função que aplica uma função aos elementos da lista e retorna a lista resultado.
```ocaml
let rec aplicar func l1 = 
match l1 with 
| [] -> []
| h :: t -> func h :: (aplicar func t);; 
``` 
A função acima é List.map  
Tarefa 04 -
```ocaml
let separar pred lista = 
match lista with
| [] -> ([], [])
| h :: t -> let (v, f) = separar pred t in (* Revisar esse assunto *)
	if pred h 
	then (h :: v, f)
	else (v, h :: v)
``` 
List.partition ^
Exercícios para Casa da Aula 04:

1. Escreva uma função que receba listas "l1" e "l2" e que então retorne uma lista de pares (tuplas de 2 elementos) "(i1, i2)", em que "i1" seja o i-ésimo elemento de "l1" e "i2" o i-ésimo de "l2". O tamanho da lista retornada deve ser o menor entre os tamanhos de "l1" e "l2", ou seja, de forma que, na saída, só haverá pares enquanto houver elementos (em posições) correspondentes em "l1" e em "l2", por assim dizer. Assim, por exemplo, se l1 = [1; 2; 3; 4] e l2 = ['a'; 'b'; 'c'], então a saída deve ser [(1, 'a'); (2, 'b'); (3, 'c')].
2. Escreva uma função "substituir a b l" que retorne uma variação da lista "l", na qual as ocorrências de "a" sejam substituídas por ocorrências de "b". Exemplo: substituir 2 4 [0; 1; 2; 3; 4; 3; 2; 1; 0; 2; 3; 4; 5] = [0; 1; 4; 3; 4; 3; 4; 1; 0; 4; 3; 4; 5].
3. Usando a função mapear escrita na aula (fotos, comando 27), ou então a função [List.map](https://v2.ocaml.org/api/List.html#VALmap), escreva uma definição alternativa para a função "substituir" do item anterior. Nesse caso, a função "substituir" não deve ser (ela mesma) recursiva (embora a função "mapear" o seja).
---
SOL:
```ocaml
(* Ex 01*)

let rec associar l1 l2 =

match l1 with

| [] -> []

| h :: t ->

match l2 with

| [] -> []

| j :: k ->

(h, j) :: associar t k

;;

  

(* Ex 02*)

let rec substituir a b l =

match l with

| [] -> []

| h :: t -> if h = a then b :: substituir a b t else h :: substituir a b t

;;

  

(* Ex 03 *)

  

let rec mapear func l1 =

match l1 with

| [] -> []

| h :: t -> func h :: (mapear func t);;

  

let substituir_2 a b l =

mapear (fun i -> if i = a then b else i) l

;;
```