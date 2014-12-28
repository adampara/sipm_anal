      function rate(nsamp,hz,time_int)

      parameter (maxt = 100)
      real times(maxt)


      amu = hz * time_int

      do isam = 1, nsamp

         call poissn(amu,n,ier)
         call hfill(98,float(n),0,1.)
c         print *,'  number of pulses ',n
c         n=2
         if(n.gt.maxt) then
            print *,' too many pulses'
            stop
         endif

         do i = 1, n
            t = rndm(0)*time_int
c            print *,'  pulse ',i,t
            call hfill(99,t,0,1.)
c         ***  sort

            if(i.eq.1) then
               times(i) = t   
            else
c              ***  there are i-1 pulses already
               do k = i ,2 ,-1
                  if(t.lt.times(k-1)) then
                     times(k) = times(k-1)
                  else
                     times(k) = t
                     goto 10
                  endif
               enddo
               times(1) = t
            endif

 10         continue
         enddo
         
         do i=1,n
c            print *,i,times(i)
            if(i.gt.1) then
               call hfill(100,times(i)-times(i-1),0,1.)
            endif
         enddo
         
         if(n.gt.1) then
            call hfill(101,times(2)-times(1),0,1.)
         endif

         if(n.eq.2) then
            call hfill(102,times(2)-times(1),0,1.)
         endif

      enddo
      end

*
* $Id: poissn.F,v 1.1.1.1 1996/04/01 15:02:55 mclareni Exp $
*
* $Log: poissn.F,v $
* Revision 1.1.1.1  1996/04/01 15:02:55  mclareni
* Mathlib gen
*
*
*#include "gen/pilot.h"
      SUBROUTINE POISSN (AMU,N,IERROR)
C
C    POISSON GENERATOR
C    CODED FROM LOS ALAMOS REPORT      LA-5061-MS
C    PROB(N)=EXP(-AMU)*AMU**N/FACT(N)
C        WHERE FACT(N) STANDS FOR FACTORIAL OF N
C    ON RETURN IERROR.EQ.0 NORMALLY
C              IERROR.EQ.1 IF AMU.LE.0.
C
      SAVE EXPMA,AMUOL,AMAX
      DATA AMUOL/-12345.67/
C    AMAX IS THE VALUE ABOVE WHICH THE NORMAL DISTRIBUTION MUST BE USED
      DATA AMAX/88.0/

      IERROR= 0
      IF(AMU.GT.AMAX) GO TO 500
      IF(AMU.EQ.AMUOL) GO TO 200
      IF(AMU.GT.0.) GO TO 100
C    MEAN SHOULD BE POSITIVE
      IERROR=1
      N = 0
      GO TO 999
C    SAVE EXPONENTIAL FOR FURTHER IDENTICAL REQUESTS
  100 AMUOL=AMU
      EXPMA=EXP(-AMU)
  200 PIR=1.
      N=-1
  300 N=N+1
      PIR=PIR*RNDM(N)
      IF(PIR.GT.EXPMA) GO TO 300
      GO TO 999
C   NORMAL APPROXIMATION FOR AMU.GT.AMAX
  500 CALL RANNOR(RAN,B)
      N=RAN*SQRT(AMU)+AMU+.5
      GO TO 999
C   ENTRY FOR USER TO SET AMAX, SWITCHOVER POINT TO NORMAL APPROXIMATION
c      ENTRY POISET(AMU)
      WRITE(6,1001) AMU
 1001 FORMAT(' POISSON RANDOM NUMBER GENERATOR TO SWITCH TO',
     +       ' NORMAL APPROXIMATION ABOVE AMU = ',F12.2)
      AMAX=AMU
 999  END
        
