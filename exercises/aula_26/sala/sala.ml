module Task = Domainslib.Task ;;

let rec fib_seq n = 
    if n < 2 (* n = 0 ou n = 1 *)
    then n 
    else fib_seq (n-2) + fib_seq(n-1)
;;


let fib_par pool lim_inferior_paralelo n =
    let rec fib n = 
        if n < lim_inferior_paralelo || n < 2 
        then fib_seq n 
        else   (* Inicia threads assincronas dado um pool *)
            let p1 = Task.async pool (fun _ -> fib (n-1) ) in 
            let p2 = Task.async pool (fun _ -> fib (n-2) ) in
            (Task.await pool p1) + (Task.await pool p2)
    in
    (* Precisam acontecer dentro do Task.run -> 
        - Por motivos técnicos 
        - Para colocar a thread "main" para trabalhar. *)
    Task.run pool (fun _ -> fib n)
;;

let cronometrar f n descricao = 
    Printf.printf "Iniciando %s\n" descricao; 
    let ini = Unix.gettimeofday () in
    f n; 
    let fim = Unix.gettimeofday () in
    let dur = fim -. ini in 
    Printf.printf "Duração %s: %g\n" descricao dur;
    dur
;;

let () = 
    print_string "Insira um número para calcularmos Fib(n): ";
    let n = read_int () in 
    print_string "Insira o limite inferior"; 
    let lim = read_int () in 
    let dur_seq = cronometrar (fib_seq) n "Sequencial" in
    let total_threads = Domain.recommended_domain_count () in 
    let pool = Task.setup_pool ~num_domains:(total_threads -1 ) () in 
    let dur_par = cronometrar (fib_par pool lim) n "Paralelo" in 
    Printf.printf "Paralelo %g vezes mais rápido\n" (dur_seq /. dur_par);
    Task.teardown_pool pool
;;
