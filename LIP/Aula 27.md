Quando threads estão trabalhando em um espaço compartilhado de memória, podemos ter problemas de `race condition`, onde o acesso concorrente ao mesmo espaço pode resultar em algo não esperado. Para solucionar esse tipo de problema, existem mecanismos de sincronização.

- Solução 1:  Usando variável atômica

```ocaml
let () = 
	 let cont = Atomic.make 0 in 
	 let n = read_int () in 
	 let tt = Domain.recommended_domain_count () in 
	 let v = Array.init tt 
		 (fun _ -> Domain.spawn
					 ( fun _ -> 
						for i = 0 to n do 
						Atomic.incr cont (* Atômico para não ter problema *)
						done
					)) in 
	for i = 0 to Array.length v - 1 do (* Espera as threads terminarem *)
		Domain.join v.(i)
	done;;
```

- Solução 2: Usando `Mutex` 
```ocaml 
let () =
	let trava = Mutex.create() in 
	let cont = ref 0 in 
	let n = read_int () in 
	let tt = Domain.recommended_domain_count () in 
		let v = Array.init tt
				(fun _ -> Domain.spawn (
							fun _ -> 
								for i = 0 to n do 
									Mutex.lock trava;
									cont := !cont + 1;
									Mutex.unlock trava
									done 
									)) in 
	for i = 0 to Array.length v - 1 do (* Espera as threads terminarem *)
		Domain.join v.(i)
	done;;
```

Outro ponto importante é a da *comunicação* entre threads. Podemos fazer isso usando canais.

```ocaml
module Chan = Domainslib.Chan;;

let () = 
	let canal: string Chan.t = Chan.make_unbounded () in 
	let t1 = Domain.spawn
				(fun _ -> print_endline "t1 executando";
						  prtint_string "Mensagem: ";
						  Chan.send canal (read_line ())) in 
	let t2 = Domain.spawn (fun _ -> print_endline "t2 exec.";
									Chan.recv canal) in 
	Domain.join t1;
	let msg = Domain.join t2 in 
	Printf.printf "A execução de t2 retornou: %s\n" msg
;;
```