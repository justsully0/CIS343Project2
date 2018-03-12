%{
	#include <stdlib.h>
	#include <stdio.h>
	#include "zjs.tab.h"
%}

%%

end;			{return END;}
;				{return END_STATEMENT;}
point			{return POINT;}
line			{return LINE;}
circle			{return CIRCLE;}
rectangle		{return RECTANGLE;}
set_color		{return SET_COLOR;}
[0-9]+			{yylval.i = atoi(yytext); return INT;}
[0-9]+\.[0-9]+	{yylval.f = atof(yytext); return FLOAT;}
[ \n\t\r]		;
<<EOF>>			{return 0;}
.				{return ERR;}

%%