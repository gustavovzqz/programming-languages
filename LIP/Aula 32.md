
## Referências
- Em C++, uma referência é simplesmente um nome para um "objeto" (região da memória guardando valor)
- Depois da declaração (e da respectiva inicialização, que é obrigatória), toda ocorrência da referência é sinônima de uma ocorrência do "nome" do objeto referido.

```cpp
#include <iostream>
using namespace std; // Não usar de maneira desregrada.
int main () 
{ 
	int i = 10;

	int &ri = i;

	ri = 5; cout << "i: " << i << '\n';

}
```

- Recomenda-se o seguinte comando para compilação:
`g++ -Wall -Wextra -std=c++20 -pedantic nome.cpp` 

- No contexto das **declarações**, o *&* significa que estamos declarando uma referência
	  `T &r = var`  declara uma referência "r" para a variável "var" de tipo "T"

 - Uma vez inicializada, a referência se referirá ao mesmo objeto até o fim do escopo. (Aqui temos uma diferença aos ponteiros)

-  Também temos vantagens que, em muitas vezes, uma referência para algum objeto não ocupa espaço algum na memória.

- Fazendo trocas:
```cpp
// Versão errado, recebemos só os valores...
void troca (int x, int y)
	{
	 int copia_x = x; x = y; y = copia_x;
	}
	
// Maneira correta (Passamos a referência, não o valor)
void troca (int &x, int &y)
	{
	 int copia_x = x; x = y; y = copia_x;
	}
```

## Ponteiros
A principal diferença para as referências, é que os ponteiros podem ser **reapontados**.

```cpp
#include <iostream>
using namespace std;
int main ()
	{ 
	int i = 10;
	cout << "Endereço de i: " << &i << '\n';
	cout << "Valor de i: " << *(&i) << '\n';
	}
```

- Temos dois operadores básicos em ponteiros
	1. `"& var": denota um ponteiro apontado para "var".
	2. `"* p: denota o objeto ("variável") apontado por "p".

Onde a primeira é uma expressão, assim como "1 + 2", com a diferença de que tem tipo "ponteiro para T", se "T" é  o tipo de "var").

## Declarando ponteiros

- Dado que "T var" declara uma variável "var" de tipo "T", e dado que, nas expressões, `* p` denota o objeto apontado por "p", a intuição da sintaxe da declaração de ponteiros é:
	`"T *p"` denota um ponteiro para "T", afinal, aquilo que será apontado por "p" terá tipo "T". 

- De forma resumida, se quisermos declarar um ponteiro que aponte para objetos de tipo "T", declare uma variável "var" de tipo "T", e em seguida, substitua "var" por `(*p)`

- O nome de um tipo em C++ é obtido simplesmente declarando uma variável "var" e depois retirando "var" do texto da declaração.

```cpp
int main ()
	{
	int i = 10; int *p; p = &i;
	int **q = &p;
	cout << "O endereço de i é" << p << '\n'
		 << "O endereço de p é" << q << '\n';
	int j = 1; *q = &j; *p = -100;
	cout << "i: " << i << '\n'
		 << "j: " << j << '\n';
 	}
```

## Aritmética de Ponteiros

- Se "v" é um vetor de "n" elementos, e 
- Se "p" aponta para um elemento "v[i]"
- Se "j" é um inteiro tal que "0 <= i + j <= n" (podemos apontar para v[n], mesmo que não seja um elemento do vetor)
- Então "p + j" denota um ponteiro para "v[i + j]"
- E "p - j " é o mesmo que "p + (-j)"

```cpp
int main ()
	{ 
	int v[7] = {0, 1, 2, 3, 4, 5, 6};

	int *p = &(v[3]);
	cout << "O endereço de v[0] é " << p - 3 << '\n'
	     << "O endereço de v[0] é " << &( v[0] ) << '\n'
	     << "O valor de v[0] é " << *(p - 3) << '\n'
	     << "O valor de v[5] é " << *(p + 2) << '\n';	     
	}
```

- Se "p" aponta para "v[i]" e "q" aponta para "v[j]", então:
- "p - q" vale o mesmo que "i - j"
- "p < q" vale o mesmo que "i < j"

```cpp 
int main () 
{ 
	double v[7] = {0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6};
	double *p = &(v[2]), *q = &(v[6]);

	cout << "p - q ": << p - q << '\n';
	if (p < q) cout << "p < q \";
	else cout << "p >= q\n";
	}
```

## Indexação

- Se "p" é um ponteiro para e "j" é um inteiro,
- então p[i] é, por definição, igual a `*(p + i)`

```cpp
int main ()
{
int v[7] = {0, 1, 2, 3, 4, 5, 6};

int *p = &(v[2])

cout << "v[5] = " << p[3] << '\n'
	 << "v[0] = " << p[-2] << '\n';
}
```

Versão do Pablo para o exercício de casa.
```cpp
double acum = 0;
for (double *fim = v + n, double *p = v; p < fim; ++p){
	acum += p;
}
return acum;
```

Mas, por que percorrer vetores usando ponteiros é mais rápido?
```cpp
double acum = 0;
for (int i = 0; i < n; ++i){
	acum += v[i]; // *(v + i) 
}
return acum;
```

Podemos ver que o V[i] acaba fazendo uma  soma a mais todas as vezes, já que por definição, V[i] é `*(v + i)`.

Continuando nos exercícios para casa, podemos perceber uma coisa:
```cpp
int main()
{
	double v[10] = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0};
	double *p = &(v[0]);
	double aux = somar(p, 10);
	std::cout << "Solução da primeira questão: " << aux << '\n';
	std::cout << "Solução da segunda questão: " << '\n'
	for (double *k = &(v[0]); k < &(v[10]); k++)
	{
		std::cout << *k << ' ';
	}
	std::cout << '\n';
	inverter(p, 10);
	for (double *k = &(v[0]); k < &(v[10]); k++)
	{
		std::cout << *k << ' ';
	}
}
```

**v** é um nome de um VETOR, porém, quando usamos **v** em um contexto de expressão, ele é convertido para um ponteiro para a primeira posição.

No exemplo acima, poderíamos substituir `&(v[0])` por simplesmente `v`.

Nesse contexto,  o operador [] está definido somente para ponteiros! Quando usamos v[i] em um contexto de vetor, v é considerado ponteiro e o operador funciona sem problemas.

