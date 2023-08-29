### Polimorfismo Paramétrico
- Os tipos são parâmetros 
```ocaml
let id x = x;;
-:val id : 'a -> 'a = <fun> (* Tipo genérico! *)
``` 
- Podemos explicitar os tipos genéricos na declaração da função
```ocaml
(* EX_1 *)
let id_tipos_expl (x : 't) : 't = x;;
-: val id_tipos_expl : 't -> 't = <fun>

(* EX_2 *)
let rec mapear (funcao: 't -> 'u) (lista: 't list) : 'u list  =
    match lista with
    | [] -> []
    | cabeca :: cauda -> (funcao cabeca) :: (mapear funcao cauda)
-: val mapear : ('t -> 'u) -> 't list -> 'u list = <fun>

(* EX_3*)
let rec fold_right (op: 't -> 'u -> 'u) (base: 'u ) (lista : 't list) : 'u =
	match lista with 
	| [] -> base 
	| h :: t -> op h (fold_right op base t)
;;

```


Escreva uma função que recebe duas listas e retorna uma lista de pares (tuplas) com elementos de mesma posição junto nos pares. 
```ocaml
let rec zip (l1 : 'a list) (l2 : 'b list) : ('a * 'b) list = 
match l1 with 
| [] -> []
| h :: t -> begin match l2 with 
            | [] -> []
            | j :: l -> (h, j) :: zip t l 
            end
;;
-: val zip : 'a list -> 'b list -> ('a * 'b) list = <fun>
```

Há outros casos em que o match é usado aninhado, por isso, há um açúcar sintático para simplificar o problema.

```ocaml 
let rec zip2 (l1 : 'a list) (l2 : 'b list) : ('a * 'b) list = 
match l1, l2 with 
| h1 :: t1, h2 :: t2 -> (h1, h2) :: zip2 t1 t2
| _ -> []
;;
```

#### Polimorfismo Paramétrico para Tipos 
```ocaml
type natural_ou_erro = Erro | Nat of int;;
(* Definindo como genérico *)
type 't talvez =  Nada | Valor of 't;; 

let ler_nat msg = 
	print_string msg; 
	let n = read_int () in 
		if n < 0 then Nada 
		else Valor(n);;
```

O que construímos em cima é equivalente ao tipo option
```ocaml
let ler_nat_opt msg = 
	print_string msg;
	let n = read_int () in 
	if n < 0 
	then None
	else Some n;;
```
