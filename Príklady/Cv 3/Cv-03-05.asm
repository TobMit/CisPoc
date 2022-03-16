start:
	scall key
	cmi d,13
	je koniec
	cmi d, 49
	je jeden
	cmi d, 50
	je dva
	cmi d, 51
	je tri
	cmi d, 52
	je stiri
	cmi d, 53
	je pet
	cmi d, 54
	je sest
	cmi d, 55
	je sedem
	cmi d, 56
	je osem
	cmi d, 57
	je devet
	cmi d, 48
	je nula
	pokracuj:

	scall key
	cmi d, 49
	je sjeden
	cmi d, 50
	je sdva
	cmi d, 51
	je stri
	cmi d, 52
	je sstiri
	cmi d, 53
	je spet
	cmi d, 54
	je ssest
	cmi d, 55
	je ssedem
	cmi d, 56
	je sosem
	cmi d, 57
	je sdevet
	cmi d, 48
	je snula

	jmp start

nula:
	smi 0x03,A
	jmp pokracuj
jeden:
	smi 0x9F,A
	jmp pokracuj
dva:
	smi 0x25,A
	jmp pokracuj
tri:
	smi 0x0D,A
	jmp pokracuj
stiri:
	smi 0x99,A
	jmp pokracuj
pet:
	smi 0x49,A
	jmp pokracuj
sest:
	smi 0x41,A
	jmp pokracuj
sedem:
	smi 0x1F,A
	jmp pokracuj

osem:
	smi 0x01,A
	jmp pokracuj

devet:
	smi 0x09,A
	jmp pokracuj


snula:
	mvi A, 0x03
	out 0,A
	jmp start
sjeden:
	mvi A, 0x9F
	out 0,A
	jmp start
sdva:
	mvi A, 0x25
	out 0,A
	jmp start
stri:
	mvi A, 0x0D
	out 0,A
	jmp start
sstiri:
	mvi A, 0x99
	out 0,A
	jmp start
spet:
	mvi A, 0x49
	out 0,A
	jmp start
ssest:
	mvi A, 0x41
	out 0,A
	jmp start
ssedem:
	mvi A, 0x1F
	out 0,A
	jmp start

sosem:
	mvi A, 0x01
	out 0,A
	jmp start

sdevet:
	mvi A, 0x09
	out 0,A
	jmp start
koniec:
