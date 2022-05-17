;overovanie zdmcknutia jednotlivych klaves
BYTE 0111b
BYTE 1011b
BYTE 1101b
BYTE 1110b

;zobrazenie na obrazovke
BYTE	0x03
BYTE	0x9F
BYTE	0x25
BYTE	0x0D
BYTE	0x99
BYTE	0x49
BYTE	0x41
BYTE	0x1F
BYTE	0x01
BYTE	0x09
BYTE    00010001b ; A
BYTE	0x01  ;B
BYTE 	01100011b ;C
BYTE	0x03 ; D
BYTE	01100001b
BYTE	01110001b	;F


; D - pouziva sa ako zobrazovane cisllo

mvi D, 0

Start:
	mvi	C, 100
	ldr	D, C
	;Zobrazenie znaku na prvom displeji
	mvi	A,1111b		;jednotka znamena vypnutie displeja
	out	111101b,A		;vyslanie jednotiek na anody displejov (register U3)

	mov	B, D
	adi	B, 60
	ldr	A, B
	adi	A, 4
	mmr	c, A
	out	111110b,C		;vyslanie znaku na segmenty displejov (register U1)

	mvi	A,1110b		;aktivny bude prvy displej (na A1/ posleme 0)
	out	111101b,A		;vyslanie hodnot na anody displejov (register U3)

	;Zobrazenie znaku na druhom displeji
	mvi	A,1111b		; jednotka znamena vypnutie displeja
	out	111101b,A		;vyslanie jednotiek na anody displejov (register U3)

	mov	B, D
	adi	B, 40
	ldr	A, B
	adi	A, 4
	mmr	c, A
	out	111110b,C		;vyslanie znaku na segmenty displejov (register U1)

	mvi	A,1101b		;aktivny bude druhy displej (na A2/ pošleme 0)
	out	111101b,A		;vyslanie hodnot na anody displejov (register U3)

	;Zobrayenie znaku na tretom displeji
	mvi	A,1111b		; jednotka znamena vypnutie displeja
	out	1,A		;vyslanie jednotiek na anody displejov (register U3)

	mov	B, D
	adi	B, 20
	ldr	A, B
	adi	A, 4
	mmr	c, A
	out	111110b,C		;vyslanie znaku na segmenty displejov (register U1)

	mvi	A,1011b		;aktivny bude druhy displej (na A2/ pošleme 0)
	out	111101b,A		;vyslanie hodnot na anody displejov (register U3)

	;Zobrayenie znaku na stvrtom displeji
	mvi	A,1111b		; jednotka znamena vypnutie displeja
	out	111101b,A		;vyslanie jednotiek na anody displejov (register U3)

	mov	B, D
	ldr	A, B
	adi	A, 4
	mmr	c, A
	out	111110b,C		;vyslanie znaku na segmenty displejov (register U1)
	xor c, c

	mvi	A,0111b		;aktivny bude druhy displej (na A2/ pošleme 0)
	out	111101b,A		;vyslanie hodnot na anody displejov (register U3)

	
	;Klavesi -- overovanie klaves

	inn	a,111011b		;citanie stavu riadku 1
	mvi 	d, 0			;cislo ktore sa bude zobrazovat
	ani 	a, 00001111b		;vyenduje sa register na pozadovanu dlzku, tie prve 4b maju nahodne hodnoty a preto ich 0000 odstranime
	cmi 	a, 1111b 		;skontrolovanie ci bolo slacene, v mojom pripade nestlacene tlacidlo
	jne NajdiKlavesuPrvyRiadok 	;ak nebolo stlacene tlacidlo, tak program pokracuje dalej ak bolo tak skace na prislusne navestie

	L1:
	mvi 	d, 4			;nastavenie acii codu na vhody zciatok riadku, podla tohto kodu sa vypisuje na konzolu
	inn	a,110111b		;citanie riadku 2
	ani 	a, 00001111b  
	cmi 	a, 1111b ;skontrolovanie správne stlačeného dlačidla
	jne NajdiKlavesuDruhyRiadok

	L2:
	mvi 	d, 8
	inn	a, 101111b		;citanie riadku 3
	ani 	a, 00001111b
	cmi 	a, 1111b ;skontrolovanie správne stlačeného dlačidla
	jne NajdiKlavesuTretiRiadok
	L3:

	mvi 	d, 12
	inn	a, 011111b		;citanie riadku 4
	ani 	a, 00001111b
	cmi 	a, 1111b ;skontrolovanie správne stlačeného dlačidla
	jne NajdiKlavesuStvrtyRiadok
	L4:

	jmp Start		;opakovanie donekonecna

OpakovatkoPrvyriadok:
	inn 	a, 111011b		;Opakovatko bude opakovat do vtedy kým je stlačené tlačilo aj len pri rychlom kliknuti na tlacidlo
		;v realite ten program ho zaznamena n krat
	ani 	a, 00001111b	; upravi sa register na pozadovany tvar ako vyssie
	cmp 	a, b		; v B je ulozena poloha stlpca ktora je zmacknuta, tu sa overuje ci je stale to iste tlacidlo zmacknute
	je OpakovatkoPrvyriadok ;ak je stlačené tak sa opakuje Opakovatko a ked nie skace na navestie L1
	jmp Start
OpakovatkoDruhy:
	inn	a,110111b		;L2 bude do vtedy kým je stlačené tlačilo
	ani 	a, 00001111b
	cmp 	a, b
	je OpakovatkoDruhy  ;ak je stlačené skočí sa na L2 ak nie program pokračuje v starte
	jmp L2
OpakovatkoTreti:
	inn	a, 101111b		;L2 bude do vtedy kým je stlačené tlačilo
	ani 	a, 00001111b
	cmp 	a, b
	je OpakovatkoTreti  ;ak je stlačené skočí sa na L2 ak nie program pokračuje v starte
	jmp L3
OpakovatkoStvrty:
	inn	a, 011111b		;L2 bude do vtedy kým je stlačené tlačilo
	ani 	a, 00001111b
	cmp 	a, b
	je OpakovatkoStvrty  ;ak je stlačené skočí sa na L2 ak nie program pokračuje v starte
	jmp L4


NajdiKlavesuPrvyRiadok:
	mmr 	b, c  	;z pamete sa vyberie prislusna hodnota na hoverenie (to je ten stlpec 0111b} je to ulozene hore v pameti
	;na zciatku ciklu je c nulove ale postupne dalej a dalej sa zvisuje
	cmp 	a, b  	;porovnava sa ci je register A (realne stlacene tlacidlo) a B (to kotore overujeme) su rovnake
	je KoniecLoopPrvy ; ak ano tak sa skoci na navestie PokracujPrvy
	inc 	c		;ak nie tak sa zvisi C o 1 to znamena pri dalsom opakovany budeme vyberat dalsi prvok z pamete
	inc 	d		;zvisi sa D (tu je acii hodnota cisla ktora sa vypisuje) o jeden
	;pretoze cisla na klavesnici stupaju o jeden tak mne pri overovani staci vzdy zvisit aj acii kod o jeden
	; cize ak som zmackol 3 klavesu v poradi tak kym to cyklus odhali tak prejde 3 krat a to aj nastavi aci na hodnotu 3
	jne NajdiKlavesuPrvyRiadok 	;ak pri cmp a,b neprislo na zhodu cyklus sa zopakuje

	KoniecLoopPrvy:
	jmp PripocitajRiadok1
	
	PokracujPrvy:
	pop 	C
	pop	A
	mvi	C, 100
	str	C, D
	xor 	C, C
	jmp OpakovatkoPrvyriadok ; skoci sa na opakovatko 
		;lebo tento progam prebehne len v ram ci jedneho kliku viac krat a na konzolu by vypisalo n cisel

NajdiKlavesuDruhyRiadok:
	mmr 	b, c
	cmp 	a, b
	je KoniecLoopDruhy
	inc 	c
	inc 	d
	jne NajdiKlavesuDruhyRiadok

	KoniecLoopDruhy:
	jmp PripocitajRiadok2
	
	PokracujDruhy:
	pop 	C
	pop	A
	mvi	C, 100
	str	C, D
	xor 	C, C
	jmp OpakovatkoDruhy

NajdiKlavesuTretiRiadok:
	mmr 	b, c
	cmp 	a, b
	je KoniecLoopTreti
	inc 	c
	inc 	d
	jne NajdiKlavesuTretiRiadok

	KoniecLoopTreti:
	jmp PripocitajRiadok3
	
	PokracujTreti:
	pop 	C
	pop	A
	mvi	C, 100
	str	C, D
	xor 	C, C
	jmp OpakovatkoTreti

NajdiKlavesuStvrtyRiadok:
	mmr 	b, c
	cmp 	a, b
	je KoniecLoopStvrty
	inc 	c
	inc 	d
	jne NajdiKlavesuStvrtyRiadok

	KoniecLoopStvrty:
	jmp PripocitajRiadok4
	
	PokracujStvrty:
	pop 	C
	pop	A
	mvi	C, 100
	str	C, D
	xor 	C, C
	jmp OpakovatkoStvrty


PripocitajRiadok1:
	pus	A
	pus	C

	mov 	A, D
	ldr	C, A ;ziskame z RAM hodnoto jednotiek
	inc 	C ; zvysime jednotky
	str	A,C ; ulozime jednotky
	cmi 	C, 10	;porovnam ci jedontky presiahli 9 ak ano pokracujem podobnym sposobm s desiadkami
	jne PokracujPrvy

	mvi	C, 0 ; vynulujem jednotky
	str	A, C ; ulozim jednotky
	adi	A, 20 ; premapujeme na desiatky
	ldr	C, A ; nacitam desiatky
	inc 	C
	str	A,C ; ulozime desiadky
	cmi 	C, 10	;porovnam ci desiadky presiahli 9 ak ano pokracujem podobnym sposobm s desiadkami
	jne PokracujPrvy

	mvi	C, 0 ; vynulujem desiadky
	str	A, C ; ulozim desiadky
	adi	A, 20 ; premapujeme na stovky
	ldr	C, A ; nacitam stovky
	inc 	C
	str	A,C ; ulozime stovky
	cmi 	C, 10	;porovnam ci stovky presiahli 9 ak ano pokracujem podobnym sposobm s desiadkami
	jne PokracujPrvy

	mvi	C, 0 ; vynulujem stovky
	str	A, C ; ulozim stovky
	adi	A, 20 ; premapujeme na tisicky
	ldr	C, A ; nacitam tisicky
	inc 	C
	str	A,C ; ulozime tisicky
	cmi 	C, 10	;porovnam ci desiadky presiahli 9 ak ano pokracujem podobnym sposobm s desiadkami
	jne Koniec


PripocitajRiadok2:
	pus	A
	pus	C

	mov 	A, D
	ldr	C, A ;ziskame z RAM hodnoto jednotiek
	inc 	C ; zvysime jednotky
	str	A,C ; ulozime jednotky
	cmi 	C, 10	;porovnam ci jedontky presiahli 9 ak ano pokracujem podobnym sposobm s desiadkami
	jne PokracujDruhy

	mvi	C, 0 ; vynulujem jednotky
	str	A, C ; ulozim jednotky
	adi	A, 20 ; premapujeme na desiatky
	ldr	C, A ; nacitam desiatky
	inc 	C
	str	A,C ; ulozime desiadky
	cmi 	C, 10	;porovnam ci desiadky presiahli 9 ak ano pokracujem podobnym sposobm s desiadkami
	jne PokracujDruhy

	mvi	C, 0 ; vynulujem desiadky
	str	A, C ; ulozim desiadky
	adi	A, 20 ; premapujeme na stovky
	ldr	C, A ; nacitam stovky
	inc 	C
	str	A,C ; ulozime stovky
	cmi 	C, 10	;porovnam ci stovky presiahli 9 ak ano pokracujem podobnym sposobm s desiadkami
	jne PokracujDruhy

	mvi	C, 0 ; vynulujem stovky
	str	A, C ; ulozim stovky
	adi	A, 20 ; premapujeme na tisicky
	ldr	C, A ; nacitam tisicky
	inc 	C
	str	A,C ; ulozime tisicky
	cmi 	C, 10	;porovnam ci desiadky presiahli 9 ak ano pokracujem podobnym sposobm s desiadkami
	jne Koniec

PripocitajRiadok3:
	pus	A
	pus	C

	mov 	A, D
	ldr	C, A ;ziskame z RAM hodnoto jednotiek
	inc 	C ; zvysime jednotky
	str	A,C ; ulozime jednotky
	cmi 	C, 10	;porovnam ci jedontky presiahli 9 ak ano pokracujem podobnym sposobm s desiadkami
	jne PokracujTreti

	mvi	C, 0 ; vynulujem jednotky
	str	A, C ; ulozim jednotky
	adi	A, 20 ; premapujeme na desiatky
	ldr	C, A ; nacitam desiatky
	inc 	C
	str	A,C ; ulozime desiadky
	cmi 	C, 10	;porovnam ci desiadky presiahli 9 ak ano pokracujem podobnym sposobm s desiadkami
	jne PokracujTreti

	mvi	C, 0 ; vynulujem desiadky
	str	A, C ; ulozim desiadky
	adi	A, 20 ; premapujeme na stovky
	ldr	C, A ; nacitam stovky
	inc 	C
	str	A,C ; ulozime stovky
	cmi 	C, 10	;porovnam ci stovky presiahli 9 ak ano pokracujem podobnym sposobm s desiadkami
	jne PokracujTreti

	mvi	C, 0 ; vynulujem stovky
	str	A, C ; ulozim stovky
	adi	A, 20 ; premapujeme na tisicky
	ldr	C, A ; nacitam tisicky
	inc 	C
	str	A,C ; ulozime tisicky
	cmi 	C, 10	;porovnam ci desiadky presiahli 9 ak ano pokracujem podobnym sposobm s desiadkami
	jne Koniec

PripocitajRiadok4:
	pus	A
	pus	C

	mov 	A, D
	ldr	C, A ;ziskame z RAM hodnoto jednotiek
	inc 	C ; zvysime jednotky
	str	A,C ; ulozime jednotky
	cmi 	C, 10	;porovnam ci jedontky presiahli 9 ak ano pokracujem podobnym sposobm s desiadkami
	jne PokracujStvrty

	mvi	C, 0 ; vynulujem jednotky
	str	A, C ; ulozim jednotky
	adi	A, 20 ; premapujeme na desiatky
	ldr	C, A ; nacitam desiatky
	inc 	C
	str	A,C ; ulozime desiadky
	cmi 	C, 10	;porovnam ci desiadky presiahli 9 ak ano pokracujem podobnym sposobm s desiadkami
	jne PokracujStvrty

	mvi	C, 0 ; vynulujem desiadky
	str	A, C ; ulozim desiadky
	adi	A, 20 ; premapujeme na stovky
	ldr	C, A ; nacitam stovky
	inc 	C
	str	A,C ; ulozime stovky
	cmi 	C, 10	;porovnam ci stovky presiahli 9 ak ano pokracujem podobnym sposobm s desiadkami
	jne PokracujStvrty

	mvi	C, 0 ; vynulujem stovky
	str	A, C ; ulozim stovky
	adi	A, 20 ; premapujeme na tisicky
	ldr	C, A ; nacitam tisicky
	inc 	C
	str	A,C ; ulozime tisicky
	cmi 	C, 10	;porovnam ci desiadky presiahli 9 ak ano pokracujem podobnym sposobm s desiadkami
	jne Koniec

Koniec: 

	
