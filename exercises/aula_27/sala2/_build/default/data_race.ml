let f _ = ();;
let trava = Mutex.create();; 
let programa () =    
    let cont = ref 0 in 
    print_string "n (incrementos/thread): "; 
    let n = read_int () in 
    let tt = Domain.recommended_domain_count () in 
    let v = Array.init tt (fun _ -> Domain.spawn (fun _ ->
                                                        for i = 1 to n do
                                                            f i;
                                                            Mutex.lock trava;
                                                            cont := !cont + 1;
                                                            Mutex.unlock trava
                                                        done
                                                        )) in
    for i = 0 to tt - 1 do 
        Domain.join v.(i)
    done;
    Printf.printf "cont ao final: %d\n" (!cont);
    Printf.printf "Deveria valer: %d\n" (n * tt)
;;  

programa ();;
