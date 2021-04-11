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
%x KING QUEEN BISHOP KNIGHT ROOK
%%
[R] {BEGIN(KING);}
[D] {BEGIN(QUEEN);}
[A] {BEGIN(BISHOP);}
[C] {BEGIN(KNIGHT);}
[T] {BEGIN(ROOK);}

<KING>[a-h][1-8] {fprintf(yyout, "El rey se mueve a la casilla %c%c.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<KING>[a-h][a-h][1-8] {fprintf(yyout, "El rey de la columna %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<KING>[1-8][a-h][1-8] {fprintf(yyout, "El rey de la fila %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<KING>"x"[a-h][1-8] {fprintf(yyout, "El rey se come la pieza de la casilla %c%c.\n", yytext[1], yytext[2]); BEGIN(INITIAL);}
<KING>[a-h][1-8]\+ {fprintf(yyout, "El rey se pone en la casilla %c%c y da jaque.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<KING>[a-h][1-8]\+\+ {fprintf(yyout, "El rey se pone en la casilla %c%c y da jaque mate.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}

<QUEEN>[a-h][1-8] {fprintf(yyout, "La dama se mueve a la casilla %c%c.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<QUEEN>[a-h][a-h][1-8] {fprintf(yyout, "La dama de la columna %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<QUEEN>[1-8][a-h][1-8] {fprintf(yyout, "La dama de la fila %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<QUEEN>"x"[a-h][1-8] {fprintf(yyout, "La dama se come la pieza de la casilla %c%c.\n", yytext[1], yytext[2]); BEGIN(INITIAL);}
<QUEEN>[a-h][1-8]\+ {fprintf(yyout, "La dama se pone en la casilla %c%c y da jaque.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<QUEEN>[a-h][1-8]\+\+ {fprintf(yyout, "La dama se pone en la casilla %c%c y da jaque mate.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}

<BISHOP>[a-h][1-8] {fprintf(yyout, "El alfil se mueve a la casilla %c%c.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<BISHOP>[a-h][a-h][1-8] {fprintf(yyout, "El alfil de la columna %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<BISHOP>[1-8][a-h][1-8] {fprintf(yyout, "El alfil de la fila %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<BISHOP>"x"[a-h][1-8] {fprintf(yyout, "El alfil se come la pieza de la casilla %c%c.\n", yytext[1], yytext[2]); BEGIN(INITIAL);}
<BISHOP>[a-h][1-8]\+ {fprintf(yyout, "El alfil se pone en la casilla %c%c y da jaque.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<BISHOP>[a-h][1-8]\+\+ {fprintf(yyout, "El alfil se pone en la casilla %c%c y da jaque mate.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}

<KNIGHT>[a-h][1-8] {fprintf(yyout, "El caballo se mueve a la casilla %c%c.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<KNIGHT>[a-h][a-h][1-8] {fprintf(yyout, "El caballo de la columna %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<KNIGHT>[1-8][a-h][1-8] {fprintf(yyout, "El caballo de la fila %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<KNIGHT>"x"[a-h][1-8] {fprintf(yyout, "El caballo se come la pieza de la casilla %c%c.\n", yytext[1], yytext[2]); BEGIN(INITIAL);}
<KNIGHT>[a-h][1-8]\+ {fprintf(yyout, "El caballo se pone en la casilla %c%c y da jaque.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<KNIGHT>[a-h][1-8]\+\+ {fprintf(yyout, "El caballo se pone en la casilla %c%c y da jaque mate.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}

<ROOK>[a-h][1-8] {fprintf(yyout, "La torre se mueve a la casilla %c%c.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<ROOK>[a-h][a-h][1-8] {fprintf(yyout, "La torre de la columna %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<ROOK>[1-8][a-h][1-8] {fprintf(yyout, "La torre de la fila %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]); BEGIN(INITIAL);}
<ROOK>"x"[a-h][1-8] {fprintf(yyout, "La torre se come la pieza de la casilla %c%c.\n", yytext[1], yytext[2]); BEGIN(INITIAL);}
<ROOK>[a-h][1-8]\+ {fprintf(yyout, "La torre se pone en la casilla %c%c y da jaque.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}
<ROOK>[a-h][1-8]\+\+ {fprintf(yyout, "La torre se pone en la casilla %c%c y da jaque mate.\n", yytext[0], yytext[1]); BEGIN(INITIAL);}

[a-h][1-8] {fprintf(yyout, "El peón se mueve a la casilla %c%c.\n", yytext[0], yytext[1]);}
[a-h][a-h][1-8] {fprintf(yyout, "El peón de la columna %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]);}
[1-8][a-h][1-8] {fprintf(yyout, "El peón de la fila %c se mueve a la casilla %c%c.\n", yytext[0], yytext[1], yytext[2]);}
[a-h]"x"[a-h][1-8] {fprintf(yyout, "El peón de la casilla %c%d se come la pieza de la casilla %c%c.\n", yytext[0], whereIsThePawn(yytext[0], yytext[2], yytext[3] - '0'), yytext[2], yytext[3]);}
[a-h]"x"[a-h][1-8]" a. p." {fprintf(yyout, "El peón de la casilla %c%d se come la pieza de la casilla %c%c captura al paso.\n", yytext[0], enPassant(yytext[0], yytext[2], yytext[3] - '0'), yytext[2], yytext[3]);}
[a-h][1-8]\+ {fprintf(yyout, "El peón se pone en la casilla %c%c y da jaque.\n", yytext[0], yytext[1]);}
[a-h][1-8]\+\+ {fprintf(yyout, "El peón se pone en la casilla %c%c y da jaque mate.\n", yytext[0], yytext[1]);}
[a-h][1|8]"="[R|D|A|C|T] {
	char piece[8] = "";
	
	if(yytext[3] == 68)
		strcpy(piece, "Dama");
	if(yytext[3] == 65)
		strcpy(piece, "Alfil");
	if(yytext[3] == 67)
		strcpy(piece, "Caballo");
	if(yytext[3] == 84)
		strcpy(piece, "Torre");

	fprintf(yyout, "El peón de la columna %c se corona y se convierte en %s.\n", yytext[0], piece); 
	BEGIN(INITIAL);
}

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

int enPassant(char pawn_column, char piece_column, char piece_row)
{
	int square = 0;

	if(pawn_column < piece_column)
        square = piece_row;
	else
        square = piece_row;
	
	return square;
}

int main(int argc, char **argv)
{
	switch(argc)
	{
		case 1:
			break;

		case 2:
			if((yyin = fopen(argv[1], "r")) == NULL)
			{
				printf("Error: file %s not found!\n", argv[1]);
				return -1;
			}
			break;
		
		default:
			printf("Error: wrong input!\n");
			return -1;
	}

    yylex();

	fclose(yyin);

    return 0;
}