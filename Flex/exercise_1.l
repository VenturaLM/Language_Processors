%{
	/*** Compilation: 
			make NAME=exercise_1 
	***/

	/*** Execution: 
			./exercise_1.exe entrada.txt
			./exercise_1.exe entrada.txt salida.txt
	***/

	/*** Description: 
			Programa que recibe el nombre de un fichero que puede contener números enteros y que genera
			otro fichero en el que todos los números enteros se han convertido a números reales.

			NOTA - Si un número forma parte de una palabra, este no se modificará.
	***/
%}

character [a-zA-Z]
digit [0-9]
unifier ({character}|{digit})*{character}({character}|{digit})*

%%
[0-9]*\.[0-9]* {fprintf(yyout, "%s", yytext);}
[0-9]* {fprintf(yyout, "%s.0", yytext);}
{unifier} { ECHO; /* Se muestra por pantalla, pero no se indica nada. */}
%%

/*** Functions. ***/

extern FILE *yyin, *yyout;

int main(int argc, char **argv)
{
    switch(argc)
    {
		case 2:
			if((yyin = fopen(argv[1], "r")) == NULL)
			{
				printf("Error: file %s not found!\n", argv[1]);
				return -1;
			}

			break;

		case 3:
			if((yyin = fopen(argv[1], "r")) == NULL)
			{
				printf("Error: file %s not found!\n", argv[1]);
				return -1;
			}

			if((yyout = fopen(argv[2], "w")) == NULL)
			{
				printf("Error: file %s already exists!\n", argv[2]);
				return -1;
			}

			break;
		
		default:
			printf("Error: wrong input!\n");
			return -1;

			break;
    }

    yylex();

    return 0;
}