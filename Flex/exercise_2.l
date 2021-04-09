%{
	/*** Compilation: make NAME=exercise_2 ***/
	/*** Execution: ./exercise_2.exe entrada.txt ***/
	/*** Description. ***/

	int words_counter = 0, 
	numbers_counter = 0, 
	comas_counter = 0, 
	dots_counter = 0, 
	spaces_counter = 0, 
	tabs_counter = 0, 
	newLines_counter = 0;
%}

character [a-zA-Z]
digit [0-9]
unifier ({character}|{digit})*{character}({character}|{digit})*
number {digit}+(\.{digit}+)?(E[+\-]?{digit}+)?

%%
[a-z]*[áéíóú]*[a-z]*[ñ]*[a-z]*[áéíóú]*[a-z]* |
[A-Z]*[ÁÉÍÓÚ]*[A-Z]*[Ñ]*[A-Z]*[ÁÉÍÓÚ]*[A-Z]* |
[A-Z]*[a-z]*[áéíóú]*[a-z]*[ñ]*[a-z]*[áéíóú]*[a-z]* {words_counter ++;}
{unifier} {words_counter ++;}
{number} {numbers_counter ++;}
[\,]+ {comas_counter ++;}
[\.]+ {dots_counter ++;}
[\ ]+ {spaces_counter ++;}
\t {tabs_counter ++;}
\n {newLines_counter ++;}
.|\n {;}
%%

/*** Functions. ***/

extern FILE *yyin;

int main(int argc, char **argv)
{
	if(argc != 2)
	{
		printf("Error: wrong input!\n");
		return -1;
	}

	if((yyin = fopen(argv[1], "r")) == NULL)
	{
		printf("Error: file %s not found!\n", argv[1]);
		return -1;
	}

    yylex();

	printf("Words: %d\n", words_counter);
	printf("Numbers: %d\n", numbers_counter);
	printf("Comas: %d\n", comas_counter);
	printf("Dots: %d\n", dots_counter);
	printf("Spaces: %d\n", spaces_counter);
	printf("Tabs: %d\n", tabs_counter);
	printf("New lines: %d\n", newLines_counter);

	fclose(yyin);

    return 0;
}