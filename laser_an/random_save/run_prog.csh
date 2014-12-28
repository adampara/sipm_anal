#! /bin/tcsh -f

#!    make progrem main.x and run it wit input parameters
#!    use:    run_prog.csh mass sigma

set input = `echo 22 22`
echo ${input}
set mass = $1
set sigma = $2

echo run prog for mass = ${mass} and sigma = ${sigma}

     set inst = `date -u +%s`
     set file = inp/inp${inst}
     echo ${file}

     echo ${mass} > ${file}
     echo ${sigma} >> ${file}

     cat ${file}

#!   re make the program

#make

main.x < ${file}


