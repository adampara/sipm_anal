#! /bin/tcsh -f

#!   execute a paw command passed as an argument (may contain spaces)
#!   for all temperatures. replace it=xx but it=1-24

echo $*

foreach it ( $*)
#!foreach it ( 1 2)
echo ${it}
end
