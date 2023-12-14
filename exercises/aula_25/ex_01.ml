let imprimir caractere qtd =
    for i = 1 to qtd do 
        print_char caractere
    done;
    print_char '\n'
;;

let programa () = 
    print_string "Quantidade de caracteres: "; 
    let qtd = read_int () in 
    let t1 = Domain.spawn (fun _ -> imprimir '/' qtd ) in
    let t2 = Domain.spawn (fun _ -> imprimir '.' qtd ) in 
    Domain.join t1;
    Domain.join t2
;;

programa ();;


