program conv_t2b_h08vt
! テキストデータからバイナリデータ (little) へ変換する.
! For "H08VT"

  use file_operate
  use basis

  implicit none

  integer :: nl, nc=10
  integer :: i, j
  real, allocatable, dimension(:,:) :: val
  character(100), allocatable, dimension(:,:) :: cval
  character(1000) :: ifile, ofile

  write(*,*) "input and output file names"
  read(*,*) ifile, ofile

  write(*,*) "Input "//trim(adjustl(ifile))
  nl=line_number_counter( trim(adjustl(ifile)) )
  allocate(cval(nc,nl))
  allocate(val(nc,nl))
  call read_file_text( trim(adjustl(ifile)), nc, nl, cval )

  do j=1,nl
     do i=1,nc
        val(i,j)=c2r_convert( trim(adjustl(cval(i,j))) )
     end do
  end do

  open(unit=100,file=trim(adjustl(ofile)),form='unformatted',access='sequential')
  do j=1,nl
     write(100) val(1:nc,j)
  end do
  close(unit=100)

  write(*,*) "Output "//trim(adjustl(ofile))

end program
