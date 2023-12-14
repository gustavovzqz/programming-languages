### Continuando Módulos

#### Interfaces:

```ocaml

module type InterfacePilha = 
sig 
    type 'a pilha (* Em OCaml, usamos t como padrão para o tipo *)
    val criar: 'a -> 'a pilha
    val empilhar: 'a pilha -> 'a -> unit 
    val consultar_topo: 'a pilha -> 'a 
    val desempilhar: 'a pilha -> 'a 
    val vazia: 'a pilha -> bool
end



module Pilha : InterfacePilha = 
struct 
...
end
```

### Fazendo uma fila (de uma forma inteligente)
```ocaml
module type Fila = 
sig 

type 'a fila
val criar : 'a -> 'a fila 
val enfilar : 'a fila -> 'a -> unit 
val desenfilar : 'a fila -> 'a 
val vazia : 'a fila -> bool 
val primeiro : 'a fila -> 'a
val teste : int




module Fila : FilaInterface 
struct 

type 'a fila = {mutable entrada: 'a list; 
				mutable saida:   'a list}

let criar (_ : 'a ) : 'a fila = 
	{entrada = []; saida = []}

let vazia (f : 'a fila) : bool = 
	f.entrada = [] && f.saida = []

let enfilar (f : 'a fila) (elem : 'a ) : unit = 
	f.entrada <- elem :: f.entrada

let consultar (f : 'a fila) : 'a = 
	match f.saida with 
	| [] -> f.saida <- List.rev (f.entrada); 
					   f.entrada <- []  
					   begin 
						   match f.saida with 
						   | h :: _ -> h 
						   | [] -> failwith "consultar: fila vazia"
					   end 
	| h :: _ -> h 

let desenfilar (f : 'a list ) : 'a = 
	match f.saida with 
	| h :: t -> f.saida <- t; h 
	| [] -> f.saida <- List.rev (f.entrada); 
			f.entrada <- [];
			match f.saida with
			| h :: t -> f.saida <- t; h 
			| [] -> failwith "FIla.desenfilar: fila vazia"


end;; 
```

### Um módulo pode receber outro como argumento
- São os funtores!

```ocaml
module type Data
sig

type t (* Seguindo a tradição de OCaml *)

val dia : t -> int

val mes : t -> int 

val ano : t -> ano 

end ;;

module DataTupla : Data = 
struct 

type t = int * int * int 

let dia ( (d, _, _ ) : t ) : int = 
	d
	
let mes ( (_, m, _ ) : t ) : int = 
	m
	
let ano ( (_, _, a) : t ) : int = 
	a

end;;


module DataReg : Data = 
struct 

type t = {dia : int; mes : int; ano : int} 
let dia (d:t) = 
	d.dia 

let mes (d : t )
	d.mes

let ano (d : t) 
	d.ano

end;;

module type ManipData = 
sig 

type t 

val anterior : t -> t -> bool

end;;

module Manip (D: Data) : ManipDatas with type t := D.t
struct 

type t = D.t

let anterior (a : t) (b : t) : bool = 
	D.ano < D.ano b || 
	(D.ano a = D.ano b &&
	(D.mes a < D.mes b || 
	(D.mes a = D.mes b && D.dia a < D.dia b)))
end ;;

module ManipTuplas = Manip (DataTupla);;

let () = 
	let hoje = DataTupla.criar 09 10 2023 in 
	let ontem = DataTupla.criar 08 10 2023 in 
	Printf.printf "%B\n" (ManipTuplas.anteior ontem hoje)
;;

	



