#ifndef INTERRUPT_H
#define INTERRUPT_H 1

#define sei() __asm__ __volatile__ ("sei" ::: "memory")

// Timer 1 overflow interrupt is
// 5th in the vector table
#define TIM1_OVF_VEC __vector_4

#define ISR(vector) __attribute__ ((signal)) void vector(void)

#endif
