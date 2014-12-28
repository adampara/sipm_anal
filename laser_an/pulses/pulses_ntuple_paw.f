      subroutine pulses_ntuple_paw

      include 'pulses_ntuple.inc'
      character*256 file
      character*10 aux
      common/file/file
 
      call mybook

c      open (unit=17,file=file,form='formatted')

      do nev=1,5000
         print *,'nev = ',nev
      read(37,*,end=900)aux
      print *,aux
      read(37,*)ii
      nwf = ii
      print *,nwf
      read(37,*)gate
      print *,gate
      read(37,*)q
      print *,q 
      read(37,*)start
      print *,start
      read(37,*)N_puls





      print *,N_puls

      do i=1,N_puls
         read(37,*)aux,j
         read(37,*)t(i),t_bef(i),t_aft(i)
         read(37,*)chi_peak(i), chi_3tau(i)
         read(37,*)ampl(i)
         read(37,*)wid66(i),wid50(i),wid33(i)
         read(37,*)q_bef(i)
         print *,i,j
         print *,t(i),t_bef(i),t_aft(i)
         print *,chi_peak(i), chi_3tau(i)
         print *,ampl(i)
         print *,wid66(i),wid50(i),wid33(i)
         print *,q_bef(i)
         enddo

         call hfnt(50)

      enddo
 900  continue
      call myend
      end

      subroutine mybook

      COMMON /PAWC/ H(2000000)
      common/quest/iquest(100)

      include 'pulses_ntuple.inc'
      common/file/file
      character*256 file
      character*256 filnam
      character*256 string

c      filnam = file(1:lenocc(file))//'.nt'
      filnam = 'paw.nt'

c      CALL HROPEN(1,'MYFILE',filnam,'NQE',1024,ISTAT)
      call HBNT(50,'Pulses',' ')
      string =
     +    'Nwf:R,'//
     +    'N_puls[0,50],'//
     +    'gate(10),q(10),start,'//
     +    't(N_puls),t_bef(N_puls),t_aft(N_puls),'//
     +    'chi_peak(N_puls),chi_3tau(N_puls),'//
     +    'ampl(N_puls),'//
     +    'wid66(N_puls),wid50(N_puls),wid33(N_puls),'//
     +    'q_bef(N_puls)'

      print *,string
      call HBNAME(50,'Pulse',N_wf,string)

      return
      end
      subroutine myend

*     
      CALL HROUT(50, ICYCLE, ' ')
      CALL HREND('MYFILE')

      return
      end
