start:			;navestie
	scall key	;nacitanie klavesy
	scall dsp	;vypis na konzolu
	inc c
	cmi c,16	;je to Enter?
	jnz start	;ak nie, pokracuj od zaciatku