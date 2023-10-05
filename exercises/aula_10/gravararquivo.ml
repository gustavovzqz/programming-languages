let rec ler_e_escrever arquivo =
  let linha = read_line () in
  if linha = "" then ()
  else
    begin
      output_string arquivo (linha ^ "\n");
      ler_e_escrever arquivo
    end
;;

let programa () =
  print_string "Nome do arquivo a ser gravado: ";
  let arquivo = open_out (read_line ()) in
  print_endline "Digite o texto, encerrando com linha vazia: ";
  ler_e_escrever arquivo;
  close_out arquivo
;;

programa ();;
