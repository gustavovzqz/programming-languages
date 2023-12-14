(* deve ser chamado de t por convenção *)
type 'a pilha = 'a list ref;;

let criar (elem : 'a) : 'a pilha = 
  ref []
;;

let empilhar (p : 'a pilha) (elem: 'a) : unit = 
    p := elem :: !p 
;;

let vazia (p: 'a pilha) = 
  !p = []
;;

let consultar_topo (p : 'a pilha) : 'a = 
  match !p with 
  | [] -> failwith "desempilhar: lista vazia"
  | h :: t -> h
;;

let desempilhar (p : 'a pilha) : 'a = 
  match !p with 
  | [] -> failwith "desempilhar: lista vazia"
  | h :: t -> p := t; h
;;

let programa () = 
  let p = Pilha.criar 0 in 
  let rec ler () = 
    try 
      print_string "# a empilhar (outra coisa p/ parar): ";
      Pilha.empilhar p (read_int());
      ler ()
    with 
    | Failure _ -> ()
  in 
  ler();
  while not (Pilha.vazia p) do 
    Printf.printf "Desempilhando: %d\n" (Pilha.desempilhar p)
  done
;;

programa ();;