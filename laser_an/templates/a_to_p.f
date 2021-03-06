      REAL FUNCTION a_to_p(ilow,iup,i_lower_edge,i_upper_edge
     +                      ,suml,sumu)

C     ***  calculate area-to-peak for pulses in the window ilow to iup
C     ***  suml and sumu are cuts on the area-to-peak ratios 
c     ***  accumulate pulses in histogram 222
c     ***  store single accepted pulses in histograms 1000+[i]
c     ***  to avoid afterpulses require that the max signal
c     ***  is smaller that 0.1*xmax for 400 ns after the accepted pulse 
c     ***  accepted pulses must have the amplitude above the noise cut
c     ***  as defined in the vector cut_noise


*********************************************************
*                                                       *
* This file was generated by HUWFUN.                    *
*                                                       *
*********************************************************
*
*     Ntuple Id:      30   
*     Ntuple Title:   Waveforms
*     Creation:       15/07/2013 14.23.15
*
*********************************************************
*
      LOGICAL         CHAIN
      CHARACTER*128   CFILE
      INTEGER         IDNEVT,NCHEVT,ICHEVT
      REAL            OBS(13)
*
      COMMON /PAWIDN/ IDNEVT,OBS
      COMMON /PAWCHN/ CHAIN, NCHEVT, ICHEVT
      COMMON /PAWCHC/ CFILE
*
*--   Ntuple Variable Declarations
*
      REAL wf(10000),yorig,yref,yinc,t0,toff
      INTEGER N_wf,is,iwf
*
      COMMON /PAWCR4/ N_wf,wf,yorig,yref,yinc,t0,is,iwf,toff
*
      real wave(10000)
      vector coh_noi
      vector cut_noise
      vector pe_value
      real diff(1000)

c     ***   coh_noi is a vector with coherent baseline
c     ***  subtract coherent noise

      do i = 1,10000
        wave(i) = wf(i) - coh_noi(i)
      enddo

c     ***   find the peak position and the max value

      xmax = -999.
      do ia = ilow,iup

         if(wave(ia).gt.xmax) then
            xmax = wave(ia)
            imax = ia
         endif
      enddo

c     ***  the pulse will be integrated from i_lower_edge  to i_upper_edge

      sump = 0

c      print *,imax,i_lower_edge,i_upper_edge
      do i = i_lower_edge, i_upper_edge
         sump = sump +  wave(i + imax - 201)  
      enddo

      sumtop = sump/xmax

c     ***  calculate the average value from imax to imax + nwindow

         nwindow = 45
         sum = 0
         do i = imax,imax+nwindow
            sum = sum + wave(i)
         enddo
         ave = sum/nwindow
c     ***  for average value below the threshold declare the waveform
c     ***  to be 'noise' and smear out the sum_diff

         threshold = 0.0002
         if(ave.lt.threshold) then
            sumtop = sumtop - 50.*(1.-rndm(0))
         endif

      a_to_p=sumtop

c      ***   protection against afterpulses

      xm_aft = -99.

      do i = 1,400
         if ( wave(imax+20+i).gt.xm_aft) xm_aft = wave(imax+20+i)
      enddo
c     ***   turn_off for now
      xm_aft = 0

c      ***   for accepted pulses accumulate template and store some examples
c          print *,N_wf,imax,xmax,sump,ave,sumtop,suml,sumu,xm_aft
c      ***   ---   Accepted pulses   ---  ***
      if( sumtop.gt.suml  .and. sumtop.lt.sumu  
     +     .and.  xm_aft.lt.0.1*xmax  .and. xmax.gt.cut_noise(1)) then

         pe = xmax/pe_value(1)
         npe = nint(pe)
c         print *,N_wf,imax,xmax,sump,ave,sumtop,suml,sumu,xm_aft
         ih = ih + 1
c
         idh = 1000 + ih

c      ***   store additional information at the beginning of the waveform
c      ***   max value, area-to-peak, waveform number

        call hfill(idh,1.,0,xmax)
        call hfill(idh,2.,0,sumtop)
        call hfill(idh,3.,0,float(n_wf))
        call hfill(idh,4.,0.,xm_aft)
        naux = 3

         do ib=1,1000
            if(ib.gt.naux) then
               call hfill(idh,float(ib),0,wave(ib+imax-201))
            endif

            call hfill(220,float(ib),0,wave(ib+imax-201))
            if(npe.gt.0.and.npe.lt.4) then
               call hfill(220+npe,float(ib),0,wave(ib+imax-201))
            endif
         enddo

      endif
      

      END
