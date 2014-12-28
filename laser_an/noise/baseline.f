      REAL FUNCTION baseline(cut,icutl,icutu,idhl,
     +   idhu,javel,javeh)

c     ***  define the 'laser response' by looking at the average response 
c     ***  between icutl and icutu being greater than cut
c
c     ***  for time slices between javel and javeh
c     ***  average only waveforms with no laser response
c
c     ***  analyze the waveform betweel idhl and idhu only 
c     ***  (for batch processing, to save time)
c     
c   
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
*
*--   Enter user code here

      q = 0
      do i = icutl,icutu
         q = q + wf(i)
      enddo

      
      iacc = 1
      if(q.gt.cut) iacc = 0
*
      do i=idhl,idhu

         idh = 1000 + i

c           for time bins between javel and javeh fill histogram
c            only if there was no signal in the laser gate

         if(i.lt.javel  .or.  i.gt.javeh  .or.  iacc.eq.1) then
            call hfill(idh,wf(i),0,1.)
         endif
      enddo

      baseline = q
*
      END
