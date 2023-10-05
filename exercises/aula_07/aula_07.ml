(* Immplementando uma árvore *)

type tree = Leaf | Node of int * tree * tree;;

let rec imprimir_em_ordem arv = 
        match arv with
        | Leaf -> ()
        | Node(num, esq, dir) -> imprimir_em_ordem esq; Printf.printf " %d" num; imprimir_em_ordem dir
;;

let a = Node(24, Node(10, Node(5, Leaf, Leaf), Node(12, Leaf, Leaf)), Node(32, Node(29, Leaf, Leaf), Node(35, Leaf, Leaf)));;

(* Exercício de casa: expr_bool. Constantes (true, false) conjução e disjunção e negação*)

type expr_bool =  Verdadeiro | Falso | And of expr_bool * expr_bool | Or of expr_bool * expr_bool | Not of expr_bool;;

let avaliar expressao = 
        let rec aux expressao =  (* Tem como fazer melhor?*) (* Provavelmente usando um Constante of bool e aproveitando do bool da linguagem*)
                match expressao with 
                | And(Verdadeiro, Verdadeiro)  | Or(Verdadeiro, Verdadeiro)  | Or(Verdadeiro, Falso) | Or(Falso, Verdadeiro) | Verdadeiro | Not(Falso) -> Verdadeiro
                | And(Falso, Falso) | And(Verdadeiro, Falso) | And(Falso, Verdadeiro) | Or(Falso, Falso) | Falso | Not(Verdadeiro) -> Falso
                | Not(a) -> aux (Not(aux a))
                | And(a, b) -> aux (And(aux a, aux b))
                | Or(a, b) -> aux (Or(aux a, aux b)) 
        in
        let a = aux expressao in 
        if a = Verdadeiro then true else false
;;

(* Agora precisamos fazer um programa que lê do usuário um texto e transcreve para uma expressão booleana. Retornando o resultado *)

(*Notação -> ou e true false nao true*) (* Or(And(True, False), Not(True)) *)


(* Abaixo está errado na lógica *)

let ler_expressao () =  (* TODO: Não funciona no caso de dois operadores seguidos E OU VERDADEIRO FALSO FALSO enquanto e verdadeiro ou falso falso funciona*)
        let a = String.split_on_char ' ' (read_line ()) in (* Vetor de palavras *)
        let rec converter lista = 
                match lista with
                | [] -> failwith "expressão inválida"  (*[e, verdadeiro, falso]*)
                | h :: t -> 
                        let rec aux head = 
                        match head with 
                        | "nao" -> Not(converter t)
                        | "e" -> 
                                (match t with 
                                |[] -> failwith "expressao invalida" (* Introdução do failwith. Como fazer sem? *)
                                | j :: l -> And(aux j, converter l))
                        | "ou" -> 
                                (match t with 
                                | [] -> failwith "expressao invalida"
                                | j :: l -> Or(aux j, converter l))
                        | "verdadeiro" -> Verdadeiro
                        | "falso" -> Falso  
                        | _ -> failwith "expressao invalida"
                         in aux h
                in 
                converter a 
        in ler_expressao ()
;;


