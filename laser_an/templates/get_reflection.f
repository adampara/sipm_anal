      function get_reflection(n1,n2)

       vector t2
       vector reflection
       vector par

       print *,par(1),par(2)
       do i = n1, n2
          fun = exp(par(1)+par(2)*(i+0.5))
          reflection(i) = t2(i) - fun
       enddo

       end
