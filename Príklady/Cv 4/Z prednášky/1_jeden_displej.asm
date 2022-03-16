;Zobrazenie znaku na jednom displeji
;Schema: 1_jeden_displej.schx

	mvi	a,0x03		;kod znaku
	out	0,a		;vyslanie znaku
