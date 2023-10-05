let rec input_dados () = (* Funciona corretamente *)
  print_string "Insira um nome (vazio para parar): ";
  let a = read_line () in
  if a = "" then
    []
  else 
  begin
    print_string "Insira um número: ";
    let b = read_int () in
    (a, b) :: input_dados ()
  end
;;

let rec printar_nomes data (num : int) = (* Funciona corretamente *)
  match data with
  | [] -> print_endline "Fim dos dados!"
  | ((a, n) :: t) ->
    if n = num then
      begin
        print_endline a;
        printar_nomes t num
      end
    else
      printar_nomes t num
;;

let rec ler_dados data = (* Qual o problema?*)
  print_string "Insira um número (negativo para parar): ";
  let a = read_int() in 
    if a > 0 then 
      begin
        printar_nomes data a;
        ler_dados data
      end
    else
      print_endline "Obrigado por usar o programa! "
;;

let programa () =
  ler_dados (input_dados ());;