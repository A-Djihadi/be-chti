#include "gassp72.h"
#include "etat.h"
#define Periode_en_Tck PeriodeSonMicroSec*72 //6552 // T/To vaut 91 u
#define Periode_PWM_en_Tck 720

extern short Son;
extern int LongueurSon;
extern int PeriodeSonMicroSec;

void timer_callback(void);

type_etat etat;


int main(void)
{
	//initialisation de notre son par la variable etat;
etat.taille=LongueurSon;
etat.son=&Son;
etat.Tech_en_Tck = PeriodeSonMicroSec;
	// activation de la PLL qui multiplie la fr�quence du quartz par 9
CLOCK_Configure();
	// config port PB0 pour �tre utilis� par TIM3-CH3
GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);
// config TIM3-CH3 en mode PWM
etat.resolution = PWM_Init_ff(TIM3,3,Periode_PWM_en_Tck);	
	
// initialisation du timer 4
// Periode_en_Tck doit fournir la dur�e entre interruptions,
// exprim�e en p�riodes Tck de l'horloge principale du STM32 (72 MHz)
Timer_1234_Init_ff( TIM4, Periode_en_Tck ) ;
// enregistrement de la fonction de traitement de l'interruption timer
// ici le 2 est la priorit�, timer_callback est l'adresse de cette fonction, a cr��r en asm,
// cette fonction doit �tre conforme � l'AAPCS
Active_IT_Debordement_Timer( TIM4, 2, timer_callback );
// lancement du timer
Run_Timer( TIM4 );
// lancement du d'un timer pour notre son
Run_Timer(TIM3);

	while	(1)
		{
	}
}
