let copiar_vetor v = 
    Array.init (Array.length v) (fun i -> v.(i))
;;

let copiar_vetores vetores = 
    Array.init (Array.length vetores) (fun i -> copiar_vetor vetores.(i))
;;

let programa () = 
    print_string "Tamanho dos vetores: ";
    let tam = read_int () in 
    print_string "Número de threads: ";
    let num_threads = read_int () in 
(* Aqui poderiamos ter usado num_threads = Domain.recommended_domain_count () *)
    
    let originais = Array.init num_threads 
                        ( fun _ -> Array.init tam (fun _ -> Random.int tam)) in

    let copias_seq = copiar_vetores originais in 
    let ini_seq = Unix.gettimeofday () in (* ... *)
    for i = 0 to num_threads - 1 do 
        Array.sort (fun i j -> i - j) copias_seq.(i)
    done;
    let fim_seq = Unix.gettimeofday () in
    let tempo_seq = fim_seq -. ini_seq in 
    Printf.printf "Tempo Sequencial: %g\n" tempo_seq;
    

    (* Ordenação Paralela *) 
    let copias_par = copiar_vetores originais in 
    let ini_par = Unix.gettimeofday () in 
    let threads = Array.init num_threads (fun i -> Domain.spawn (fun _ -> Array.sort (fun k j -> k - j) copias_par.(i) ) ) in 

    for i = 0 to num_threads - 1 do 
        Domain.join threads.(i)
    done;
    let fim_par = Unix.gettimeofday () in 
    let tempo_par = fim_par -. ini_par in 
    Printf.printf "Tempo Paralelo: %g\n" tempo_par;
    Printf.printf "%g vezes mais rápido" (tempo_seq /. tempo_par)



;;

programa ();;
