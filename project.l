%{
	#include "y.tab.h"
%}

%x olAttributeList ulAttributeList attributeListItem

attributeValue      (\"([^\"]*)\")
whiteSpace          ([ \t]*)
olTag				"ol"
ulTag				"ul"
liTag				"li"
olAttList			"type"|"start"|"reversed"|"style"
ulAttList			"type"|"style"
AttListItem			"value"

%%
"<"{whiteSpace}{olTag}		{	
								BEGIN(olAttributeList);
								return START_OL_TAG;
							}
"<"{whiteSpace}{ulTag}		{	
								BEGIN(ulAttributeList);
								return START_UL_TAG;
							}
"<"{whiteSpace}{liTag}		{	
								BEGIN(attributeListItem);
								return START_LI_TAG;
							}
(">")						{	
								return yytext[0];
							}
([a-zA-Z0-9 ])*				{
								return TEXT;
							}
("</ol>")					{
								return OL_END_TAG;
							}
("</ul>")					{
								return UL_END_TAG;
							}

("</li>")					{
								return LI_END_TAG;
							}
<olAttributeList>{			
	{olAttList}{whiteSpace}[=]	{	
									return ATTRIBUTE;	
								}
	{attributeValue} 			{	
									return ATTRIBUTE_VAL;
								}
	(">")						{	
									BEGIN(INITIAL);
									return yytext[0];
								}
}
<ulAttributeList>{			
	{ulAttList}{whiteSpace}[=]	{	
									return ATTRIBUTE;	
								}
	{attributeValue} 			{	
									return ATTRIBUTE_VAL;
								}
	(">")						{	
									BEGIN(INITIAL);
									return yytext[0];
								}
}

<attributeListItem>{
	{AttListItem}{whiteSpace}[=]	{	
										return ATTRIBUTE;	
									}
	{attributeValue} 			    {	
										return ATTRIBUTE_VAL;
									}	
	(">")							{	
										BEGIN(INITIAL);
										return yytext[0];
									}
}

. 							{return yytext[0];}
"\n"						{return NEWLINE;}
%%

int yywrap() 
{
	return 1;
}