        
let intercalar v inicio fim = 
    let n = fim - inicio + 1 in 
    let meio = (inicio + fim) / 2 in (* 6 *) 
    let a = Array.make n 0 in  (* [0, 0, 0, 0, 0 ,0|]*)
    let k = ref 0 in 
    let i = ref inicio in (* 4 *) 
    let j = ref (meio + 1)  in (* 7 *)
    begin 
        while (!i <= meio && !j <= fim) do
            if (v.(!i) < v.(!j)) 
            then
                begin
                    (* Printf.printf "%d é menor que %d\n" v.(!i) v.(!j); *)
                    a.(!k) <- v.(!i);
                    (* Printf.printf "A[%d] recebeu %d\n" !k v.(!i); *)
                    i := !i + 1; 
                    k := !k + 1;
                end
            else 
                begin 
                    a.(!k) <- v.(!j);
                    j := !j + 1;
                    k := !k + 1
                end
        done;



        while (!i <= meio) do
            a.(!k) <- v.(!i);
            i := !i + 1;
            k := !k + 1
        done;
        

        while (!j <= fim) do 
            a.(!k) <- v.(!j);
            j := !j + 1;
            k := !k + 1
        done;
    end;
    for c = 0 to (Array.length a - 1) do
        v.(inicio + c) <- a.(c)
    done
;;


(*
   4 5 6 1 2 3 
   4 5 6 7 8 9 

   *)




    

let rec m_sort_seq l i j =
    if j <= i then ()
    else
    let k = (i + j) / 2 in 
    m_sort_seq l i k; (* Ordena primeira metade *)
    m_sort_seq l (k + 1) j; (* Ordena segunda metade *)
    intercalar l i j
;; 


module Task = Domainslib.Task;;

let merge_sort_paral vetor pool lim_inf  = 
    let rec m_sort l i j =
        if (j - i) <= lim_inf then 
            m_sort_seq l i j
        else 
        if j <= i then ()
        else
        let k = (i + j) / 2 in 
        let p1 = Task.async pool (fun _ -> m_sort l i k) in  (* Ordena primeira metade *)
        let p2 = Task.async pool (fun _ -> m_sort l (k + 1) j) in
        Task.await pool p1;
        Task.await pool p2;
        intercalar l i j 
    in 
    Task.run pool (fun _ -> m_sort vetor 0 (Array.length vetor - 1))
;;

let () = 
    let a = Array.init 4000 (fun _ -> Random.int 10000) in
    let total_threads = Domain.recommended_domain_count () in 
    let pool = Task.setup_pool ~num_domains:(total_threads - 1) () in 
    merge_sort_paral a pool 20; 
    Array.iter (fun i -> Printf.printf "%d " i ) a;
    Task.teardown_pool pool
;;