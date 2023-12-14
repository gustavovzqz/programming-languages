1. Escreva um programa em OCaml que leia inteiros do usuário e ao final imprima a média desses inteiros. A leitura dos números deve parar quando o usuário digitar o primeiro número negativo; neste momento o programa deve imprimir na tela a média dos inteiros digitados anteriormente.
1. Em OCaml, o operador "@" concatena 2 listas, de forma que, por exemplo "[1; 2] @ [3; 4; 5] = [1; 2; 3; 4; 5]" e "[1] @ [ ] = [1]". Entretanto, é fácil definir uma função que faz esta tarefa: para verificar esse fato, escreva uma função que receba duas listas e que então retorne a concatenação dessas listas, sem usar "@" (use "match" e "::"). (Não tente modificar as listas recebidas: elas são constantes; você deve construir uma nova lista, que seja igual à concatenação das listas recebidas.) Você pode pensar que se trata de listas de inteiros.
2. Escreva uma função "inverter l" que retorne o inverso da lista "l", de forma que, por exemplo, "inverter [1; 2; 3] = [3; 2; 1]".
3. Observando que tuplas podem ser elementos de listas, escreva um programa que inicialmente leia do usuário uma sucessão de nomes e idades (nome 1, idade 1, nome 2, idade 2, etc, cada nome numa linha própria e idem para as idades); o fim da entrada será detectado quando, como nome, for digitada uma linha vazia (use [read_line](https://v2.ocaml.org/api/Stdlib.html#VALread_line) para ler os nomes). Em seguida, o programa deve entrar numa repetição de consultas, em que o usuário digita uma idade e o programa imprime os nomes das pessoas que possuem aquela idade, conforme os dados lidos inicialmente. O programa deve terminar quando, em alguma consulta, for digitada uma idade negativa.


```ocaml
(* sol 1*)
let conc l1 l2 = 
match l1 with
|[] -> l2
|h :: t -> h :: conc t l2;;
(* sol 2*)
let inv list = 
let rec inverter rev l1 = 
match l1 with
| [] -> acumulada
| h :: t -> inverter (h :: acumulada) t 
in inverter [] list;;
```

Como eu poderia para fazer isso funcionar? 
```ocaml
let rec printar_nomes data num =

match data num with

| [] -> print_endline "Fim dos dados!"

| (a, num) :: t -> (* O num de dentro seria o mesmo do passado como argumento, algo como (a, 13 *)

begin

print_endline a; printar_numeros t num

end

;;
fprintf``` 

Dúvida: 
Vamos supor que temos que:
```ocaml 
let a = ("Carlos", 12)
```
A expressão abaixo retorna o segundo caso:
```ocaml
match a with 
| (var, 11) -> "Primeiro caso"
| (var, 12) -> "Segundo caso"
| _ -> "Terceiro caso"
```
Agora, suponha que queiramos fazer com um número que eu recebo por argumento.
```ocaml
let b = 11 in 
match a with 
| (var, b) -> "Primeiro caso"
| (var, 12) -> "Segundo caso"
| _ -> "Terceiro caso"
```
No caso acima, o programa não funciona da maneira que eu esperava. Dentro do match o valor do B não é interpretado e sim funciona de uma maneira como "Alguma tupla que pode ser correspondida por duas variáveis quaisquer"

Temos o comando when -> Pesquisar mais sobre ele.
