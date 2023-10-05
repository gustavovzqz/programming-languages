exception NotaInvalida ;;




let rec ler_notas ja_lidas =
        let invalida nota = nota < 0. || nota > 10.
        in 
        print_string "Digite a AP1: ";
        let linha = read_line () in 
        if linha = ""
        then ja_lidas
        else let ap1 = float_of_string linha in 
                if invalida ap1 
                then raise NotaInvalida
                else begin
                        print_string "Digite a AP2: ";
                        let ap2 = read_float () in 
                        if invalida ap2
                        then raise NotaInvalida 
                        else ler_notas ((ap1, ap2) :: ja_lidas)
                     end
;;

let programa_medias () =
       try 
       List.iter 
         begin fun (ap1, ap2) ->
                 Printf.printf "A média de %g e %g é %g\n"
                 ap1 ap2 ((ap1 +. ap2) /. 2.);
         end
         ( ler_notas [])
       with 
       | NotaInvalida -> print_endline "Nota inválida digitada, saindo";
;;
