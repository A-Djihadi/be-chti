	thumb		
	area  moncode, code, readonly

	import TabSin
	import TabCos
	extern partRe
	extern partIm
		
	export dft
		
dft		proc
	;les arguments : r0 contient k, r1 contient la table du signal. On les empile pour �viter qu'ils soient �cras�s
	push {r0}
	push {r1}
	
	
	 ldr r2, =TabCos ;r2 contient l'@ de TabCos
	 bl partRe;
	 mov r3, r0 ;r3 contient Re(k)
	 smull r2, r3, r3, r3 ;r2 et r3 contient Re(k) au carr�
	 
	 ;on d�pile les deux arguments
	 pop {r1} ;TabSig
	 pop {r0} ;k
	 
	 ;on empile le premier terme de la somme finale
	 push {r3}
	 
	 ldr r2, =TabSin ;r2 contient l'@ de TabSin
	 bl partRe;
	 mov r3, r0 ;r3 contient Im(k)
	  r3, r3
	 
	 
	 

	add 	r3,r2
	
	; On r�cupere le r�sultat
	mov		 r0, r3
	b		fin	
fin
	bx		lr
	endp
	end