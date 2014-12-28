#! /bin/tcsh -f
#!    make progrem main.x and run it wit input parameters
#!    use:    run_prog.csh mass sigma

#!    set input = `maddm`


a.out > junk

set input = `cat junk`

     echo ${input}


     set mass = `echo $input | cut -d\  -f1`
     set sigma = `echo $input | cut -d\  -f2`
     set inst = `date -u +%s`
     set file = inp/inp${inst}
     echo ${file}

     echo ${mass} > ${file}
     echo ${sigma} >> ${file}

     cat ${file}

#!   re make the program

#make

main.x < ${file}
