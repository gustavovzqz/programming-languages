(* Escreva em OCaml um programa que leia do usuário sucessivas datas com dia, mês e ano; a entrada deve parar quando, ao invés de uma data, o usuário digitar uma linha vazia. Ao final, o programa deve imprimir as datas da mais antiga para a mais recente. *)

type data = {dia : int; mes : int; ano : int};;

let rec receber_data () = 
        print_endline "Insira um data dd/mm/aaaa: ";
        let linha = read_line () in 
        if linha = "" then [] else 
        let conv ini tam = int_of_string (String.sub linha ini tam) in
        let dia = conv 0 2 in 
        let mes = conv 3 2 in
        let ano = conv 6 4 in 
        {dia; mes; ano} :: receber_data ()
;;

let maior_que d1 d2 = (* D1 é mais antigo que D2?*)
        if d1.ano < d2.ano then true else
                if d1.ano = d2.ano && d1.mes < d2.mes then true else
                        if d1.ano = d2.ano && d1.mes = d2.mes && d1.dia < d2.dia then true else
                                false
;;

let rec maior_data l1 maior = 
        match l1 with
        | [] -> maior 
        | h :: t ->
                        if (maior_que maior h) then maior_data t h else maior_data t maior
;; 

let rec remover_elemento l1 elemento = 
        match l1 with
        | [] -> [] 
        | h :: t -> if h = elemento then t else h :: remover_elemento t elemento
;;

let rec ordenar l1 aux = 
        match l1 with
        | [] -> aux 
        | h :: t -> let maior = maior_data l1 h in 
        ordenar (remover_elemento l1 maior) (maior :: aux)
;;

(* Não precisava necessariamente ordenar, para o programa poderiamos apenas ir removendo o menor e printando. *)


let rec printar l = 
        match l with
        | [] -> ()
        | {dia; mes; ano} :: t -> Printf.printf "%d/%d/%d\n" dia mes ano; printar t
;;


let programa () = 
        let a = receber_data () in 
        printar (ordenar a []);;
        (* Pronto! *)








