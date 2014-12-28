      subroutine integ(N)

c      integrate vector cont into itsef
 
      vector cont

      do i = 2,N
         cont(i) = cont(i)+cont(i-1)
      enddo

      end
