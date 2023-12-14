# A forma Backus Naur (BNF)

#### 1. Exemplos:
a) `<booleanos> ::= "true" | "false"`
    não terminal    /               terminais

b) `<natural> ::= <dígito> | <dígito> <natural>
    `<digito> = "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"`

#### 2. Exercícios:
a) Escreva uma gramática para números inteiros sem zeros à esquerda
```
<nat_normal> ::= <digito> | <dig_nz> <natural>
<dig_nz> ::= "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"`
<inteiro> ::= <nat_normal> | <sinal> <nat_normal>
<sinal> ::= "+" | "-"
```
- É possível escrever terminais e não terminais de outas formas, desde que fique clara a distinção. Exemplo: não terminais são sublinhados. Dessa forma, o uso de aspas pode ser dispensado caso não gere ambiguidades nem inviabilize a escrita.

b) Escreva uma gramática para expressões com números (abstraia o tipo número), somas e multiplicações
- Primeira solução: 
```
<expr> ::= <número> | <expr> <op> <expr> 
<op> ::= "+" | "*"
```

Vamos tentar derivar "1 + 2 * 3 ":
![[Pasted image 20230908094657.png]]
Vemos que conseguimos interpretar duas coisas de um mesmo texto. Logo a linguagem é ambígua.

- Uma outra solução:
```
<expr> ::= <expr_mult> + <expr> | <expr_mult>
<expr_mult> ::= <numero> * <expr_mult> | <numero>
```
Nesse caso, só há uma interpretação para 1 * 2  + 3. 
Mas e se quiséssemos fazer 1 * (2 + 3) ? ...

#### Sintaxe Concreta vs Sintaxe Abstrata
###### Sintaxe Concreta:
- A sintaxe realmente usada na escrita concreta (de um programa, por exemplo).
` "1 * 2 + 3", "1 * (2 + 3)"`

###### Sintaxe Abstrata:
- Aquela que representa a definição dos objetos em sua forma conceitual. A sintaxe abstrata é (tipicamente) mais fácil de especificar, por que a estrutura conceitual do objeto, por si só, elimina ambiguidades.
- Dessa forma, a gramática abaixo:
```
<expr> ::= <número> | <expr> <op> <expr> 
<op> ::= "+" | "*"
```
Não é ambígua para a sintaxe abstrata de expressões, por que, na sintaxe abstrata, as expressões são "árvores" e só podem ser expressas de uma maneira.

#### 3. Escreva uma gramática com sintaxe abstrata para o cálculo λ simplesmente tipado
- Exemplos de termos podem ser vistos na [[Aula 11]].
Solução:

