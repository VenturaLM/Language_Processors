%{
	/*** Compilation: 
			make NAME=exercise_4 
	***/

	/*** Execution: 
			./exercise_4.exe ejemplo_1.txt
			./exercise_4.exe ejemplo_1.txt ejemplo_2.txt
	***/

	/*** Description:
			Analizador léxico que permite reconocer los componentes léxicos de un programa
			escrito es pseudocódigo. Para más información ver "Ejercicios-Flex.pdf".
	***/

	#include "exercise_4.h"
	#include <string.h>
	#include <stdlib.h>
	#include <ctype.h>

	int token, commentSize = 0, stringSize = 0;
	char *aux, *comment = NULL;

	char *lowerCase(char *c);
	int isReserved(char *c);
	
%}
space [ \t\n]
spaces {space}+
identifier [a-zA-Z](_?[a-zA-Z0-9])*
number [0-9]+(\.[0-9]*)?|[0-9](\.[0-9]*)?e[0-9]+
word [a-zA-Z0-9]*_*[a-zA-Z0-9]*_*
operators :=|\+|-|\*|\/|#mod|#div|\*\*|\|\||<|<=|>|>=|==|<>|#o|#y|#no

%x ESTADO_COMENTARIO ESTADO_CADENA
%%
{spaces} {;}
{identifier} {
	aux = lowerCase(yytext);
	token = isReserved(aux);

	if(token != -1)
		fprintf(yyout,"\nReserverd word: <%s> --> token %d\n", yytext, token);
	else
		fprintf(yyout,"\nIdentifier: <%s> --> token %d\n", yytext, IDENTIFICADOR);
}
"'" {
	BEGIN ESTADO_CADENA;
	aux = malloc(sizeof(char));
}
<ESTADO_CADENA>"'" {
	fprintf(yyout,"\nString: <%s> --> token %d\n", aux, CADENA);
	aux = NULL;
	stringSize = 0;
	BEGIN 0;
}
<ESTADO_CADENA>.|\n {
	stringSize ++;
	aux = realloc(aux, stringSize * sizeof(char));
	aux[stringSize - 1] = yytext[0];
}
<ESTADO_CADENA>"\\'" {
	stringSize ++;
	aux = realloc(aux, stringSize * sizeof(char));
	aux[stringSize - 1] = yytext[1];
}
{number} {fprintf(yyout,"\nNumber: <%s> --> token %d\n", yytext, NUMERO);}
{word} {fprintf(yyout,"\nError: invalid identifier.\n");}
[0-9]*,[0-9]* {fprintf(yyout,"\nError: invalid number.\n");}
{operators} {
	if(strcmp(yytext,":=")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, ASIGNACION);
	if(strcmp(yytext,"+")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, SUMA);
	if(strcmp(yytext,"-")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, RESTA);
	if(strcmp(yytext,"*")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, PRODUCTO);
	if(strcmp(yytext,"/")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, DIVISION);
	if(strcmp(yytext,"#mod")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, MODULO);
	if(strcmp(yytext,"#div")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, DIVISION_ENTERA);
	if(strcmp(yytext,"**")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, POTENCIA);
	if(strcmp(yytext,"||")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, CONCATENACION);
	if(strcmp(yytext,"<")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, MENOR_QUE);
	if(strcmp(yytext,"<=")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, MENOR_IGUAL_QUE);
	if(strcmp(yytext,">")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, MAYOR_QUE);
	if(strcmp(yytext,">=")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, MAYOR_IGUAL_QUE);
	if(strcmp(yytext,"==")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, IGUAL);
	if(strcmp(yytext,"<>")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, DISTINTO);
	if(strcmp(yytext,"#o")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, DISYUNCION_LOGICA);
	if(strcmp(yytext,"#y")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, CONJUNCION_LOGICA);
	if(strcmp(yytext,"#no")==0)
		fprintf(yyout,"\nOperator: <%s> --> token %d\n", yytext, NEGACION_LOGICA);
}
; {fprintf(yyout,"\nEnd of statement: <%s> --> token %d\n", yytext, FIN_SENTENCIA);}
\( {fprintf(yyout,"\nOpening parentheses: <%s> --> token %d\n", yytext, PARENTESIS_INICIAL);}
\) {fprintf(yyout,"\nEnding parentheses final: <%s> --> token %d\n", yytext, PARENTESIS_FINAL);}
"<<" {
	BEGIN ESTADO_COMENTARIO;
	commentSize = 2;
	comment = malloc(commentSize * sizeof(char));

	int i = 0;
	for(i = 0; i < commentSize; i++)
		comment[i] = '<';
}
<ESTADO_COMENTARIO>">>" {
	BEGIN 0;
	commentSize += 2;
	comment = realloc(comment, commentSize);
	comment[commentSize - 1] = '>';
	comment[commentSize - 2] = '>';
	comment[strlen(comment) - 2] = '\0';
	fprintf(yyout,"\nComment: %s --> token %d\n", comment, COMENTARIO);
	commentSize = 0;
	comment = NULL;
}
<ESTADO_COMENTARIO>"<<"(.|\n) {fprintf(yyout,"Error: comments cannot be nested.\n Debería ser así:");}
<ESTADO_COMENTARIO>.|\n {
	commentSize ++;
	comment = realloc(comment, commentSize);
	comment[commentSize - 1] = yytext[0];
}
[\!\!].*$ {fprintf(yyout,"\nInline comment: <%s> --> token %d\n", yytext, COMENTARIO_LINEA);}
. {fprintf(yyout,"%s<-Not recognized character.\n",yytext);}
%%

extern FILE *yyin, *yyout;

char *lowerCase(char *c)
{
	char *aux_string = malloc(strlen(c) * sizeof(char));

	int i = 0;
	for(i = 0; i < (strlen(c) - 1); i++)
		aux_string[i] = tolower(c[i]);
	
	return aux_string;
}

int isReserved(char *c)
{
	char reserved_words[][15] = {
		"inicio",
		"fin",
		"leer",
		"escribir",
		"si",
		"entonces",
		"si_no",
		"fin_si",
		"mientras",
		"hacer",
		"fin_mientras",
		"repetir",
		"hasta_que",
		"para",
		"desde",
		"hasta",
		"pasa",
		"fin_para"
	};

	int i = 0;
	for(i = 0; i <= ( sizeof(reserved_words) / sizeof(reserved_words[0]) ) ; i++)
	{
		if(strcmp(reserved_words[i], c) == 0)
			return (257 + i);
	}
	
	return -1;
}

int main(int argc, char **argv)
{
	if(argc > 3)
	{
		printf("Error: wrong input!\n");
		return -1;
	}

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
    }

    yylex();

	fclose(yyin);
	fclose(yyout);

    return 0;
}