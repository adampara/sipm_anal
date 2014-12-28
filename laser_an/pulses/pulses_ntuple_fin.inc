      parameter (Ngate = 10)
      parameter (Max_Pulse = 50)
      
      real gate(Ngate)
      real q(Ngate)

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
      integer Nwf      
      integer n_puls
      integer start

      common/pulses_com/Nwf,
     +     N_puls,
     +     gate,q,start,
     +     t,t_bef,t_aft,
     +     chi_peak,chi_3tau,
     +     ampl,
     +     wid66,wid50,wid33,
     +     q_bef
