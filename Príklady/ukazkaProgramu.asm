start:			;navestie
	scall key	;nacitanie klavesy
	scall dsp	;vypis na konzolu
	cmi d,13	;je to Enter?
	jnz start	;ak nie, pokracuj od zaciatku