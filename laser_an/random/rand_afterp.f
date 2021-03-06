      function rand_afterp(nr,fr1,fr2,amu,xup)

      vector gate

      integer N_puls_max
      parameter ( N_puls_max = 200000)

      real time(N_puls_max)
      real times(N_puls_max)
      integer itime(N_puls_max)

      real str(3)
      real dec(3)

      data dec /5.e-8, 1.e-7, 1.e-6/

      data str /0.4, 0.8, 1./

      ndec = 1

      str(1) = fr1
      str(2) = fr2
      print *,' xup ',xup
c     ***   generate nr waveforms
      do  j = 1,nr

         if(amu.gt.0) then
            call poissn(amu,n,ier)
            start = xup - 25.e-7
         else
            n=1
            start = 5.e-7
         endif

         call hfill(98,float(n),0,1.)

         first = 999.

c     print *,'   --------------  ',n
c     ****   generate n pulses

         npuls = 0

         do iel = 1,n
            if(amu.gt.0) then
               x  = rndm(0)*xup
            else
               x=start
            endif
   

            call ins_ar(time,npuls,x)
            npuls = npuls + 1
            call hfill(100,x,0,1.)
         enddo

c     print *,  ' generated pulses '

         do ii = 1,npuls
c     print *,ii,time(ii)
         enddo



         if(npuls.gt.0 ) then
            ip = 1

            do while ip.le.npuls

               if(fr1.ge.0) then
                  call poissn(fr1,n1,ier)
c     print *,' pulse ',ip, 'generates ',n1,' afterpulses'
               else
                  n1=1
               endif

               call hfill(97,float(n1),0,1.)
               if(n1.gt.0) then

                  do iaft = 1,n1
                     xl = dec(1)
                     y = rndm(0)
                     rexp = alog(1.-y)*(-xl)
                     if(npuls.ge.N_puls_max) then
                        print *,' too many pulses '
                        goto 99
                     endif
                     call ins_ar(time,npuls,time(ip)+rexp)
                     call hfill(99,time(ip)+rexp,0.,1.)
                     npuls = npuls + 1

c                    *** if fr1=0 generate only only afterpulse

                     if(fr1.lt.0) goto 99

 1                enddo

               endif

c     print *,'  analyze pulse ',ip, time(ip)                 
               ip = ip + 1
            enddo

c     print *,'  final pulses '

            do ii = 1,npuls
               call hfill(101,time(ii),0.,1.)            
c     print *,ii,time(ii)
            enddo

         endif
         


 99      continue
         
         call hfill(96,float(npuls),0,1.)   



         do ig = 1,20

            ninst = 2.e-6/gate(ig)
c     print *,'  ig, gate,ninst ',ig,gate(ig),ninst
            do inst = 1,ninst
               ngate = 0
               do ip = 1,npuls
                  st = start + (inst-1)*gate(ig)
                  if (time(ip).ge.st.and.time(ip).lt.st+gate(ig))then
                     ngate = ngate + 1
                  endif
               enddo
c     print *,'  gate', ig,ngate(ig)
               call hfill(400+ig,float(ngate),0,1.)
            enddo
         enddo
         do ib = 1,99
            npib = 0
            start = start + gate(1)
            do ip = 1,npuls
               if (time(ip).ge.start.and.time(ip).lt.start+gate(1))
     +              then
                  npib = npib + 1
               endif
               
            enddo

            call hfill(500+ib,float(npib),0,1.)   

         enddo
         rand_afterp = rexp

c    ***   first afterpulse, in case of a single 'dark' pulse

         if(npuls.gt.1) then
            call  hfill(102,time(2),0,1.)
         endif

      enddo

      end

      subroutine ins_ar(ar,n,el)
c
c     ***   insert element el into array ar(n) manintaing the increasing
c     ***   order of elements

      real ar(200000)

c      print *,'input array, ',n, ' insert element ',el

      if(n.gt.0) then
         do i=1,n
c            print *,i,ar(i)
         enddo

         do i = 1,n
            if(el.lt.ar(i)) goto 10
         enddo

 10      continue


c         print *,'insert at position ',i

         do j=n+1,i+1,-1
            ar(j) = ar(j-1)
         enddo
      else
         i = 1
      endif

      ar(i) = el

c      print *,'output array '
      do i=1,n+1
c         print *,i,ar(i)
      enddo

      return
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

