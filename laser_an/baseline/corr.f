      function corr(tau,i1,i2,v0)


c        ***   wf - original waveform
c        ***   bs - baseline shift
c        ***   v  - corrected waveform

      vector wf
      vector bs
      vector v

      dt = 5.e-10
      att =  exp(-dt/tau)

      v(i1-1) = 0.
      bs(i1-1) = wf(i1-1)-v0 

      do i = i1,i2
         v(i) = (wf(i)-v0 - bs(i-1)*att)
         bs(i) = bs(i-1)*att -  v(i)*dt/tau
         call hfill(77,v(i)/i,0.,1.)
      enddo

      return
      end
