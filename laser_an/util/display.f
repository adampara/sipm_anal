      REAL FUNCTION display()

c     ***   histogram waveforms in histogram ID=999
c     ***   store the last waveform in vectors x and y
c     ***   intended to work with waveforms from sweeps_nt
c     ***   coherent noise is assumed to be in the vector
c     ***   coh_n (to be created before the invocation)

*********************************************************
*                                                       *
* This file was generated by HUWFUN.                    *
*                                                       *
*********************************************************
*
*     Ntuple Id:      30   
*     Ntuple Title:   Waveforms
*     Creation:       14/06/2013 13.41.35
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
      REAL wf(10000),yorig,yref,yinc,t0,toff
      INTEGER N_wf,is,iwf
*
      COMMON /PAWCR4/ N_wf,wf,yorig,yref,yinc,t0,is,iwf,toff
*

*
*--   Enter user code here
*
      
      vector x
      vector y    
      vector coh_n

      do i=1,10000
         x(i) = float(i)
         y(i) = wf(i) - coh_n(i)
         call hfill(999,float(i),0,wf(i)-coh_n(i))
      enddo

      display = 1.
*
      END
