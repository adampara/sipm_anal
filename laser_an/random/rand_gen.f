      function rand_gen(nr,fr1,fr2,amu)

      real str(3)
      real dec(3)

      data dec /1.e-8, 1.e-7, 1.e-6/

      data str /0.4, 0.8, 1./

      ndec = 3

      str(1) = fr1
      str(2) = fr2

c           ***   generate nr waveforms
      do  j = 1,nr

         call poissn(amu,n,ier)
         call hfill(98,float(n),0,1.)

         first = 999.

c           ****   generate n pulses

         do iel = 1,n

            x  = rndm(0)

            do i = 1,ndec
               if(x.le.str(i)) then
                  xl = dec(i)
                  goto 10
               endif
            enddo

 10         y = rndm(0)

            rexp = alog(1.-y)*(-xl)
            call hfill(99,rexp,0,1.)
            if(rexp.lt.first) first = rexp
        enddo

        if(n.gt.0) then
           call hfill(100,first,0,1.)
        endif
      enddo

      rand_gen = rexp


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
        
