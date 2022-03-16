;Zobrazenie znakov na dvoch displejoch
;Prvy displej: AB0=0
;Druhy displej: AB1=0
;Schema - 2_dva_displeje_s_adresou.schx

	mvi	a,0x0d		;znak '3' 
	out	2,a		;1. displej

	mvi	a,0x99		;znak '4'
	out	1,a		;2. displej
