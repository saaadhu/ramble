start : paragraphs;
paragraphs
	: paragraph
	| paragraph LINEBREAK LINEBREAK paragraphs
	;
paragraph
	: sentence
	| sentence paragraph
	;
sentence
	: subject verb object PERIOD
	;
subject 
	: CAT 
	| DOG 
	| PONY
	;
verb
	: EATS
	| GULPS
	| SWALLOWS
	;
object
	: HAY
	| FOOD
	| MILK
	;
