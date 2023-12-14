### Exemplos do Cálculo λ Simplesmente Tipado
- "true" e "false" são **termos**
- "0", "1", "2" ... etc, também são termos.
- "if true then 1 else 0" é um termo
- "if true then 1 else true" também
- **Mas**, "if true then 1 else 0" tem tipo **Nat**, enquanto "if true then 1 else true" **não tem tipo**.
- "if true then false else true" também é um termo, de tipo **Bool**
- "suc 3" é um termo, cuja avaliação leva ao **valor** (resultado) "4", que também é um termo, mas **irredutível**
- "pred 1" e "pred 0" também são termos (que se reduzem a zero e zero)
- "eh_zero 0" e "eh_zero 1" também são termos (e se reduzem a "true" e "false", respectivamente)
- "suc" e "pred" são termos de tipo "Nat -> Nat", enquanto "eh_zero" é de tipo "Nat -> Bool"

- "λn: Nat. suc(suc(n))" é um termo de tipo "Nat -> Nat"
- "(λb: Bool. if b then false else true) true é um termo (aplicação de função a argumento) de tipo "Bool", e se reduz ao valor false
- "λf:Nat->Nat. f 0" é um termo do tipo "(Nat -> Nat) -> Nat"
- "(λf: Nat -> Nat. f 0 ) suc" é um termo de tipo "Nat"

- "((λf: Nat -> Nat. (λn: Nat. f(f(f n)))) suc) 0 é um termo de tipo **"Nat"**

A redução do termo acima é:
"((λf: Nat -> Nat. (λn: Nat. f(f(f n)))) suc) 0
-> (λn: Nat. suc(suc(suc n))) 0
-> suc(suc(suc 0 ))
-> suc(suc 1)
-> suc 2 
-> 3 

aula 11