module type InterfacePilha = 
sig 
    type 'a pilha (* Em OCaml, usamos t como padrão para o tipo *)
    val criar: 'a -> 'a pilha
    val empilhar: 'a pilha -> 'a -> unit 
    val consultar_topo: 'a pilha -> 'a 
    val desempilhar: 'a pilha -> 'a 
    val vazia: 'a pilha -> bool
end



module Pilha : InterfacePilha = 
struct

(* deve ser chamado de t por convenção *)
type 'a pilha = 'a list ref

let criar (elem : 'a) : 'a pilha = 
  ref []

let empilhar (p : 'a pilha) (elem: 'a) : unit = 
    p := elem :: !p 


let vazia (p: 'a pilha) = 
  !p = []

let consultar_topo (p : 'a pilha) : 'a = 
  match !p with 
  | [] -> failwith "desempilhar: lista vazia"
  | h :: t -> h

let desempilhar (p : 'a pilha) : 'a = 
  match !p with 
  | [] -> failwith "desempilhar: lista vazia"
  | h :: t -> p := t; h

end;;

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
