      real x(100)
      real y(100)
      real z(100,100)
      
      chimi=10.
      dchi= 1.
  
      cutoff = chimi + dchi
         ymax=-999
         ymin = 999

      do ix = 1,100
         

         do iy=1,99
c            look fot the lower point on the ellipse

            z1 = z(ix,iy)
            z2 = z(ix,iy+1)

            if(z1.gt.cutoff. and. z2.lt.cutoff) then
                y1=0.5(y(iy)+y(i+1))
                y1 =  y(i) + (y(i+1)-y(i))/(z2-z1)*(z1-cutoff)
               endif

c            look fot the upper point on the ellipse
            if(z1.lt.cutoff. and. z2.gt.cutoff) then
                y2=0.5(y(iy)+y(i+1))
             endif

             if(y1.lt.ymin) ymin= y1
             if(y2.gt.ymax) ymax= y2
         

         enddo

         ymi(ix) = y1
         yma(ix) = y2


      enddo
