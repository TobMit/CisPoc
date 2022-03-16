;Multiplexovane zobrazovanie
;Adresy:
; Prvy register (zobrazovane data): AB0=0
; Druhy register (vyber displeja): AB1=0
;Schema - 3_dva_displeje_multiplex.schx

Start:
	;Zobrazenie znaku na prvom displeji
	mvi	A,11b		;jednotka znamena vypnutie displeja
	out	1,A		;vyslanie jednotiek na anody displejov (register U3)

	mvi	A,0x03		;znak '0'
	out	2,A		;vyslanie znaku na segmenty displejov (register U1)

	mvi	A,10b		;aktivny bude prvy displej (na A1/ posleme 0)
	out	1,A		;vyslanie hodnot na anody displejov (register U3)

	;Zobrazenie znaku na druhom displeji
	mvi	A,11b		; jednotka znamena vypnutie displeja
	out	1,A		;vyslanie jednotiek na anody displejov (register U3)

	mvi	A,0x9F		;znak '1'
	out	2,A		;vyslanie znaku na segmenty displejov (register U1)

	mvi	A,01b		;aktivny bude druhy displej (na A2/ pošleme 0)
	out	1,A		;vyslanie hodnot na anody displejov (register U3)

	jmp	Start		;opakovanie donekonecna
