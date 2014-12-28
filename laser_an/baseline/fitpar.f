       SUBROUTINE fitpar(arg)
* NPFITS  Number of points used in the fit
* NFPAR   Number of free parameter
* FITCHI  Chisquare
* FITPAR  Values of parameters
* FITSIG  Errors on parameters
       COMMON/HCFITS/NCFITS,NPFITS,NFPAR,FITCHI,FITP(35),FITSIG(35)
     +             ,FITDER(35)
       vector p

       p(1)= fitp(1)
       p(2)= fitp(2)
       p(3)= fitp(3)

       END
