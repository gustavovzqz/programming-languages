module Task = Domainslib.Task;;
let programa () = 
  print_string "n: ";
  let n = read_int () in 
  let v = Array.init n (fun i -> i * i ) in
  print_endline "Impressão Sequencial:";
  for i = 0 to n - 1 do
    Printf.printf "v[%d] = %d\n" i v.(i)
  done;
  print_endline "Impressão Paralela: ";
  let tt = Domain.recommended_domain_count() in 
  let pool = Task.setup_pool ~num_domains:(tt - 1) () in 
  let imprimir_em_paralelo () = 
    Task.parallel_for pool ~start:0 ~finish:(n-1)
      ~body:(fun i -> Printf.printf "v[%d] = %d\n" i v.(i))
        (* ~chunck_size:(n / tt) 
           (* Separa em blocos (chuncks). Acima usamos uma estimativa 
              'padrão', caso cada iteraçao dure aproximadamente o mesmo
              tempo. *)*)
  in
  Task.run pool (fun _ -> imprimir_em_paralelo ());
  Task.teardown_pool pool
;;

programa();; 