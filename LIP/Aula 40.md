# Herança Múltipla

```cpp
#include <iostream>
#include <string>
using namespace std;

class B1
{
	int i;
	public:
	virtual void fvb1 () = 0;
	B1 (int v1) : i {vi} {};
	virtual ~B1()
	{
		cout << "Destrutor de B1 com i = " << i << '\n';
	}
};

class B2
{
	double d;
	public:
	virtual void fvb2() = 0;
	B2 (double d1) : d {di} {};
	virtual ~B2()
	{
		cout << "Destrutor de B2 com d = " << d << '\n';
	}
};

class D : public B1, public B2
{
	string s;
	public:
	D(string vs) : B1{10}, b2{0.1}, {vs} {};
	
	void fvb1() override
	{
		cout << "fvb1 em D\n";
	}
	
	void fvb2() override
	{
		cout << "fvb2 em D\n";
	}
	
	~D() override 
	{
		cout << "Destrutor de D com s = " << s << '\n';
	} // Padrão 
};

int main ()
{
	B1 *pb1 = new D{"primeiro"};
	pb1->fvb1();
	
	B2 *pb2 = new D{"segundo"};
	pb2->fvb2();
	
	D d{"terceiro"};
	d.fvb1();
	d.fvb2();
	
	delete pb2;
	delete pb1;
}
```

-  E se as classes herdassem de uma classe comum?

```cpp
#include <iostream>
#include <string>
using namespace std;

class Comum
{
	protected:
	char C;
	public:
	Comum(char vc) : c{vc} {}
	virtual ~Comum()
	{
		cout << "Destrutor de C com c = " << c << '\n';
	} 
};

class B1 : public Comum
{
	int i;
	public:
	virtual void fvb1 () = 0;
	B1 (int v1) : Comum{'!'}, i {vi} {};
	virtual ~B1()
	{
		cout << "Destrutor de B1 com i = " << i << '\n';
	}
};

class B2 : public Comum
{
	double d;
	public:
	virtual void fvb2() = 0;
	B2 (double d1) : Comum{'@'}, d {di} {};
	virtual ~B2()
	{
		cout << "Destrutor de B2 com d = " << d << '\n';
	}
};

class D : public B1, public B2
{
	string s;
	public:
	D(string vs) : B1{10}, b2{0.1}, {vs} {};
	
	void fvb1() override
	{
		cout << "fvb1 em D\n";
	}
	
	void fvb2() override
	{
		cout << "fvb2 em D\n";
	}
	
	~D() override 
	{
		cout << "Destrutor de D com s = " << s << '\n';
		cout << "B1::c: " << B1::c << "B2::c: " << B2::c << '\n';
	} // Padrão 
};

int main ()
{
	B1 *pb1 = new D{"primeiro"};
	pb1->fvb1();
	
	B2 *pb2 = new D{"segundo"};
	pb2->fvb2();
	
	D d{"terceiro"};
	d.fvb1();
	d.fvb2();
	
	delete pb2;
	delete pb1;
}
```


# Bases Virtuais
PEGAR AS FOTOS DESSA PARTE, TA UDO ERRADO

```cpp
#include <iostream>
#include <string>
using namespace std;

class Comum
{
	protected:
	char C;
	public:
	virtual void fvpc() = 0;
	Comum(char vc) : c{vc} {}
	virtual ~Comum()
	{
		cout << "Destrutor de C com c = " << c << '\n';
	} 
};

class B1 : public virtual Comum
{
	int i;
	public:
	virtual void fvb1 () = 0;
	B1 (int v1) : Comum{'!'}, i {vi} {};
	virtual ~B1()
	{
		cout << "Destrutor de B1 com i = " << i << '\n';
	}
	
	void fvpc() override
	{
		cout << "Texto b1\n";
	}
};

class B2 : public Comum
{
	double d;
	public:
	virtual void fvb2() = 0;
	B2 (double d1) : Comum{'@'}, d {di} {};
	void fvpc() override
	{
		cout << "Texto b2\n";
	}
	virtual ~B2()
	{
		cout << "Destrutor de B2 com d = " << d << '\n';
	}
};

class D : public B1, public B2
{
	string s;
	public:
	D(string vs) : Comum{'#'}, B1{10}, b2{0.1}, {vs} {};
	
	void fvb1() override
	{
		cout << "fvb1 em D\n";
	}
	
	void fvb2() override
	{
		cout << "fvb2 em D\n";
	}
	
	void fvpc() override
	{
		cout << "Texto d\n";
	}
	
	~D() override 
	{
		cout << "Destrutor de D com s = " << s << '\n';
		cout << "B1::c: " << B1::c << "B2::c: " << B2::c << '\n';
	} // Padrão 
};

int main ()
{
	D d{"terceiro"};
	d.fvb1();
	d.fvb2();
}
```



- Herdar usando public virtual serve para que, 
B1 HERDA DE C1 USANDO HERANÇA VIRTUAL
B2 HERDA DE C1 USANDO HERANÇA VIRTUAL
D HERDA DE B1 E DE B2, COMO AS DUAS HERDAVAM VIRTUALMENTE, SÓ VAI TER 
UMA INSTÂNCIA DE C1 EM D.

# Casting

- `Downcast`
```cpp
Comum* f()
{
	return (new B1{10});
}

int main ()
{
	Comum *pc = f();
	
	B1 *pb1 = dynamic_cast <B1*> (pc);
	if (pb1) // if (pb1 != nullptr)
	{
		cout << "O meu Comum é B1'\n";
		pb1->fvpc();
	}
	else // Ponteiro nulo
	{
		cout << "O meu comum não é B1!\n";
	}
	
	delete pc;
}

```

- `Downcast` em excesso pode indicar de que o projeto do programa não está muito bom.