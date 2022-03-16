start:			;navestie
	scall key	;nacitanie klavesy
	cmi d,13	;je to Enter?
	je koniec
	sbi D, 32
	scall dsp	;vypis na konzolu
	jmp start	;ak nie, pokracuj od zaciatku
koniec: