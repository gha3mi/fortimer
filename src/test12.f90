program test12

   use kinds
   use fortime
   use forunittest

   implicit none

   type(timer) :: t
   type(unit_test) :: ut
   integer :: nl, nloops=3
   integer :: ierr


#if defined(USE_MPI)
   ! MPI time with nloops
   call mpi_init(ierr)
   call t%mtimer_start()
   do nl = 1, nloops
      call sleep(1) ! Perform operations ntimes
   end do
   call t%mtimer_stop(message = 'MPI time:')
   call mpi_finalize(ierr)
   call t%mtimer_write('test/test12_mtimes') ! Optionally, write the elapsed time to a file

   call ut%check(res=t%mpi_time, expected=real(nloops,rk)*1.0_rk, tol=1.0e-2_rk, msg='test12')

#endif

end program test12

