1. [Definições locais de variáveis via let ... in](https://v2.ocaml.org/manual/expr.html#sss:expr-localdef).
2. [Definição de funções não-recursivas, recursivas e mutuamente recursivas](https://v2.ocaml.org/manual/expr.html#sss:expr-localdef).
3. [Efeitos colaterais](https://en.wikipedia.org/wiki/Side_effect_(computer_science)), funções de [entrada](https://v2.ocaml.org/api/Stdlib.html#2_Inputfunctionsonstandardinput) e [saída](https://v2.ocaml.org/api/Stdlib.html#2_Outputfunctionsonstandardoutput), [operador de sequência](https://v2.ocaml.org/manual/expr.html#sss:expr-sequence).
4. Exemplos e tarefas em sala.
```ocaml
let rec par i = 
	if i = 0 
	then true
	else  impar (i - 1)
	and impar =
	if i = 0 
	then false
	else par (i - 1);;
```



fazer: função que diz se um número  é multiplo de outro (eh multiplo ij)

vimos:função print_string, print_endline, print_int ...

Pra usar o printf precisamos usar o modulo do printf, daí a sintaxe:
Printf.printf "O dobro de %d é %d\n" a b;;

let i = read_int () in Printf.printf "O dobro de %d é %d\n" i (2*i);;
4
O dobro de 4 é 8

O mesmo para read_float, read_line...

; significa "avalie duas expressões, a da esquerda do ponto e virgula e a da direita do ponto e virgula. Ignore o valor da anterior e o valor da expressão unificada será o valor da última"

Isso pode ser útil já que a primeira função, mesmo que não usemos o valor dela, pode alterar o **estado** do programa.

print_string "Digite um inteiro: ";
let i = read_int () in 
Printf.printf "O dobro de %d é %d\n" i (2*i);;

- Podemos perceber que se usarmos o texto acima no utop, o retorno da função é unit (). É importante que saibamos que o tipo unit foi retornado pelo read_int() e não pelo print_string. Isso acontece pois o ; faz com que esqueçamos o que valor do que foi digitado anteriormente (como visto acima)

Definindo uma função que usa isso:

let ler_int msg = 
print_string msg;
read_int ();;

Printf.printf "vc digitou %d\n" (ler_int "Digite um inteiro: ");;


exercicios
3. Escrevam um código OCaml que leia 3 inteiros e imprima o maior deles.
print_string "Digite três inteiros: ";
let maior a b c = if ((a > b) && (a > c)) then a else 
if ((b > a) &&  (b > c)) then b
else c in 
let a = read_int() in 
let b = read_int() in
let c = read_int() in
print_int (maior a b c);;

4. let rec ate_positivo () =
let a = read_int () in 
(if a > 0 then true else ate_positivo () );;

5. Escreva um código OCaml que comece lendo um inteiro positivo "n". Em seguida, o código deve ler "n" inteiros e finalmente deve imprimir o maior dos "n" inteiros lidos.

let rec impr maior num =
if num = 0 then maior else
let n = read_int() in
if n > maior then impr  n (num - 1) else impr maior (num - 1);; 

código:
let n = read_int () in 
impr 0 n;;

tudo junto:
let rec impr maior num =
if num = 0 then maior else
let n = read_int() in
if n > maior then impr  n (num - 1) else impr maior (num - 1) in
let n = read_int () in 
impr 0 n;;

5 - (Escreva um código OCaml que) leia "n" números e imprima a média deles, devendo o valor de "n" ser lido inicialmente pelo programa (assim como no exercício anterior).
print_string "Insira um número inteiro: ";
let n = read_float () in
let rec media i soma =
if i = 0. then (soma /. n)
else 
let a = read_float () in media (i -. 1.) (soma +. a)
in 
media n 0.;;

dúvida no exercício de cima: como imprimir a mensagem "insira um numero inteiro" durante a recursão? passar a função como argumento?

Da maneira abaixo é possível:
let n = read_float () in
let rec media i soma =
if i = 0. then (soma /. n)
else
let buf = print_string "Insira um número: " in
let a = read_float() in media (i -. 1.) (soma +. a)
in 
media n 0.;;

VERSÃO DO PABLO:
l
```ocaml
let rec ler_int_positivo () =

print_string "Digite um inteiro positivo: ";

let n = read_int () in

if n > 0 then n

else ler_int_positivo ();;

  

let rec ler_e_somar n =

if n = 1

then

begin

print_string "Digite um inteiro: ";

read_int ()

end

else

begin (* Begin e end tem função de parenteses *)

let soma_primeiros = ler_e_somar (n-1) in

print_string "Digite mais um inteiro: ";

let outro = read_int () in

soma_primeiros + outro

end;;

  

let n = ler_int_positivo () in

let soma = ler_e_somar n in

Printf.printf "A média dos %d números é %g\n" n (float_of_int soma /. float_of_int n);;
``` 

