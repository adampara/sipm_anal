       SUBROUTINE fitpar(arg)
* NPFITS  Number of points used in the fit
* NFPAR   Number of free parameter
* FITCHI  Chisquare
* FITPAR  Values of parameters
* FITSIG  Errors on parameters
       COMMON/HCFITS/NCFITS,NPFITS,NFPAR,FITCHI,FITP(35),FITSIG(35)
     +             ,FITDER(35)
       vector par

       do i = 1,nfpar
          par(i)= fitp(i)
       enddo

       END