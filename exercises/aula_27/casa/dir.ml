module Task = Domainslib.Task
open Unix

(* Item A)*)
let mult m1 m2 m3 pool =
  Task.parallel_for pool ~start:0
    ~finish:(Array.length m1 - 1)
    ~body:(fun i ->
      for j = 0 to Array.length m2.(0) - 1 do
        m3.(i).(j) <- 0;
        (* inicializar com 0 *)
        for k = 0 to Array.length m1.(0) - 1 do
          m3.(i).(j) <- m3.(i).(j) + (m1.(i).(k) * m2.(k).(j))
          (* multiplicação correta *)
        done
      done)

(* Item B *)
