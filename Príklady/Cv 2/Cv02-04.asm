start:			;navestie
	scall key	;nacitanie klavesy
	cmi d, 13	;ak je to enter vypise zasobnik
	jzr VypisRegister
	cmi d,27	;je to esc??
	jzr Koniec
	inc c
	str a,D
	inc a
	jmp start	;ak nie, pokracuj od zaciatku

VypisRegister:	;táto časť bloku presunie kurzor na nový riadok
	xor a,a
	uprava:
	ldr d,a
	dec c
	inc a
	scall dsp
	cmi c,0
	jnz uprava

	jmp Koniec

Koniec:
