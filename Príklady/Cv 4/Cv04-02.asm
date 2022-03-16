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



start:
	scall key
	inc b
	cmi b , 10
	jne skok
	xor b,b
	inc c


	skok:
	jmp Vypis
	;mvi	d,49		;znak '3' 
	;czr	Vypis		;1. displej

	;mvi	d,49		;znak '4'
	;czr	Vypis		;2. displej

	jmp start


Vypis:
	mov d, c
	;sbi d,'0' ;prerobenie znaku na číslo
	mmr a,d;výber konštanty z tabuľky
	out 2,a;zobrazenie znaku na displeji
	jmp VypisDruhaObr
VypisDruhaObr:
	mov d, b
	;sbi d,'0' ;prerobenie znaku na číslo
	mmr a,d;výber konštanty z tabuľky
	out 1,a;zobrazenie znaku na displeji
	ret

Koniec: 
