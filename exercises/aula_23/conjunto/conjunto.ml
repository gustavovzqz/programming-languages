module Conjunto = struct
  type 'a t = 'a list ref

  let criar (_ : 'a) : 'a list ref = ref []

  let pertence elem t =
    let rec aux list =
      match list with [] -> false | h :: t -> if h = elem then true else aux t
    in
    aux !t

  let inserir elem t = if pertence elem t then () else t := elem :: !t

  let remover elem t =
    let rec aux list newlist =
      match list with
      | [] -> t := newlist
      | h :: tail ->
          if h = elem then t := newlist @ tail else aux tail (h :: newlist)
    in
    aux !t []

  let iterar f t =
    let rec aux list newlist =
      match list with [] -> t := newlist | h :: t -> aux t (f h :: newlist)
    in
    aux !t []
end
