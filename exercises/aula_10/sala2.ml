(* Ler um arquivo *)

let rec processar arq_in arq_out = 
  try 
    match String.split_on_char ',' (input_line arq_in) with 
    | nome :: ap1 :: ap2 :: [] -> Printf.fprintf arq_out "%s,%g\n" nome (
      (float_of_string ap1 +. float_of_string ap2) /. 2.); processar arq_in arq_out
    | _ -> failwith "notas.txt está em um formato inválido!"
  with
  | End_of_file -> () 
;;

let programa () = 
  try 
    let arquivo_in = open_in "notas.txt" in 
    let arquivo_out = open_out "medias.txt" in  
    processar arquivo_in arquivo_out;
    close_in arquivo_in;
    close_out arquivo_out
  with
  | Sys_error msg -> Printf.printf "Erro %s\n" msg
;;

programa ();;

