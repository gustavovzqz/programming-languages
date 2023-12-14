### Continuação da aula passada
- Definindo o tipo "valor ou erro"
```ocaml
type ('v, 'e) valor_ou_erro = Valor of 'v | Erro of 'e;;

let ler_nat msg = 
   print_string msg;
   let i = read_int () in 
   if i < 0 
   then Erro "Negativo digitado!"
   else Valor i
;;

let testar () = 
    match ler_nat "Digite um natural :" with 
    | Valor n -> Printf.printf "Você digitou %d\n" n
    | Erro msg -> Printf.printf "Erro: %s\n" msg
;;
```

- O tipo acima já existe na biblioteca padrão. Podemos refazer o código usando o tipo result.
```ocaml
let ler_nat msg = 
   print_string msg;
   let i = read_int () in 
   if i < 0 
   then Error "Negativo digitado!" (* Error e Ok são os construtores! *)
   else Ok i
;;
```


- Defina um tipo polimórfico para representar um par ordenado cujos elementos podem ter tipos diferentes.
```ocaml
type ('a, 'b) par = Par of ('a * 'b);;

let iguais (Par(a,b): (int, float) par) : bool  = 
float_of_int a = b;;
```

### Tratamento de Erros
- Começando de uma forma básica
```ocaml
let posicao lista elem = 
	let rec pos indice_atual lista_restante = 
		match lista_restante with
		| [] -> -1 (* Retornamos -1 como mensagem de erro 'padronizada' c*)
		| h :: t -> if h = elem 
		            then indice_atual
		            else pos (indice_atual + 1) t
	in 
	pos 0 lista
;;
```
- Nem sempre conseguimos retornar um erro acima. Na função abaixo, precisamos usar o option.
```ocaml
let rec valor_da_chave (dicio: ('c * 'v) list) (chave : 'c) : 'v option = 
	match dicio with
	| []          -> None 
	| (c, v) :: t -> if c = chave then Some v 
	                              else valor_da_chave t chave
;;
```

- Podemos explicitar os erros de uma melhor forma 
TODO: Colocar o exemplo da aula aqui




- Mais um exemplo com o ler_nat que exibe uma mensagem de erro.
```ocaml
exception ErroMsg of string;;
let ler_nat msg = 
	print_string msg;
	let i = read_int () in 
	if i < 0 
	then raise (ErroMsg "Negativo Digitado! ")
	else i 
;;
```

- Agora,  
```ocaml
exception IntInvalido of string * int;;
let ler_nat msg = 
	print_string msg;
	let i = read_int () in 
	if i < 0 
	then raise (IntInvalido("Negativo Digitado!", i))
	else i 
;;

let testar_ler_nat () = 
	try 
		let n = ler_nat "Digite um natural: " in 
		Printf.printf "Você digitou %d\n" n
		with 
		| IntInvalido(msg, i) -> Printf.printf "Erro: %s (%d)\n" msg i
;;
```

- Há uma versão do read_int que não retorna uma exceção, mas sim, um option.  O mesmo para int_of_string_opt

```ocaml
red_int_opt ();; 
int_of_string_opt ();;
```

#### Importante:
- Uma função sempre pode retornar um erro, independente do tipo que ela normalmente retorna. Porém, se estivermos dentro de um bloco try - with, o valor retornado no with precisa ser o mesmo no caso em que a função não possui erro.

### Sobre a Tarefa para casa:
- A minha solução está fundamentalmente errada. Não tem pra que fazer "teste se é possível converter, se for, então converta" quando podemos tratar diretamente a conversão. Se der erro, retorna o erro, se não der, tudo bem! O que fizemos é Se não der erro, então faça novamente (???), se der erro, retorna o erro.
 