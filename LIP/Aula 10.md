### Leitura de Arquivos
	 Conteúdo da aula está nos arquivos na pasta aula10

Exibindo as funções básicas  para ler  em arquivos:
```ocaml
let rec ler_e_escrever arquivo = 
	try 
		let linha = input_line arquivo in (* Input line retorna a linha *)
		print_endline linha;
		ler_e_escrever arquivo
	with 
	| End_of_file -> ()

let programa() = 
	try 
		print_string "Digite o nome do arquivo: ";
		let arquivo = open_in (read_line()) in (*Abre para leitura*)
		print_endline "Conteúdo do arquivo:";
		print_endline "--------------------";
		ler_e_escrever arquivo;
		print_endline "--------------------";
		close_in arquivo (* Fecha *)
	with 
	| Sys_error msg -> Printf.print "Erro: %s\n" msg
;;
```

- Operações básicas de escrita:
```ocaml
let rec ler_e_escrever arquivo =
	let linha = read_line () in
		if linha = "" then ()
		else
		begin
			output_string arquivo (linha ^ "\n");
			ler_e_escrever arquivo
		end
;;
  
let programa () =
	print_string "Nome do arquivo a ser gravado: ";
	let arquivo = open_out (read_line ()) in
	print_endline "Digite o texto, encerrando com linha vazia: ";
	ler_e_escrever arquivo;
	close_out arquivo
	;;
programa ();;
```

- Podemos escrever inteiros, bools ... usando a função fprintf do módulo printf.
```ocaml 
let arquivo = open_out "teste.txt" in 
Printf.fprintf arquivo "%d %g %c %s %B\n" 3 3.14 '!' "uma string" true;
close_out arquivo;;
```

