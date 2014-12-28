      REAL FUNCTION rates(idh,tdark,tlaser)

c     ***   histogram the time and charge of pulses 

*********************************************************
*                                                       *
* This file was generated by HUWFUN.                    *
*                                                       *
*********************************************************
*
*     Ntuple Id:      50   
*     Ntuple Title:   Pulses
*     Creation:       15/09/2013 18.37.08
*
*********************************************************
*
      LOGICAL         CHAIN
      CHARACTER*128   CFILE
      INTEGER         IDNEVT,NCHEVT,ICHEVT
      REAL            OBS(13)
*
      COMMON /PAWIDN/ IDNEVT,OBS
      COMMON /PAWCHN/ CHAIN, NCHEVT, ICHEVT
      COMMON /PAWCHC/ CFILE
*
*--   Ntuple Variable Declarations
*
      REAL xlgate(100),gate(10),start,q(10),q_r1(10),q_r2(10),q_r3(10)
     + ,q_r4(10),t(50),t_bef(50),t_aft(50),chi_peak(50),chi_3tau(50)
     + ,ampl(50),wid66(50),wid50(50),wid33(50),q_bef(50),pulse(100,50)
      INTEGER Nwf,N_puls
*
      COMMON /PAWCR4/ Nwf,xlgate,gate,start,q,q_r1,q_r2,q_r3,q_r4,N_puls
     + ,t,t_bef,t_aft,chi_peak,chi_3tau,ampl,wid66,wid50,wid33,q_bef
     + ,pulse
*
      vector pe_value
*
*--   Enter user code here
*

c     ***  find the maximum amplitude in the laser gate
c     ***  to define a nyumber of initial photoelectrons

      xmax = -999
      do i=1,100
         if(xlgate(i).gt.xmax) xmax=xlgate(i)
      enddo

      ipe = nint(xmax/pe_value(1))
      call hfill(300,float(ipe),0,1.)
      if(ipe.gt.4) ipe = 4

c     ***  401  all, all pulses
c     ***  501  no pe
c     ***  601 1 pe etc..

      do i = 1,N_puls
         call hfill(idh,t(i),0,1.)
         call hfill(idh+1,t(i),0,ampl(i))
         call hfill(idh+(ipe+1)*100,t(i),0,1.)
         call hfill(idh+(ipe+1)+100+1,t(i),0,ampl(i))
      enddo


c       ****   dark, first pulse  431, etc..

      do i = 1,N_puls

         if(t(i).gt.tdark) then
            call hfill(idh+30,t(i),0,1.)
            call hfill(idh+30+1,t(i),0,ampl(i))
            call hfill(idh+30+(ipe+1)*100,t(i),0,1.)
            call hfill(idh+30+(ipe+1)+100+1,t(i),0,ampl(i))
            goto 10
         endif
      enddo

c       **** laser, first pulse  461 etc..

 10   continue

      do i = 1,N_puls
         if(t(i).gt.tlaser) then
            call hfill(idh+60,t(i),0,1.)
            call hfill(idh+60+1,t(i),0,ampl(i))
            call hfill(idh+60+(ipe+1)*100,t(i),0,1.)
            call hfill(idh+60+(ipe+1)+100+1,t(i),0,ampl(i))
            goto 20
         endif
      enddo

 20   continue


c       ****   distance between dark pulses   481

      do i = 2,N_puls
         if(t(i-1).lt.1.45e-6.and.t(i).lt.2.45e-6) then
            call hfill(idh+80,t(i)-t(i-1),0,1.)
         endif
      enddo

      rates = 0
*
      END
