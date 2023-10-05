let rec ler_int_positivo () = 
  print_string "Digite um inteiro positivo: ";
  let n = read_int () in
  if n > 0 then n 
  else  ler_int_positivo ();;

  let rec ler_e_somar n =
    if n = 1
    then
      begin 
      print_string "Digite um inteiro: ";
      read_int ()
      end
    else
      begin
      let soma_primeiros = ler_e_somar (n-1) in
      print_string "Digite mais um inteiro: ";
      let outro = read_int () in
      soma_primeiros + outro
      end;;

let n = ler_int_positivo () in
let soma = ler_e_somar n in 
Printf.printf "A média dos %d números é %g\n" n (float_of_int soma /. float_of_int n);;