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
	jmp start

nula:
	mvi A, 0x03
	out 0,A
	jmp start
jeden:
	mvi A, 0x9F
	out 0,A
	jmp start
dva:
	mvi A, 0x25
	out 0,A
	jmp start
tri:
	mvi A, 0x0D
	out 0,A
	jmp start
stiri:
	mvi A, 0x99
	out 0,A
	jmp start
pet:
	mvi A, 0x49
	out 0,A
	jmp start
sest:
	mvi A, 0x41
	out 0,A
	jmp start
sedem:
	mvi A, 0x1F
	out 0,A
	jmp start

osem:
	mvi A, 0x01
	out 0,A
	jmp start

devet:
	mvi A, 0x09
	out 0,A
	jmp start

koniec:
