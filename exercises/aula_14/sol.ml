(* 
    Defina, em OCaml, uma tipo para representar os tipos do Cálculo Lambda Simplesmente Tipado (CλST) que estamos estudando. 
    Use uma variante, com um construtor para cada caso (veja a gramática dos tipos do CλST).
    Em seguida, defina em OCaml um tipo para representar os termos do CλST. 
    Novamente, use um construtor para cada caso (veja a gramática dos termos do CλST).
*)

type tipo = Nat | Bool | Seta of (tipo * tipo)
;;

type var = Var 

type termo = 
| True
| False
| Numero of int
| Suc  
| Pred  
| Eh_zero
| Apl of (termo * termo)
| If of (termo * termo * termo)
| Lambda of (var * tipo * termo )
;;

let aplicacao t1 t2 =
    match t1, t2 with 
    | (Pred, Numero(n)) -> if n = 0 then 0 else n - 1
    | (Suc, Numero(n)) -> n + 1
    | (Eh_zero, Numero(n)) -> n
    | _ -> failwith "eita" (*Falta a aplicação de uma abstração, e o caso em 1ue t1 e t2 são reduzíveis *)
;;

let avaliar_if t1 t2 t3 = 0;;

            

let passo termo = 
    match termo with 
    | True | False | Pred | Suc | Eh_zero | Lambda(_) | Numero(_) -> failwith "O termo já é um valor!"
    | Apl(t1, t2) -> aplicacao t1 t2 (* TODO *)
    | If(t1, t2, t3) ->  avaliar_if t1 t2 t3
    | _ -> failwith "nenhum passo a ser feito." (* Isso é o suficiente?*)