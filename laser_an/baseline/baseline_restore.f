
      REAL FUNCTION baseline_restore(tau,nv0,prec)

c     remove effects of the differentiation
 
 
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
c        ***   wf - original waveform
c        ***   bs - baseline shift
c        ***   v  - corrected waveform
c        ***   voff - possible offest values
c        ***   vcount - number of points on a straight line with zero slope
c                       at a given combination of offsets 
c        ***   tau - time constants in units of time slices
      vector bs
      vector v
      vector wavef
      vector voff
      vector vcount

      att =  exp(-tau)

      i1=2
      i2=10000

c     ***    loop over the possible offset values

      nval = 2*nv0 + 1
      call vzero(vcount,nval*nval)

      do j = -nv0,nv0

         j1 = j + 1 +nv0
         v0 = voff(j1)

         v(i1-1) = wf(i1-1) - v0
         bs(i1-1) = wf(i1-1)-v0 
         bs(i1-1) = (wf(i1-1)-v0)*tau 


c      ***   correct the waveform using 'v0' as an offset value 

         do i = i1,i2

            v(i) = wf(i)-v0 - bs(i-1)*att
            bs(i) = bs(i-1)*att -  v(i)*tau

            do k = -nv0,nv0

               knd = k+1+nv0
               if(abs(v(i)-voff(knd)).lt.prec) vcount(j1,knd) = 
     +                     vcount(j1,knd)+1
            enddo
         enddo

      enddo

      imax = -1
      do i = 1, 2*nv0 +1
         do k = 1 , 2*nv0 +1
            if(vcount(i,k).gt.imax) then
               imax = vcount(i,k)
               voffi = voff(i)
               ipos = i
               voffk = voff(k)
               kpos = k
            endif
         enddo
      enddo

      print *,'  voffi, voffk ',voffi,' ', voffk,' ',ipos,' ',kpos, 
     +        ' ',imax
         v(i1-1) = wf(i1-1) - voffi 
         bs(i1-1) = wf(i1-1) - voffi 
         bs(i1-1) = (wf(i1-1) - voffi)*tau 
         wavef(i1-1) = wf(i1-1)

c      ***   correct the waveform using 'voffi' and 'voffk'
         do i = i1,i2
*         print *,i
            wavef(i) = wf(i)
            v(i) = wf(i) - voffi  - bs(i-1)*att
            v(i) = wf(i)  - bs(i-1)*att
            bs(i) = bs(i-1)*att -  v(i)*tau
            v(i) = v(i) - voffk 
         enddo

      baseline_restore = 1


      END