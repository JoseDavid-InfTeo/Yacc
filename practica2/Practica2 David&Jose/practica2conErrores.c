#define PI 3.1416
#define NUMERO 15
#define SALUDO "Hola"
#define PI 4 //Error por redeclaración de constante

int main(){
	int caca;
	int a = 8 + 8 + 9 + caca; //Error por variable no inicializada
	float b;
	char c;
	int x = 0;

	PI = 5.67; //Error por reasignación a una constante

	scanf("%d", &a); //Error por variable no declarada
	scanf("%d", &b); //Error de tipos incompatibles en scanf
	scanf("%d", &caca);

	if (noExisto < x){	//Error por variable no declarada
		x++;
	}

	while (noExisto2 == 1){ //Error por variable no declarada
		x++;
	}

	for (noExisto3 = 0; x<10; caca++){ //Error por variable no declarada y variable no inicializada
		printf(noExisto4); //Error por variable no declarada
	}
}
