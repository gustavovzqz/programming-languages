module type InterfaceDicionario = sig
  type 'a t

  val criar : 'a -> 'b -> ('a * 'b) t
  val vazio : 'a t -> bool
  val inserir : ('a * 'b) t -> 'a -> 'b -> unit
  val consultar : ('a * 'b) t -> 'a -> 'b option
  val remover : ('a * 'b) t -> 'a -> unit
  val iterar : ('a * 'b) t -> ('a * 'b -> 'a * 'b) -> unit
end

module Dicionario : InterfaceDicionario = struct
  type 'a t = 'a list ref

  let criar (_ : 'a) (_ : 'b) : ('a * 'b) t = ref []
  let vazio (dic : 'a t) : bool = match !dic with [] -> true | _ -> false

  let pertence dic elem =
    let rec aux list =
      match list with
      | (chave, _) :: _ when chave = elem -> true
      | _ :: t -> aux t
      | [] -> false
    in
    aux !dic

  let inserir (dic : ('a * 'b) t) (chave : 'a) (valor : 'b) =
    if pertence dic chave then () else dic := (chave, valor) :: !dic

  let consultar dic chave =
    if not (pertence dic chave) then None
    else
      let rec aux list =
        match list with
        | (key, valor) :: t -> if key = chave then Some valor else aux t
        | [] -> None
      in
      aux !dic

  let remover (dic : ('a * 'b) list ref) (chave : 'a) : unit =
    let rec aux list newlist =
      match list with
      | (a, _b) :: t ->
          if a = chave then dic := newlist @ t else aux t ((a, _b) :: newlist)
      | [] -> dic := newlist
    in
    aux !dic []

  let iterar dic f =
    let rec aux list newlist =
      match list with [] -> dic := newlist | h :: t -> aux t (f h :: newlist)
    in
    aux !dic []
end
