	thumb
	area moncode, code,readonly
		
		
	export timer_callback
	include etat.inc
	import etat
	import Son
	import LongueurSon
	import PeriodeSonMicroSec
		
GPIOB_BSRR equ 0x40010C10	
TIM3_CCR3	equ	0x4000043C	; adresse registre PWM

timer_callback proc
	
	; If position < taille
	;	addtion d'une composante continue 
	;	Mise à léchelle pour la résolution
	;	incrémenter position
	;
	;sinon 
	;	émettre un son silence
	;
	ldr 	r0, =etat	;r0=@etat
	ldr		r1,[r0,	#E_POS]	;r1 = position =ro[e_pos]
	ldr		r2,[r0,	#E_TAL]	;r2 = taille =ro[e_tal]
	cmp 	r1,r2	; Test sur r1 et r2
	bmi 	fin 	;Si position > taille saut à fin
	
	
fin	
	
	
	
	bx		lr
	endp
	end