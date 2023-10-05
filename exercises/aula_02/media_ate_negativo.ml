let rec ler_e_media i soma = 
  print_endline "Digite um número (negativo para parar): ";
  let numero = read_int () in 
  if numero < 0 
  then (float_of_int soma) /. (float_of_int i) 
  else ler_e_media (soma + numero) (i + 1)
;;

let media = ler_e_media 0 0 in 
Printf.printf "A média é %g\n" media;;
