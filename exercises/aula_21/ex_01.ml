let permutacao_aleatoria n = 
	let v = Array.init n (fun i -> i + 1) in 
	for ultimo = n - 1 downto 1 do 
	    let i = Random.int (ultimo + 1) in 
	    let cp_i = v.(i) in 
	    v.(i) <- v.(ultimo); 
	    v.(ultimo) <- cp_i
	done;
	v
;;