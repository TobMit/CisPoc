;Multiplexovane zobrazovanie
;Adresy:
; Prvy register (zobrazovane data): AB0=0
; Druhy register (vyber displeja): AB1=0
;Schema - 3_dva_displeje_multiplex.schx

Start:
	;Zobrazenie znaku na prvom displeji
	mvi	A,1111b		;jednotka znamena vypnutie displeja
	out	1,A		;vyslanie jednotiek na anody displejov (register U3)

	mvi	A,00010001b	;znak 'A'
	out	2,A		;vyslanie znaku na segmenty displejov (register U1)

	mvi	A,1110b		;aktivny bude prvy displej (na A1/ posleme 0)
	out	1,A		;vyslanie hodnot na anody displejov (register U3)

	;Zobrazenie znaku na druhom displeji
	mvi	A,1111b		; jednotka znamena vypnutie displeja
	out	1,A		;vyslanie jednotiek na anody displejov (register U3)

	mvi	A,10010001b	;znak 'H'
	out	2,A		;vyslanie znaku na segmenty displejov (register U1)

	mvi	A,1101b		;aktivny bude druhy displej (na A2/ pošleme 0)
	out	1,A		;vyslanie hodnot na anody displejov (register U3)

	;Zobrayenie znaku na tretom displeji
	mvi	A,1111b		; jednotka znamena vypnutie displeja
	out	1,A		;vyslanie jednotiek na anody displejov (register U3)

	mvi	A,00000011b	;znak 'O'
	out	2,A		;vyslanie znaku na segmenty displejov (register U1)

	mvi	A,1011b		;aktivny bude druhy displej (na A2/ pošleme 0)
	out	1,A		;vyslanie hodnot na anody displejov (register U3)

	;Zobrayenie znaku na stvrtom displeji
	mvi	A,1111b		; jednotka znamena vypnutie displeja
	out	1,A		;vyslanie jednotiek na anody displejov (register U3)

	mvi	A,00000111b		;znak '1'
	out	2,A		;vyslanie znaku na segmenty displejov (register U1)

	mvi	A,0111b		;aktivny bude druhy displej (na A2/ pošleme 0)
	out	1,A		;vyslanie hodnot na anody displejov (register U3)
	jmp	Start		;opakovanie donekonecna
