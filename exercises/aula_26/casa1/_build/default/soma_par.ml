module T = Domainslib.Task;;

let somar v i fim =
  let k = ref 0. in 
  for j = i to fim do 
    k := !k +. v.(j)
  done;
  !k
;; 
 

let somar_par pool tam_seq v = 
  let n = Array.length v in 
  let num_partes = n / tam_seq in 
  let parallel_sum i = 
    let inicio = i * tam_seq in
    let fim = min (inicio + tam_seq) n in 
    somar v inicio fim  (* Ajuste para o índice final correto *)
  in
  let resultado = Array.make num_partes 0. in 
  let threads = Array.init num_partes (fun i -> T.async pool (fun _ -> parallel_sum i)) in 
  for i = 0 to num_partes - 1 do  (* Ajuste para o loop final *)
    resultado.(i) <- (T.await pool (threads.(i)))
  done;
  Array.fold_left (+.) 0. resultado
;;


let () = 
  print_string "Insira o tamanho sequencial: ";
  let tam_seq = read_int () in
  let v = Array.init 1000 (fun _ -> Random.float 1000.) in 
  let tt = Domain.recommended_domain_count () in 
  let pool = T.setup_pool ~num_domains:(tt - 1) () in 
  let resultado = somar_par pool tam_seq v in 
  Printf.printf "%f" resultado; 
  T.teardown_pool pool;
;;
