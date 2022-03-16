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
	smi 0x03,A ;nastavi vystup AB na prvy parameter, to co je ako druhy parameter, tak to ma teraz netrapi
	jmp start
jeden:
	smi 0x9F,A
	jmp start
dva:
	smi 0x25,A
	jmp start
tri:
	smi 0x0D,A
	jmp start
stiri:
	smi 0x99,A
	jmp start
pet:
	smi 0x49,A
	jmp start
sest:
	smi 0x41,A
	jmp start
sedem:
	smi 0x1F,A
	jmp start

osem:
	smi 0x01,A
	jmp start

devet:

	smi 0x09,A
	jmp start

koniec:
