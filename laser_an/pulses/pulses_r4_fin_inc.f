      parameter (Ngate = 10)
      parameter (Max_Pulse = 100)

      real*4 rlgate(500)
      
      real*4 gate(Ngate)

      real*4 q(Ngate)

      real*4 q_r1(Ngate)
      real*4 q_r2(Ngate)
      real*4 q_r3(Ngate)
      real*4 q_r4(Ngate)


      real*4 t(Max_Pulse)
      real*4 t_bef(Max_Pulse)
      real*4 t_aft(Max_Pulse)

      real*4 chi_peak(Max_Pulse)
      real*4 chi_3tau(Max_Pulse)

      real*4 ampl(Max_Pulse)

      real*4 wid66(Max_Pulse)
      real*4 wid50(Max_Pulse)
      real*4 wid33(Max_Pulse)

      real*4 q_bef(Max_Pulse)
      real*4 pulse(200,Max_Pulse)
      real*4 puls_q(Max_pulse)

      integer Nwf
      integer n_puls
      integer n_puls_nq
      integer start

      common/pulses_com/Nwf,rlgate,gate,start,
     +     q,q_r1,q_r2,q_r3,q_r4,
     +     N_puls,n_puls_nq,
     +     t,t_bef,t_aft,
     +     chi_peak,chi_3tau,
     +     ampl,
     +     wid66,wid50,wid33,
     +     q_bef,pulse,puls_q
