      function pzero(i1)

      vector cont
      vector fun_peak
      vector fun
      vector zero

      cand =0
      sig = 0

      do i=1,i1
         cand = cand + cont(i)
         sig  = sig  + fun_peak(i)
      enddo

      xnmis = 0
      do i=i1+1,200
         xnmis = xnmis + fun(i)
      enddo

      xnz = cand + xnmis - sig

      zero(1) =  xnz

      print *,'pzero',xnz,cand,xnmix,sig

      end
