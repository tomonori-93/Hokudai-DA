program test

integer :: iunit
real, dimension(8) :: wk
character(22) :: cfile

cfile='obs_20180923010000.dat'
iunit=91
OPEN(iunit,FILE=cfile,FORM='unformatted',ACCESS='sequential')
do n=1,540
   read(iunit) wk
   write(*,*) "write", wk
end do
CLOSE(iunit)
end program
