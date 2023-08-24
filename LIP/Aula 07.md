### Tipos Recursivos 
- Definindo o conjunto dos naturais:
```ocaml
type nat = Zero | Suc of nat ;;
(* Entender melhor como funciona variants *)

Suc (Suc (Suc Zero (* Parênteses são obrigatórios já que não tem como saber se é Suc de Suc ...*)

let rec imprimir_nat n = 
match n with
| Zero -> 0 
| Suc m -> 1 + (imprimir_nat m)
;;
```

- Definindo listas:
```ocaml
type lista_int = Vazia | Cons of int * lista_int;;
(* Mais fácil de entender! *)
let rec imprimir_lista_int lista =
match lista with 
| Vazia -> print_endline "[]"
| Cons(cabeca, cauda) -> Printf.printf "%d :: " cabeca; imprimir_lista_int cauda
;;

imprimir_lista_int (Cons (3, Cons (1, Cons (3, Vazia)))) (* Talvez dê erro por causa dos parênteses. Na chamada de construtores os elementos são separados por vírgula. *)
```

- Implementando uma árvore:
```ocaml
 
type tree =
        | Leaf
        | Node of int * tree * tree;;
        
(* Isso acabou sendo um percurso pós-ordem/em-ordem sla *)
let rec imprimir_em_ordem arv = 
        match arv with
        | Leaf -> ()
        | Node(num, esq, dir) -> print_int num; print_endline "" ; imprimir_em_ordem esq; imprimir_em_ordem dir;;
```

#### Função que não é recursiva de cauda:
```ocaml
let rec tamanho lista
match lista with 
| [] -> 0 
| _ :: t -> 1 + (tamanho t);;
;;
(* A chamada recursiva não é a última coisa que fazemos *)
```
#### Função que é recursiva de cauda:
```ocaml
let rec iterar funcao lista =
match lista with
| [] -> ()
| h :: t -> funcao h; (iterar [@tailcall]) funcao t
;;
(* (iterar [@tailcall]) retorna uma mensagem do compilador caso não seja tailcall *)
(* As chamadas anteriores não tem real impacto na chamada posterior *)
```
