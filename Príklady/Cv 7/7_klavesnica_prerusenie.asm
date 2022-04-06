;Vyvolanie preruseni od celej klavesnice
;Vsetky tlacidla vyvolaju to iste prerusenie
;Treba nastavit: Nastavenia -> INT-zmena
;Schema: 7_klavesnica_prerusenie.schx

;Hlavny program
	mvi	a,0
	out	0,a		;aktivovanie vsetkych riadkov (register U1)
	eit			;povolenie preruseni
start:	
	jmp	start		;hlavny program – nekonecna slucka

;Obsluha prerusenia
int00:	mvi	a,0111b		;riadok 1
	out	0,a		;zapis do registra U1
	inn	b,0		;nacitanie stavu stlpcov (register U2)
				;vyhodnotenie stlaceneho tlacidla

	mvi	d,'P'		;indikacia vyvolania prerusenia
	scall	dsp
	;kontrola dalsich riadkov

;koniec prerusenia	
	mvi	a,0
	out	0,a		;aktivovanie vsetkých riadkov
	eit			;povolenie dalsieho prerusenia
	ret			;navrat z obsluhy prerusenia do hlavneho programu
