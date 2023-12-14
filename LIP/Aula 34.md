# Funções sobre estruturas

```cpp
#include <cmath>
#include <iostream>
using namespace std;

struct Vetor3d {double x, y, z;};

double tamanho (Vetor3D v)
	{
	return sqrt(v.x*v.x + v.y*v.y + v.z*v.z)
	}
	
int main()
	{
	Vetor3d v = {1, 2, 3};
	cout << tamanho(v) << '\n';
	}
```

Podemos colocar as funções dentro das estruturas.

```cpp
#include <cmath>
#include <iostream>
using namespace std;

struct Vetor3d 
	{
	double x, y, z;

	double tamanho() // const (opcional) para não alterar o objeto.
		{
		return sqrt(x*x + y*y + z*z);
		}
	};
	
int main()
	{
	Vetor3d v = {1, 2, 3};
	cout << v.tamanho() << '\n';
	}
```

#### Sobrecarga de operadores
`
```cpp
#include <cmath>
#include <iostream>
#include <ostream>
using namespace std;

struct Vetor3d 
	{
	double x, y, z;

	double tamanho() // const (opcional) para não alterar o objeto.
		{
		return sqrt(x*x + y*y + z*z);
		}
	};

Vector3D operator + (Vector3D a, Vector3D b)
	{
	return {a.x + b.x, a.y + b.y, a.z + b.z};
	}

ostream& operator << (ostream &saida, Vetor3D v)
	{
	 saida << "[" << v.x << ", " << v.y << ", " << v.z << "]";
	 return saida;
	}

int main()
	{
	Vetor3d v = {1, 2, 3};
	cout << v.tamanho() << '\n';
	cout << v + w << '\n' ;
	}
```

#### Alterando operador ()
```cpp
#include <iostream>
using namespace std;
struct Contador
	{
	int c;
	void iniciar (int valor_inicial)
		{
		c = valor_inicial;
		}
	int operator () ( // Aqui ficariam os parâmetros )
		{
		return ++c;
		}
	};
int main ()
	{
	c.iniciar(0)
	cout << c() << '\n';
	cout << c() << '\n';
	cout << c() << '\n';
	}
```