;Ukážka práce s konštantami
;Schéma: 1_jeden_displej.schx

;Tabuľka znakov - číslice
BYTE		0x03		;znak '0'
BYTE		0x9F		;znak '1'
BYTE		0x25		;znak '2'

Start:
	scall	key		;čakanie na klávesu
	cmi	d,'0' 		;je to znak '0'?
	czr	Vypis

	cmi	d,'1' 		;je to znak '1'?
	czr	Vypis

	cmi	d,'2' 		;je to znak '2'?
	czr	Vypis

	jmp	Start		;nebola stlačená požadovaná klávesa

;Výpis znaku na displej (v registri D je kód znaku)
;Najprv musíme prerobiť znak na číslo – ak od znaku '1' (ASCII kód 49) odčítame znak '0' 
;(ASCII kód 48), dostaneme číslo 1. To použijeme na výber konštanty z tabuľky.
Vypis:
	sbi	d,'0' 		;prerobenie znaku na číslo
	mmr	a,d		;výber konštanty z tabuľky
	out	0,a		;zobrazenie znaku na displeji
	ret			;návrat z podprogramu
