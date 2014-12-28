#! /bin/tcsh -f

#!   create ntuples with corrected baselines
#!  make_corrected_ntuples.csh /det_rd_results/sipm_anal/laser_an/exp/Ham-025U-4_Oct_19  

set top_dir = $1
echo top directory = ${top_dir}
set prog = /det_rd_results/sipm_anal/laser_an/baseline/make_ntuple
cd $top_dir
   
set temps = `ls -F | egrep '^-?[[:digit:]]+/$' | tr / " "  `

echo ${temps}

foreach temp (${temps})
 
    echo ${temp}
    pwd
    cd ${top_dir}/${temp}
    pwd
    ls
    set dat_files = `ls ./*bas_rest.dat`

    foreach ifile (${dat_files})

    set ofile = `echo ${ifile} | sed s/_bas_rest.dat/_bascor_nt/`
    echo in ${ifile}  out ${ofile}
    ${prog} ${ifile}  ${ofile}

    end
end
exit

