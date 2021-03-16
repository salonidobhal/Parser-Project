%{
    #include<stdio.h>
	#include<stdlib.h>
	int yylex();
	int yyerror();
%}

%start START
%token START_OL_TAG START_UL_TAG ATTRIBUTE ATTRIBUTE_VAL TEXT OL_END_TAG UL_END_TAG START_LI_TAG LI_END_TAG NEWLINE


%%
/*Grammar*/
START		:ORDERED {printf("Syntax is valid\n"); return 0;}
			|UNORDERED {printf("Syntax is valid\n"); return 0;}
			;
ORDERED		:START_OL_TAG ATT '>' LIST_TAG OL_END_TAG
			;        
UNORDERED	:START_UL_TAG ATT '>' LIST_TAG UL_END_TAG
			;
LIST_TAG	:LIST_TAG START_LI_TAG ATT '>' BODY LI_END_TAG 
			|{}
			;
BODY		:BODY TEXT
			|{}
			|ORDERED
			|UNORDERED
			;
ATT			:ATT ATTRIBUTE ATTRIBUTE_VAL
			|{}
			;

%%

int yyerror() {
  printf("Syntax is invalid\n");
  return 1;
}

int main() 
{
	printf("\nHTML lists with nesting\n");
	printf("Enter HTML code: ");
	yyparse();
	return 0;
}