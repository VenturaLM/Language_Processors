%{
	/*** Compilation: 
			make NAME=exercise_3
	***/

	/*** Execution: 
			./exercise_3.exe partida.txt
	***/

	/*** Description:
			Analizador léxico que permite reconocer los movimientos de una partida de
			ajedrez utilizando la notación algebraica.
	***/

	#include <string.h>
	#include <stdlib.h>

	int whereIsThePawn(char pawn_column, char piece_column, char piece_row);
	int enPassant(char pawn_column, char piece_column, char piece_row);

%}
%x REY DAMA ALFIL CABALLO TORRE
%%
[R] {BEGIN(REY);}
[D] {BEGIN(DAMA);}
[A] {BEGIN(ALFIL);}
[C] {BEGIN(CABALLO);}
[T] {BEGIN(TORRE);}

<REY>[a-h][1-8] {fprintf(yyout, "El rey se mueve a la casilla %c%c.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<REY>[a-h][a-h][1-8] {fprintf(yyout, "El rey de la columna %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<REY>[1-8][a-h][1-8] {fprintf(yyout, "El rey de la fila %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<REY>"x"[a-h][1-8] {fprintf(yyout, "El rey se come la pieza de la casilla %c%c.\n", yytext[1], yytext[2]); BEGIN(INITIAL);}
<REY>[a-h][1-8]\+ {fprintf(yyout, "El rey se pone en la casilla %c%c y da jaque.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<REY>[a-h][1-8]\+\+ {fprintf(yyout, "El rey se pone en la casilla %c%c y da jaque mate.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}

<DAMA>[a-h][1-8] {fprintf(yyout, "La dama se mueve a la casilla %c%c.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<DAMA>[a-h][a-h][1-8] {fprintf(yyout, "La dama de la columna %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<DAMA>[1-8][a-h][1-8] {fprintf(yyout, "La dama de la fila %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<DAMA>"x"[a-h][1-8] {fprintf(yyout, "La dama se come la pieza de la casilla %c%c.\n", yytext[1], yytext[2]); BEGIN(INITIAL);}
<DAMA>[a-h][1-8]\+ {fprintf(yyout, "La dama se pone en la casilla %c%c y da jaque.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<DAMA>[a-h][1-8]\+\+ {fprintf(yyout, "La dama se pone en la casilla %c%c y da jaque mate.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}

<ALFIL>[a-h][1-8] {fprintf(yyout, "El alfil se mueve a la casilla %c%c.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<ALFIL>[a-h][a-h][1-8] {fprintf(yyout, "El alfil de la columna %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<ALFIL>[1-8][a-h][1-8] {fprintf(yyout, "El alfil de la fila %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<ALFIL>"x"[a-h][1-8] {fprintf(yyout, "El alfil se come la pieza de la casilla %c%c.\n", yytext[1], yytext[2]); BEGIN(INITIAL);}
<ALFIL>[a-h][1-8]\+ {fprintf(yyout, "El alfil se pone en la casilla %c%c y da jaque.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<ALFIL>[a-h][1-8]\+\+ {fprintf(yyout, "El alfil se pone en la casilla %c%c y da jaque mate.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}

<CABALLO>[a-h][1-8] {fprintf(yyout, "El caballo se mueve a la casilla %c%c.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<CABALLO>[a-h][a-h][1-8] {fprintf(yyout, "El caballo de la columna %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<CABALLO>[1-8][a-h][1-8] {fprintf(yyout, "El caballo de la fila %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<CABALLO>"x"[a-h][1-8] {fprintf(yyout, "El caballo se come la pieza de la casilla %c%c.\n", yytext[1], yytext[2]); BEGIN(INITIAL);}
<CABALLO>[a-h][1-8]\+ {fprintf(yyout, "El caballo se pone en la casilla %c%c y da jaque.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<CABALLO>[a-h][1-8]\+\+ {fprintf(yyout, "El caballo se pone en la casilla %c%c y da jaque mate.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}

<TORRE>[a-h][1-8] {fprintf(yyout, "La torre se mueve a la casilla %c%c.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<TORRE>[a-h][a-h][1-8] {fprintf(yyout, "La torre de la columna %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<TORRE>[1-8][a-h][1-8] {fprintf(yyout, "La torre de la fila %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<TORRE>"x"[a-h][1-8] {fprintf(yyout, "La torre se come la pieza de la casilla %c%c.\n", yytext[1], yytext[2]); BEGIN(INITIAL);}
<TORRE>[a-h][1-8]\+ {fprintf(yyout, "La torre se pone en la casilla %c%c y da jaque.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<TORRE>[a-h][1-8]\+\+ {fprintf(yyout, "La torre se pone en la casilla %c%c y da jaque mate.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}

[a-h][1-8] {fprintf(yyout, "El peón se mueve a la casilla %c%c.\n", yytext[0], yytext[1]);}
[a-h][a-h][1-8] {fprintf(yyout, "El peón de la columna %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]);}
[1-8][a-h][1-8] {fprintf(yyout, "El peón de la fila %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]);}
[a-h]"x"[a-h][1-8] {fprintf(yyout, "El peón de la casilla %c%d se come la pieza de la casilla %c%c.\n", yytext[0], whereIsThePawn(yytext[0], yytext[2], yytext[3] - '0'), yytext[2], yytext[3]);}
[a-h]"x"[a-h][1-8]" a. p." {fprintf(yyout, "El peón de la casilla %c%d se come la pieza de la casilla %c%c captura al paso.\n", yytext[0], enPassant(yytext[0], yytext[2], yytext[3] - '0'), yytext[2], yytext[3]);}
[a-h][1-8]\+ {fprintf(yyout, "El peón se pone en la casilla %c%c y da jaque.\n", yytext[0], yytext[1]);}
[a-h][1-8]\+\+ {fprintf(yyout, "El peón se pone en la casilla %c%c y da jaque mate.\n", yytext[0], yytext[1]);}

0\-0 {fprintf(yyout, "Enroque corto.\n");}
0\-0\-0 {fprintf(yyout, "Enroque largo.\n");}
0\-0\+ {fprintf(yyout, "Enroque corto y da jaque.\n");}
0\-0\-0\+ {fprintf(yyout, "Enroque largo y da jaque.\n");}
0\-0\+\+ {fprintf(yyout, "Enroque corto y da jaque mate.\n");}
0\-0\-0\+\+ {fprintf(yyout, "Enroque largo y da jaque mate.\n");}
1\-0 {fprintf(yyout, "Ganan las blancas.\n");}
0\-1 {fprintf(yyout, "Ganan las negra.\n");}
½\-½ {fprintf(yyout, "Tablas.\n");}

. {;}
%%

/*** Functions. ***/

extern FILE *yyin, *yyout;

int whereIsThePawn(char pawn_column, char piece_column, char piece_row)
{
	int square = 0;

	if(pawn_column < piece_column)
        square = piece_row - 1;
	else
        square = piece_row + 1;
	
	return square;
}

/*** TODO ***/
int enPassant(char pawn_column, char piece_column, char piece_row)
{
	int square = 0;

	if(pawn_column < piece_column)
        square = piece_row - 1;
	else
        square = piece_row + 1;
	
	return square;
}

int main(int argc, char **argv)
{
	if(argc == 2)
	{
		if((yyin = fopen(argv[1], "r")) == NULL)
		{
			printf("Error: file %s not found!\n", argv[1]);
			return -1;
		}
	}

    yylex();

	fclose(yyin);

    return 0;
}