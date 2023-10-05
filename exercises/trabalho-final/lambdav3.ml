

type tipo = Nat | Bool | Seta of (tipo * tipo) | Sem_tipo
;;

type var = Var of string 

type termo = 
| True
| False
| Numero of int
| Suc  
| Pred  
| Eh_zero
| Var of string
| Apl of (termo * termo)
| If of (termo * termo * termo)
| Lambda of (var * tipo * termo )
| Aplicacao of (termo * termo)
;;

(* Como definir contexto? *)

(* Podemos definir como uma lista de tuplas, para tipar uma variável, vemos se na lista ela possui tipo
   se não possuir, ela não tem tipo...*)
  
let rec tipar_variavel var env =
  match env with 
  | [] -> Sem_tipo
  | (variavel, tipo) :: t -> if variavel = var then tipo else tipar_variavel var t

;;

let rec tipar termo env = 
  match termo with 
  | True -> Bool
  | False -> Bool
  | Numero(_) -> Nat 
  | Suc -> Seta(Nat, Nat)
  | Pred -> Seta(Nat, Nat)
  | Eh_zero -> Seta(Nat, Bool)
  | If(t1, t2, t3) -> let tipo_t2 = tipar t2 env in 
                         if tipar t1 env = Bool && tipo_t2 = tipar t3 env then tipo_t2 else Sem_tipo
  | Var(x) ->  tipar_variavel x env
  | Aplicacao(t, u) -> begin 
                       match tipar t env, tipar u env with 
                       | Seta(u, b), c -> if u = c then b else Sem_tipo
                       | _ -> Sem_tipo 
                       end 
  | Lambda(Var(x), tipo, termo) -> Seta(tipo, tipar termo ((x, tipo) :: env))  
  | _ -> Sem_tipo
;;

(* Toda a parte em cima já trata corretamente (se na sintaxe do programa). Basta fazer o parser! *)


let rec para_tipo tipo =
  match tipo with 
  | "(" :: h -> let (t1, c1) = para_tipo h in 
                  let (t2, c2) = para_tipo c1 in 
                    begin 
                      match c2 with 
                      | ")" :: c3 -> (Seta(t1, t2), c3)
                      | _ -> failwith "!"
                    end 
  | "->" :: h -> para_tipo h
  | "Bool" :: h -> (Bool, h)
  | "Nat" :: h -> (Nat, h) 
  | _ -> failwith "!"
;;

let invalidar var = 
  match var with 
  | "true" | "false" | "if" | "then" | "else" | "endif" | "suc" | "pred" | "ehzero" | "lambda" | "Nat" | "Bool" | "End" -> true 
  | _ -> false

 (* A ideia é que a função retorna (termo lido, resto a ser lido)*)
let rec parser simbolos = 
  match simbolos with 
  | "(" :: h -> let (t1, c1) = parser h in 
                  let (t2, c2) = parser c1 in
                    begin 
                      match c2 with 
                      | ")":: c3 -> (Aplicacao(t1, t2), c3)
                      | _ -> failwith "!"
                    end
  | ")" :: h -> failwith "!" 
  | "if" :: h -> let (t1, c1) = parser h in 
                      begin 
                        match c1 with 
                        | "then" :: c2 -> let (t2, c3) = parser c2 in 
                          begin 
                            match c3 with 
                            | "else" :: c4 -> let (t3, c5) = parser c4 in 
                              begin 
                                match c5 with 
                                  | "endif" :: c4 -> (If(t1, t2, t3), c4)
                                  | _ -> failwith "!"
                              end
                            | _ -> failwith "!"
                          end
                        | _ -> failwith "!"
                      end 
  | "true" :: h -> (True, h)
  | "false" :: h -> (False, h)
  | "suc" :: h -> (Suc, h)
  | "ehzero" :: h ->(Eh_zero, h) 
  | "pred" :: h -> (Pred, h) 
  | "lambda" :: var :: ":" :: h -> if invalidar var then failwith "!" else let (tipo, c) = para_tipo h in 
                                    begin 
                                      match c with 
                                      | "." :: t  -> let (t1, c1) = parser t in 
                                                                        begin 
                                                                          match c1 with 
                                                                          | "end" :: c2 -> (Lambda(Var(var), tipo, t1), c2)
                                                                          | _ -> failwith "!"
                                                                        end
                                      | _ -> failwith "!"
                                    end
  | a :: h -> begin (* Nesse caso, so pode ser uma variável ou um número *)
              try 
              let num = int_of_string a in 
              (Numero(num), h)
              with 
              | Failure _ -> if invalidar a then failwith "!" else (Var(a), h)
              end
  | _ -> failwith "!" 
;;

let printar_tipo tipo = 
  let rec string_of_tipo tipo = 
    match tipo with 
    | Bool -> "Bool"
    | Nat -> "Nat"
    | Seta(a, b) -> let t1 = string_of_tipo a in 
                      let t2 = string_of_tipo b in
                      "( " ^ t1 ^ " -> " ^ t2 ^ " )"
    | Sem_tipo -> failwith "-"
  in 
  let texto = string_of_tipo tipo in 
  print_endline texto
;;


let programa () = 
  let texto = String.split_on_char ' ' (read_line ()) in 
  try 
  let (x, d) = parser texto in
  if d <> [] then failwith "!" 
  else 
  let tipo = tipar x [] in 
  printar_tipo tipo;
  with
  | Failure msg -> Printf.printf "%s\n" msg
;;

programa ();;

















