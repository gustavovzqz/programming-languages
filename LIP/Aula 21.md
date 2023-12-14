### Laços FOR em OCaml

```ocaml
for i = 1 to 3 do 
	Printf.printf "Não é necessário usar função para repetir %d vezes\n " i
done;;

for i = 3 downto 1 do 
	Printf.printf "Não é necessário usar função para repetir %d vezes\n " i
done;;
```

### Vetores
- Estrutura mutável 
```ocaml
[| 1; 2; 3; 4; 5 |];;
- : int array [|1; 2; 3; 4; 5|]
(* Podemos acessar as posições dos vetores *)
let a = [| 1; 2; 3; 4; 5 |];;
a.(1);; (* 2 *)
a.(1) <- 3;; (* Mudamos o que estava lá *)
Array.length a;; (* Tamanho do vetor *)
```

```ocaml
print_string "Digite o tamanho do vetor: ";
let n = read_int () in 
let v = Array.make n 0 in (* Cria um vetor de tamanho n começando com 0*)
for i = 0 to Array.length v - 1 do 
Printf.printf "Digite v[%d]: " i; 
v.(i) <- read_int()
done; 
for i = 0 to Array.length v - 1 do 
Printf.printf "v[%d] = %d\n" i v.(i)
done;; 
Digite o tamanho do vetor: 4 
Digite v[0]: 1
Digite v[1]: 2
Digite v[2]: 3
Digite v[3]: 4
v[0] = 1
v[1] = 2
v[2] = 3
v[3] = 4
- : unit = ()
```

- Também podemos usar o Array.init 
```ocaml
let v = Array.init 5 (fun i -> i * i) in 
Array.iter (fun elem -> Printf.printf "%d\n" elem) v;; (* Percorre aplicando uma função *)

(* Também podemos passear pelos índices (em vez de pelos elementos ) *)
Array.iteri (fun ind elem -> Printf.printf "%d -> %d\n" ind elem) v;;
``
``` 
- A atribuição tem tipo unit.
```ocaml
let v = [|0; 1; 2|] in v.(0) <- 10;;
-: unit = ()
```

- Gerando uma permutação aleatória de 1 a n.
```ocaml
let permutacao_aleatoria n = 
	let v = Array.init n (fun i -> i + 1) in 
	for ultimo = n - 1 downto 1 do 
	    let i = Random.int (ultimo + 1) in 
	    let cp_i = v.(i) in 
	    v.(i) <- v.(ultimo); 
	    v.(ultimo) <- cp_i
	done;
	v
;;
```

### Registros Mutáveis
```ocaml
type meu_registro = { matricula: int; mutable semestre: int };
let teste = {matricula = 500100; semestre = 1 };;
teste.semestre;; (* 1 *)
teste.semestre <- 8;; 
teste.semestre;; (* 8 *)
