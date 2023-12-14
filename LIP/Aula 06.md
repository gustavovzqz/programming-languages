#### Registros:
São como um produto cartesiano. (Temos um valor e outro)
```ocaml 
type registro = {nome : string; matricula : int;};;
let pablo = {nome = "Pablo"; matricula = 2554198}
pablo.nome;; (* acessa o campo nome *)
```

Exercicio 1 para sala: definir data tipo ano e ler uma linha dia/mes/ano que retorna um registro do tipo data:
```ocaml
type data = {
dia : int;
mes : int;
ano : int;
};;

let ler_data () = 
print_endline "Insira uma data no formato dd/mm/aaaa";
let a = read_line () in 
let dia = String.sub a 0 2 in
let mes = String.sub a 3 2 in
let ano= String.sub a 6 4 in
{dia = int_of_string dia; mes = int_of_string mes; ano = int_of_string ano}
(* No caso acima, que os campos são iguais as variáveis, podemos escrever só o nome do campo *)
(*{dia, mes, ano}*)
val ler_data : unit -> data = <fun> ```
Escrevendo de uma forma diferente usando clousure:
```ocaml
let ler_data_2 mensagem = 
	print_string mensagem;
	let linha = read_line () in 
	let conv ini tam = 
		int_of_string (String.sub linha ini tam)
in
{dia = conv 0 2; mes = conv 3 2; ano = conv 6 4};;
```

```ocaml
let hoje = {dia = 21; mes = 8; ano = 2023}
let amanha = {dia = hoje.dia + 1 ... }

(*Isso acima não é conveniente! Podemos usar with*)

let ontem = {hoje with dia = hoje.dia - 1} 
(*O resto não muda, só muda o que explicitarmos *)
let daqui_1_mes_dia = {hoje with dia = hoje.dia + 1; mes = hoje.mes+1};;
```

#### Variants
São como um tipo união. (Temos um valor ou outro)

```ocaml
type tipo_usuario = Estudante | Docente | TecADM ;; (* enumerável *)
let preco_ru usuario = 
match usuario with
| Estudante -> 1.10
| Docente -> 13.5
| TecADM -> 13.5;;
```

```ocaml
type nat_ou_erro = Nat of int | Erro ;; 
let ler_nat mensagem = 
print_string mensagem;
let n = read_int () in 
if n < 0 then Erro else Nat n;;

let hoje = ler_nat "Digite o dia de hoje: " in 
match hoje with
| Erro -> print_endline "Erro na leitura do natural"
| Nat n -> Print.printf "O natural digitado foi %d\n" n;;
```

Tarefa 2:
Defina um tipo registro dia_mes; registro dia_mes ou erro e uma função que leia e retorne um dia e o erro especifico "mes invalido" "dia invalido para o mes ... " dia invalido, mes invalido, dia invalido para o mes
```ocaml
type dia_mes = {dia : int; mes : int};;
type dia_mes_ou_msg_erro = DM of dia_mes | MsgErro of string;;

let ler_dia_mes mensagem = 
print_string mensagem;
let linha = read_line () in 
let conv ini tam = int_of_string (String.sub linha ini tam) in
let mes = conv 3 2 in 
if mes < 1 || mes > 12 
then MsgErro "Mês Inválido!"
else 
let dia = conv 0 2 in 
if dia < 1 || dia > 31 
then MsgErro "Dia inválido!"
else 
if (dia > 29 && mes = 2) || (dia = 31 && match mes with
| 4 | 6 | 9 | 11 -> true 
| _  -> false
)
then MsgErro "Dia inválido para o mês!"
else DM {dia; mes};;
```

Construtores de dois argumentos:
```ocaml

type par_int = Par of int * int;;

let hoje = Par(21, 08);;
match hoje with 
| Par(i, j) -> Printf.printf "hoje: %d/%d\n" i j;; 

(* Desconstruindo variantes com um construtor *)
let Par(i, j) = hoje in 
Prtinf.printf "Hoje : %d\%d\n" i j;;

type par_int_tupla = ParTupla of (int * int);;
let amanha = (22, 08) in 
let valor_par_tupla = ParTupla amanha in 
let ParTupla((i,j)) = valor_par_tupla in
Print.printf "Amanhã %d/%d\n" i j;;
```
