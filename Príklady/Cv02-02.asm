start:			;navestie
	scall key	;nacitanie klavesy
	cmi d, 13	;ak je to enter tak to skočí na nový riadok
	jzr novyRiadok
	cmi d,27	;je to esc??
	jzr koniec
	scall dsp	;vypis na konzolu
	jmp start	;ak nie, pokracuj od zaciatku

novyRiadok:	;táto časť bloku presunie kurzor na nový riadok
	mvi d,13 	;do D sa vloží Cr a cez dsp sa vypíše
	scall dsp
	mvi d,10	;do D sa vloží LF a vypíše
	scall dsp
	jmp start

koniec: