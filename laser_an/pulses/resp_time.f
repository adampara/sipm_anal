      REAL FUNCTION resp_time(rand_trig,idh)

c     ***   plot the time of a response to the laser pulse 
c     ***   and to a random trigge (t_rand)

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

*
*--   Enter user code here
*
 
      print *,rand_trig,idh

      t_las = -5.e-9
      q_las = 0

      trig = 2.4995e-6

      do i = 1,N_puls

         if(t(i).gt.trig.and.t(i).lt.trig+1.e-6) then
            t_las = t(i)-trig
            q_las = ampl(i)
            goto 10
         endif
      enddo

 10   continue
      t_rand = -5.e-9
      q_rand = 0

      trig = rand_trig

      do i = 1,N_puls

         if(t(i).gt.trig.and.t(i).lt.trig+1.e-6) then
            t_rand = t(i)-trig
            q_rand = ampl(i)
            goto 20
         endif

      enddo

 20   continue

      call hfill(idh,t_las,0,1.)
      call hfill(idh+1,t_rand,0,1.)

      call hfill(idh+2,q_las,0,1.)
      call hfill(idh+3,q_rand,0,1.)

      resp_time = 0
*
      END
