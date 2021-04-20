! ======================================================================
! hxh
! ----------------------------------------------------------------------
      program hxh

!     load standard iso_fortran_env module
      use, intrinsic :: iso_fortran_env

!     disable implicit variable types
      implicit none

!     declare character-valued input buffer variable that will be 
!     utilized to read in matrix and vector dimension n from command-line;
!     20 characters is the max length of a signed 64-bit integer
      character(20) :: buffer

!     declare integer-valued variables that will be utilized to store:
!     length and info variables for get_command_argument subroutine; 
!     loop indicies i, j; matrix dimension n
      integer :: length, info
      integer :: i, j, n

!     declare real-valued variables that will store the scalars alpha 
!     and beta
      real :: alpha, beta

!     declare real-valued arrays that will be utilized to store the 
!     matrices A, B, and C
      real, allocatable, dimension(:,:) :: A, B, C

!     read in the matrix and vector dimension n from command-line
      call get_command_argument(1, buffer, length, info)
      read(unit=buffer, fmt=*) n

!     allocate memory for the two-dimensional arrays used to store 
!     the matrices A, B, and C
      allocate(A(n,n))
      allocate(B(n,n))
      allocate(C(n,n))

!     initialize scalar values
      alpha = 1.0
      beta = 0.0

!     initialize the two-dimensional array A as the Hilbert matrix of
!     dimension n
      do j = 1, n 
         do i = 1, n
            A(i,j) =  1.0 / float(i+j-1)
         end do
      end do

!     initialize the two-dimensional array B as the Hilbert matrix of
!     dimension n; use array operation to copy all values of A into B
      B = A

!     initialize the two-dimensional array C as a zeros matrix of 
!     dimension n; use array operation to set all values of C to zero
      C = 0.0

!     perform matrix multiplication C = AB
      CALL DGEMM('N','N',n,n,n,alpha,A,n,B,n,beta,C,n)

!     write a few elements of the resultant matrix C to standard output
      write(unit=output_unit, fmt=*) 'C(1,1) = ', C(1,1)

!     deallocate memory utilized for the two-dimensional arrays 
!     used to store the matrices A, B, and C.
      deallocate(A)
      deallocate(B)
      deallocate(C)

      stop

      end program hxh
! ======================================================================
