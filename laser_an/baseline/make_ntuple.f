      program make_ntuple

      implicit none

      include 'ntuple.inc.f'
      character*256 filnam
      common/filen/filnam

      character*256 line
      character*256 file

      integer j
      integer i
      integer lin
      integer ile

      logical debug
      logical eof

      debug = .false.

      call getarg(1,file)
      print *,'  input = ',file
c      read(file,*)ile
      call getarg(2,filnam)
      print *,'  ntuple = ',filnam

      if(iargc().eq.3) debug=.true.

      call mybook
      lin = 11
c      file = 'data.file'

      open (unit=lin, file=file, form='formatted')

      do i=1,5000

      read(lin,11,end=999)N_wf,wf,yorig,yref,yinc,t0,is,iwf,toff
 11   format(i6/1000(10f10.6/),4e12.4,2i8,e12.4)
         call hfnt(30)

      enddo

 999  continue
      

      call myend

      end
           subroutine mybook

      COMMON /PAWC/ H(2000000)
      common/quest/iquest(100)

*     
      include 'ntuple.inc.f'

      character*256 filnam
      common/filen/filnam

      CALL HLIMIT(1900000)

      iquest(10)=256000

      CALL HROPEN(1,'MYFILE',filnam,'NQE',8191,ISTAT)
      CALL HBNT(30,'Waveforms',' ')


      call hbname(30,'raw wf',N_wf,'N_wf,wf(10000),'//
     +            'yorig,yref,yinc,t0,is,iwf,toff')
      return
      end
      subroutine myend

*     
      CALL HROUT(30, ICYCLE, ' ')
      CALL HREND('MYFILE')

      return
      end

