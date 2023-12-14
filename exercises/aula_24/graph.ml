(* Fazendo um módulo que implementa um Grafo em OCaml *) 

module type Graph = 
    sig
        type t 
        val criar :  int -> t
        val inserir : t -> int -> int -> unit
        val vizinhos : t -> int -> int list 
        exception Graph_error of string 
    end;;

module Grafo : Graph = 
    struct
        type t = int list array
        exception Graph_error of string

        let criar (n : int) : int list array = 
            Array.make n []

           

        let inserir g v1 v2 =
            try 
                g.(v1) <- v2 :: (g.(v1));
                g.(v2) <- v1 :: (g.(v2));
            with
            | Invalid_argument _ -> raise (Graph_error "index out of bounds")

        let vizinhos g n = 
            try 
                (g.(n))
            with
            | Invalid_argument _ -> raise (Graph_error "index out of bounds")
    end;;


