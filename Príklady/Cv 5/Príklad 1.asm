;Program na citanie stavu klavesnice
;Schema: 5_klavesnica.schx

start:

	inn	a,1110b		;citanie stavu riadku 1
	ani a , 00001111b ;and aby som mal správne nastavený register
	cmi a, 	0111b ;skontrolovanie správne stlačeného dlačidla
	jne L1	
	mvi d, 48 ;výpis na obrazovku
	scall dsp
	jmp L2 ;program je moc rýchly preto sa skáče na L2
	L1:

	inn	b,1101b		;citanie riadku 2

	inn	c,1011b		;citanie riadku 3

	inn	d,0111b		;citanie riadku 4

	jmp	start


L2:
	inn	a,1110b		;L2 bude do vtedy kým je stlačené tlačilo
	ani a , 00001111b
	cmi a, 	0111b
	je L2  ;ak je stlačené skočí sa na L2 ak nie program pokračuje v starte
	jmp start
