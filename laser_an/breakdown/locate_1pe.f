      integer function locate_1pe(thresh)

c       ***   locate the position of 1 pe peak
c       ***   as a position of a local maximum following the threshold crossing

      vector cont


      do i=2,200

         if (cont(i).gt.thresh.and.cont(i-1).gt.0.1*thresh) then
            xmax = cont(i)
            imax = i
            do j=1,10
               if(cont(i+j).gt.xmax) then
                  xmax = cont(i+j)
                  imax = i+j
               endif
            enddo
            goto 99
         endif
      enddo

 99   continue
      locate_1pe = imax

      end

      
