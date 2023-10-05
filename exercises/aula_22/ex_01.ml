 
 (* [ 1 , 2, 2, 1 ,2  3, ]*)
 (* Bubble Sort*)
let ordenar_porcaria l = 
  let j = ref (Array.length l - 1) in 
  let varredura fim =     
    let i = ref 0 in
    while !i < fim do  
    if (l.(!i)) > l.(!i+1) then
      let aux = l.(!i) in 
      l.(!i) <- l.(!i+1);
      l.(!i+1) <- aux;
      i := !i + 1
    else
      i := !i + 1
    done
    in 
    while (!j >= 0) do 
      varredura !j;
      j := !j - 1
    done
;;
(* Insertion Sort elegante *)
let ordenar_porcaria_elegante v = 
  let menor = ref 0 in 
  let i = ref 1 in 
  let tam = Array.length v in 
  while !i < tam do 
    if v.(!menor) > v.(!i)
    then menor := !i; 
    i := !i + 1 (* incr i*)
  done;
  let menor_elemento = v.(!menor) in 
  v.(!menor) <- v.(0); 
  v.(0) <- menor_elemento; (* Sentinela *)
  i := 1; 
  while !i < tam do 
    let elem_atual = v.(!i) in 
    let j = ref (!i - 1) in 
    while v.(!j) > elem_atual do (* Não testo se j >= 0: sentinela*)
      v.(!j + 1) <- v.(!j);
      j := !j - 1 (* decr j*)
    done;
    v.(!j + 1) <- elem_atual;
    incr i
  done;




