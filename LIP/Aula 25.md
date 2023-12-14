### Programação Usando Threads
- Segue um exemplo de um simples programa que usa threads:

```ocaml
let imprimir caracteres qtd = 
	for i = 1 to qtd do 
		print_char caractere
	done;
	print_char '\n'
;;

let programa () = 
	print_string "Quantidade de caracteres: ";
	let n = read_int () in 
	let t1 = Domain.spawn (fun _ -> imprimir '/' qtd) in 
	let t2 = Domain.spawn (fun _ -> imprimir '.' qtd) in 
	Domain.join t1;
	Domain.join t2
;;
```

Podemos perceber duas coisas: 
- Domain.spawn recebe uma função a ser executada. Mas, como a função é "valorada" quando o programa lê o argumento, passamos uma versão que recebe () e retorna a função que queremos.
- Domain.join "thread" aguarda a thread retornar o valor.

