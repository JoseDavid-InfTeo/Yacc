#define MAX_SIM 30 /*numero maximo de simbolos para la tabla*/

struct simbolo {
    char    id[20];      // nombre del id
    int     tipo;     // 1.int 2.float 3.char
    int     inic;     // 0 no  1 si
}tabla_simbolos[MAX_SIM];

struct simbolo *buscar_simbolo();
