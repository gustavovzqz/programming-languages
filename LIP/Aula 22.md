- Nesse ponto, onde temos um pouco de *mutabilidade*, podemos precisar de uma coisa parecida com um laço `while`.

```ocaml
type par = { mutable x : int; mutable y : int};;

let p = { x = -1; y = -1} in 
	let rec ler() = 
	print_string "x: ";
	p.x <- read_int()
	print_string "y: "
	p.y <- read_int()
	if p.x < 0 || p.y < 0 
	then ler() 
	else ()
in 
ler();
Printf.printf "O par digitado foi (%d,%d)\n" p.x p.y

;;
```

#### Introduzindo o While
```ocaml
let p = { x = -1; y = -1} in 
while (p.x < 0 || p.y < 0) do 
	print_string "x: ";
	p.x <- read_int();
	print_string "y: ";
	p.y <- read_int()
done;
PrintPrintf.printf "O par digitado foi (%d,%d)\n" p.x p.yf.printf "O par digitado foi (%d,%d)\n" p.x p.y
```

### Simulando Variáveis Mutáveis
```ocaml
type 't apontandor = { mutable valor : 't; };;
let i = { valor = 0 } in 
while i.valor < 10 do 
	Printf.printf "%d\n" i.valor;
	i.valor <- i.valor + 1
done ;;
``` 

### Função Atribuir
```ocaml
let atribuir var novo_valor = 
	var.valor <- novo_valor
;;
```

E agora, transformando em um operador:

```ocaml 
let (:=) var novo_valor = 
	var.valor <- novo_valor
;;

let i = {valor = 0} in 
	Printf.printf "%d\n" i.valor; 
	i := 1;
	Printf.printf "%d\n" i.valor 
;;
``` 

Isso que acabamos de fazer (variáveis mutáveis como um registro unário) já existe em OCaml, é o tipo reference.
```ocaml
let i = ref 0 in (* A função ref cria uma "variável" mutável de tipo ref *)
while i.contents < 10 do 
	Printf.printf "%d\n" !i; (* !i é o mesmo que i.contents *)
	i := !i + 1 (* O operador := realmente existe! *)
done;;
``` 

1. Temos um tipo "ref" análogo ao "apontador" e o campo se chama "contents".
2. Podemos criar uma "refêrencia" através da função "ref".
3. Podemos atribuir a uma referência através de um operador ":=".
4. Podemos acessar o vlor dentro da referẽncia pelo operador "!".

### Comparações Físicas e Lógicas
- Frequentemente nós usamos o `=`  e `<>` , mas também podemos usar `==` e `!=` 
O ponto é que `==` compara fisicamente e `=` lógicamente. (o mesmo para o outro simbolo)
```ocaml 
let v = [|1; 2|];;
let w = [|1;2|];;
v = w;;
-: bool = true 
v == w;;
-: bool = false
``` 

1. Para comparar valores imutáveis, usar "=" e "<>";
2. No caso de tipos mutáveis, 
	- Para saber se se trata do mesmo objeto na memória, usar `==` e `!=`
