#! /bin/tcsh -f

#!   execute a paw command passed as an argument (may contain spaces)
#!   for all temperatures. replace it=xx but it=1-24

#!foreach it ( 6 7 8 9 10 11 12 )
#!foreach it ( 1 2 3 4 5 )
#!foreach it ( 13 14 15 16 17 18 19 20 )
#foreach it ( 21 22 23 24 )
#!foreach it ( 1 2)
foreach amu (0.5 1.0 2.0 5.0 7.5 10.0 15.0 20.0)
   foreach fr1 (0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.95)
     set comm = 'exec rand_afterp_batch ntry=50000 amu='${amu}' fr1='${fr1}
     echo execute paw with the command line ${comm}

     set inst = `date -u +%s`
     set file = inp/inp${inst}

     echo ${file}

     echo 0 > ${file}
     echo ${comm} >> ${file}
     echo q >> ${file}

     cat ${file}

#!     pawX11 < ${file} > /dev/null & 
     sleep 2

   end
end
