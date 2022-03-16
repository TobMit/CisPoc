start:			;navestie
	scall key	;nacitanie klavesy
	cmi d, 13	;ak je to enter vypise zasobnik
	jzr VypisRegister
	cmi d,27	;je to esc??
	jzr Koniec
	inc c
	pus D		;push do zasobnika
	jmp start	;ak nie, pokracuj od zaciatku

VypisRegister:	;táto časť bloku presunie kurzor na nový riadok
	pop d
	scall dsp
	dec c
	cmi c,0
	jnz VypisRegister

	jmp Koniec

Koniec: