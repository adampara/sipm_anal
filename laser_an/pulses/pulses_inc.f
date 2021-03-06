      parameter (Ngate = 10)
      parameter (Max_Pulse = 150)

      real rlgate(100)
      
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
      real pulse(100,Max_Pulse)

      integer Nwf
      integer n_puls
      integer start

      common/pulses_com/Nwf,rlgate,gate,start,
     +     q,q_r1,q_r2,q_r3,q_r4,
     +     N_puls,
     +     t,t_bef,t_aft,
     +     chi_peak,chi_3tau,
     +     ampl,
     +     wid66,wid50,wid33,
     +     q_bef,pulse
