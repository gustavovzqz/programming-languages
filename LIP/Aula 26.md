	Em paralelo a ultima aula, podemos criar um Pool de threads.

```ocaml
module Task = Domainslib.Task ;; (* Definindo o submodulo *)

let fib_par pool lim_inf_paralelo n = 
	let rec fib n = 
	if n < 2 || n <= lim_inf_paralelo  (*Limite inferior para rodar sequencial*)
	then fib_seq n 
	else
		let p1 = Task.async pool (fun _ -> fib (n-1) ) in 
		let p2 = Task.async pool (fun _ -> fib (n-2) ) in 
		(Task.await pool p1 ) + (Task.await pool p2) 
		(* Esperamos o resultado das duas e somamos *)
	in
	Task.run pool (fun _  -> fib n) (*Manda a thread principal executar também.*)
;;

let () 
	print_string "n: ";
	let n = read_int () in 
	let total_threads = Domain.recommended_domain_count () in 
	let pool = Task.setup_pool ~num_domains:(total_threads - 1) () in 
	(* Cria a pool. ~num_domains é um parâmetro nomeado. *)
	fib_par pool 20 n; 
	Task.teardown_pool pool (* Libera a pool *)
;;
```

Também temos o `for` paralelo.
```ocaml
module Task = Domainslib.Task;; 
let programa () = 
	print_string "n ";
	let n = read_int () in
	let v = Array.init n (fun i -> i*i)
	let tt = Domain.recommended_domain_count () in 
	let pool = Task.setup_pool ~num_domains:(tt - 1) () in 
	let imprimir_em_paralelo () = 
		Task.parallel_for pool ~start:0 ~finish:(n-1)
		~body:(fun i -> Printf.printf "v[%d] = d%n\n") i v.(i))
	in
	Task.run pool (fun _ -> imprimir_em_paralelo ());
	Task.teardown_pool pool
;;
```