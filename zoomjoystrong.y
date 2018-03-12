//Worked Colton Bates.

%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <unistd.h>
	#include "zoomjoystrong.h"
	void yyerror(const char* msg);
	int yylex();
%}

%error-verbose

%start cmd_list

%union {int i; float f;}

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT
%token ERR
%token YYABORT

%type<i> INT
%type<f> FLOAT

%%
cmd_list:	cmd
		|	cmd cmd_list
;

cmd:	statement END_STATEMENT
	|	bork
;

statement:	endstatement
		|	pointstatement
		|	linestatement
		|	circlestatement
		|	rectstatement
		|	setcstatement
;

endstatement:	END
				{exit(0);}
;

pointstatement:	POINT INT INT
				{point($2,$3);}
;

linestatement:	LINE INT INT INT INT
				{line($2, $3, $4, $5);}
;

circlestatement:	CIRCLE INT INT INT
					{circle($2, $3, $4);}
;

rectstatement:	RECTANGLE INT INT INT INT
				{rectangle($2, $3, $4, $5);}
;

setcstatement:	SET_COLOR INT INT INT
				{set_color($2, $3, $4);}
;

bork:			ERR
				{printf("Unexpected character\n");}
%%

/* *********************************************************************
** Runs the program and accepts input.
** @params  not needed colton told me not to include them please dock 
** 			his points and not mine -Patrick
** @return  yes.
********************************************************************* */
int main() {
	setup();
	yyparse();

	//Included sleep here so that the program would 
	//pause before exiting.
	sleep(10);

	finish();
	return 0;
}

/* *********************************************************************
** prints error message
** @params  msg the "string" error message.
********************************************************************* */
void yyerror(const char* msg) {
	fprintf(stderr, "ERROR: %s\n", msg);
}