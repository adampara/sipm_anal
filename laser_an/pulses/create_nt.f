      subroutine create_nt

      include 'pulses_inc.f'

      character*256 string

      call HCDIR('//LUN55',' ')
      CALL HCDIR(string,'R')
      print *,'directory'
      print *,string
      call HBNT(50,'Pulses',' ')
      string =
     +    'Nwf,gate(10),q(10),start,'//
     +    'N_puls[0,50],'//
     +    't(N_puls),t_bef(N_puls),t_aft(N_puls),'//
     +    'chi_peak(N_puls),chi_3tau(N_puls),'//
     +    'ampl(N_puls),'//
     +    'wid66(N_puls),wid50(N_puls),wid33(N_puls),'//
     +    'q_bef(N_puls)'

      print *,string
      call HBNAME(50,'Pulse',N_wf,string)

      return
      end

      subroutine test_fill

      include 'pulses_inc.f'

      do i=1,500

      nwf=i

      n_puls = 2

      t(1) = 5+i
      t(2) = 7+i
      call hfnt(50)

      enddo

      return
      end


