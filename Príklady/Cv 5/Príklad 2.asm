;Program na citanie stavu klavesnice
;Schema: 5_klavesnica.schx

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


start:
	

	inn	a,11110b		;citanie stavu riadku 1
	mvi d, 48 		;cislo ktore sa bude zobrazovat
	ani a , 00001111b	;vyenduje sa register na pozadovanu dlzku, tie prve 4b maju nahodne hodnoty a preto ich 0000 odstranime
	cmi a, 	1111b 		;skontrolovanie ci bolo slacene, v mojom pripade nestlacene tlacidlo
	jne NajdiKlavesuPrvyRiadok 	;ak nebolo stlacene tlacidlo, tak program pokracuje dalej ak bolo tak skace na prislusne navestie

	L1:
	mvi d, 52		;nastavenie acii codu na vhody zciatok riadku, podla tohto kodu sa vypisuje na konzolu
	inn	a,11101b		;citanie riadku 2
	ani a , 00001111b  
	cmi a, 	1111b ;skontrolovanie správne stlačeného dlačidla
	jne NajdiKlavesuDruhyRiadok
	L2:
	mvi d, 56
	inn	a,11011b		;citanie riadku 3
	ani a , 00001111b
	cmi a, 	1111b ;skontrolovanie správne stlačeného dlačidla
	jne NajdiKlavesuTretiRiadok
	L3:

	mvi d, 60
	inn	a,10111b		;citanie riadku 4
	ani a , 00001111b
	cmi a, 	1111b ;skontrolovanie správne stlačeného dlačidla
	jne NajdiKlavesuStvrtyRiadok
	L4:


	jmp	start


OpakovatkoPrvyriadok:
	inn a,1110b		;Opakovatko bude opakovat do vtedy kým je stlačené tlačilo aj len pri rychlom kliknuti na tlacidlo
		;v realite ten program ho zaznamena n krat
	ani a , 00001111b	; upravi sa register na pozadovany tvar ako vyssie
	cmp a, 	b		; v B je ulozena poloha stlpca ktora je zmacknuta, tu sa overuje ci je stale to iste tlacidlo zmacknute
	je OpakovatkoPrvyriadok ;ak je stlačené tak sa opakuje Opakovatko a ked nie skace na navestie L1
	jmp L1
OpakovatkoDruhy:
	inn	a,1101b		;L2 bude do vtedy kým je stlačené tlačilo
	ani a , 00001111b
	cmp a, 	b
	je OpakovatkoDruhy  ;ak je stlačené skočí sa na L2 ak nie program pokračuje v starte
	jmp L2
OpakovatkoTreti:
	inn	a,1011b		;L2 bude do vtedy kým je stlačené tlačilo
	ani a , 00001111b
	cmp a, 	b
	je OpakovatkoTreti  ;ak je stlačené skočí sa na L2 ak nie program pokračuje v starte
	jmp L3
OpakovatkoStvrty:
	inn	a,0111b		;L2 bude do vtedy kým je stlačené tlačilo
	ani a , 00001111b
	cmp a, 	b
	je OpakovatkoStvrty  ;ak je stlačené skočí sa na L2 ak nie program pokračuje v starte
	jmp L4


NajdiKlavesuPrvyRiadok:
	mmr b, c  	;z pamete sa vyberie prislusna hodnota na hoverenie (to je ten stlpec 0111b} je to ulozene hore v pameti
	;na zciatku ciklu je c nulove ale postupne dalej a dalej sa zvisuje
	cmp a, b  	;porovnava sa ci je register A (realne stlacene tlacidlo) a B (to kotore overujeme) su rovnake
	je PokracujPrvy ; ak ano tak sa skoci na navestie PokracujPrvy
	inc c		;ak nie tak sa zvisi C o 1 to znamena pri dalsom opakovany budeme vyberat dalsi prvok z pamete
	inc d		;zvisi sa D (tu je acii hodnota cisla ktora sa vypisuje) o jeden
	;pretoze cisla na klavesnici stupaju o jeden tak mne pri overovani staci vzdy zvisit aj acii kod o jeden
	; cize ak som zmackol 3 klavesu v poradi tak kym to cyklus odhali tak prejde 3 krat a to aj nastavi aci na hodnotu 3
	jne NajdiKlavesuPrvyRiadok 	;ak pri cmp a,b neprislo na zhodu cyklus sa zopakuje

	
	PokracujPrvy:
	sbi d,'0'		;prerobenie znaku na cislo
	adi d, 4		;data su ulozene az od 4 
	mmr c, d
	out 01111b,c		 	;vypise na obrazovku
	xor c,c 		 ;vycistenie si indexi
	jmp OpakovatkoPrvyriadok ; skoci sa na opakovatko 
		;lebo tento progam prebehne len v ram ci jedneho kliku viac krat a na konzolu by vypisalo n cisel

NajdiKlavesuDruhyRiadok:
	mmr b, c
	cmp a, b
	je PokracujDruhy
	inc c
	inc d
	jne NajdiKlavesuDruhyRiadok

	
	PokracujDruhy:
	sbi d,'0'
	adi d, 4
	mmr c,d
	out 01111b,c
	xor c,c ;vycistenie si indexi
	jmp OpakovatkoDruhy

NajdiKlavesuTretiRiadok:
	mmr b, c
	cmp a, b
	je PokracujTreti
	inc c
	inc d
	jne NajdiKlavesuTretiRiadok

	
	PokracujTreti:
	sbi d,'0'
	adi d, 4
	mmr c, d
	out 01111b,c
	xor c,c ;vycistenie si indexi
	jmp OpakovatkoTreti

NajdiKlavesuStvrtyRiadok:
	mmr b, c
	cmp a, b
	je PokracujStvrty
	inc c
	inc d
	jne NajdiKlavesuStvrtyRiadok

	
	PokracujStvrty:
	sbi d,'0'
	adi d, 4
	mmr c, d
	out 01111b,c
	xor c,c ;vycistenie si indexi
	jmp OpakovatkoStvrty
