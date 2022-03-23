;Program na citanie stavu klavesnice
;Schema: 5_klavesnica.schx

start:

	inn	a,1110b		;citanie stavu riadku 1

	inn	b,1101b		;citanie riadku 2

	inn	c,1011b		;citanie riadku 3

	inn	d,0111b		;citanie riadku 4

	jmp	start
