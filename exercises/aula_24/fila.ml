module type InterfaceFila = 
sig 
    type 'a t
    val criar : 'a -> 'a t 
    val enfilar : 'a t -> 'a -> unit 
    val desenfilar : 'a t -> 'a 
    val vazia : 'a t -> bool 
    val primeiro : 'a t -> 'a
    val teste : int
end

module Fila : InterfaceFila = 
struct

let teste = 3 

type 'a t = 'a list ref 

let criar elem = 
    ref []

let vazia f =
    !f = []

let primeiro f = 
    match !f with 
    | [] -> failwith "consultar : fila vazia"
    | h :: t -> h 

let desenfilar f = 
    match !f with 
    | [] -> failwith "desenfilar : fila vazia"
    | h :: t -> f := t; h

let enfilar f a = 
    f:= !f @ [a]

end;;





    
