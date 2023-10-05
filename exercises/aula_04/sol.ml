(* Ex 01*)
let rec associar l1 l2 = 
  match l1 with
  | [] -> [] 
  | h :: t -> 
    match l2 with 
    | [] -> []
    | j :: k ->
      (h, j) :: associar t k
;;

(* Ex 02*)
let rec substituir a b l =
  match l with
  | [] -> []
  | h :: t -> if h = a then b :: substituir a b t else h :: substituir a b t
;;

(* Ex 03 *)

let rec mapear func l1 = 
  match l1 with 
  | [] -> []
  | h :: t -> func h :: (mapear func t);; 
  

let substituir_2 a b l =
  mapear (fun i -> if i = a then b else i) l
;;