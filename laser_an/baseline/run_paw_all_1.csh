#! /bin/tcsh -f

#!   execute a paw command passed as an argument (may contain spaces)
#!   for all temperatures. replace it=xx but it=1-24

foreach it ( 8 9 10 11 12 13)
#!foreach it ( 1 2)
set comm = `echo $* | sed s/it=xx/it=${it}/`
echo execute paw with the command line ${comm}

set inst = `date -u +%s`
set file = inp/inp${inst}

echo ${file}

echo 0 > ${file}
echo ${comm} >> ${file}
echo q >> ${file}

cat ${file}

pawX11 < ${file} > /dev/null & 
sleep 2

end