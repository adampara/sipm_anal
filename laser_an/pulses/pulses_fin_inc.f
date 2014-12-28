c
c       July 20, 2014, AP
c           add n_puls_nq and puls_q
c
      parameter (Ngate = 10)
      parameter (Max_Pulse = 1000)
      parameter (L_Pulse=200)
      real rlgate(500)
      
      real gate(Ngate)

      real q(Ngate)

      real q_r1(Ngate)
      real q_r2(Ngate)
      real q_r3(Ngate)
      real q_r4(Ngate)


      real t(Max_Pulse)
      real t_bef(Max_Pulse)
      real t_aft(Max_Pulse)

      real chi_peak(Max_Pulse)
      real chi_3tau(Max_Pulse)

      real ampl(Max_Pulse)

      real wid66(Max_Pulse)
      real wid50(Max_Pulse)
      real wid33(Max_Pulse)

      real q_bef(Max_Pulse)
      real pulse(L_Pulse,Max_Pulse)
      real puls_q(Max_pulse)

      integer Nwf
      integer n_puls
      integer n_puls_nq
      integer start

      common/pulses_com/Nwf,rlgate,gate,start,
     +     q,q_r1,q_r2,q_r3,q_r4,
     +     n_puls,n_puls_nq,
     +     t,t_bef,t_aft,
     +     chi_peak,chi_3tau,
     +     ampl,
     +     wid66,wid50,wid33,
     +     q_bef,pulse,puls_q
