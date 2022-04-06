;Vyvolanie preruseni od celej klavesnice
;Kazdy stlpec vyvola ine prerusenie
;Treba nastavit: Nastavenia -> INT-zmena
;Schema: 7_klavesnica_prerusenie2.schx


	mvi	a,0
	out	0,a		;aktivovanie vsetkych riadkov
	eit			;povolenie preruseni

;Hlavny program - nekonecna slucka, ktora nic nerobi
start:

	jmp	start


;Obsluha prerusenia od prveho stlpca
int07:
	mvi	d,'0'
	scall	dsp
	eit		;opetovne povolenie preruseni
	ret

;Obsluha prerusenia od druheho stlpca
int11:
	mvi	d,'1'
	scall	dsp
	eit		;opetovne povolenie preruseni
	ret

;Obsluha prerusenia od tretieho stlpca
int13:
	mvi	d,'2'
	scall	dsp
	eit		;opetovne povolenie preruseni
	ret

;Obsluha prerusenia od stvrteho stlpca
int14:
	mvi	d,'3'
	scall	dsp
	eit		;opetovne povolenie preruseni
	ret
