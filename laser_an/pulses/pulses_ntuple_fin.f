      program pulses_ntuple

      include 'pulses_r4_fin_inc.f'
      character*256 file
      character*10 aux
      common/file/file
      call getarg(1,file)
c     print *,'  input = ',file

      call mybook

      open (unit=17,file=file,form='formatted')

      do nev=1,5000
c      print *,'nev = ',nev
      read(17,*,end=900)aux
c      print *,aux
      read(17,*)nwf
c      print *,nwf
      read(17,117)rlgate
c      print *,rlgate
      read(17,117)gate
c      print *,gate
      read(17,117)q
c      print *,'q',q
      read(17,117)q_r1
      read(17,117)q_r2
      read(17,117)q_r3
      read(17,117)q_r4
c      print *,q 
      read(17,*)start
c      print *,start
      read(17,*)N_puls,n_puls_nq

c      print *,N_puls

      do i=1,N_puls
         read(17,*)aux,j
c      print *,i,j
         read(17,*)t(i),t_bef(i),t_aft(i)
c      print *,t(i),t_bef(i),t_aft(i)
         read(17,*)chi_peak(i), chi_3tau(i)
         read(17,*)ampl(i)
         read(17,*)wid66(i),wid50(i),wid33(i)
         read(17,*)q_bef(i)
         read(17,*)puls_q(i)
         read(17,117)(pulse(j,i),j=1,200)
117     format(10e13.5)


c      print *,chi_peak(i), chi_3tau(i)
c      print *,ampl(i)
c      print *,wid66(i),wid50(i),wid33(i)
c      print *,q_bef(i)
         enddo

         call hfnt(60)

      enddo
 900  continue
      call myend
      end

      subroutine mybook

      COMMON /PAWC/ H(2000000)
      common/quest/iquest(100)

      include 'pulses_r4_inc.f'
      common/file/file
      character*256 file
      character*256 filnam
      character*1024 string

      CALL HLIMIT(1900000)

      iquest(10)=256000
      filnam = file(1:lenocc(file))//'.nt'
      print *,'  filnam ',filnam
      CALL HROPEN(1,'MYFILE',filnam,'NQE',1024,ISTAT)
      call HBNT(60,'Pulses_fin',' ')
      string =
     +    'Nwf,xlgate(500),'//
     +    'gate(10),start,'//
     +    'q(10),q_r1(10),q_r2(10),q_r3(10),q_r4(10),'//
     +    'N_puls[0,100],n_puls_nq,'//
     +    't(N_puls),t_bef(N_puls),t_aft(N_puls),'//
     +    'chi_peak(N_puls),chi_3tau(N_puls),'//
     +    'ampl(N_puls),'//
     +    'wid66(N_puls),wid50(N_puls),wid33(N_puls),'//
     +    'q_bef(N_puls),pulse(200,N_puls),puls_q(N_puls)'

      call HBNAME(60,'Pulse',Nwf,string)

      return
      end
      subroutine myend

*     
      CALL HROUT(60, ICYCLE, ' ')
      CALL HREND('MYFILE')

      return
      end
