      function zero_prob(nnoise)

      vector xpos
      vector fun
      vector cont
      vector par
      vector ibreak

      do i = 1,200
         fun(i)=par(1)*exp(-0.5*((xpos(i)-par(2))/par(3))**2)
      enddo

c     ***   calculate the break between th noise abnd one pe

      sum_two = cont(nnoise-2)+cont(nnoise-1)

      do i = nnoise -1, 100
 
         if(cont(i)+cont(i+1).ge.sum_two) goto 99
         sum_two = cont(i)+cont(i+1)
      enddo
     
 99   continue
      
      ibreak(1) = i

      zero_prob = 1.

      end
