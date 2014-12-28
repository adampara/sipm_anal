      REAL FUNCTION display()
*********************************************************
*                                                       *
* This file was generated by HUWFUN.                    *
*                                                       *
*********************************************************
*
*     Ntuple Id:      30   
*     Ntuple Title:   Waveforms
*     Creation:       16/06/2014 21.55.49
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

      do i=1,10000
         x(i) = float(i)
         y(i) = wf(i) 
      enddo

      display = 1.
*
      END
