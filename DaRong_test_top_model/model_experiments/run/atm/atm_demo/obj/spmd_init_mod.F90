# 1 "/data/home/yuhao/DaRong_test_top_model/model_platform/models/atm/atm_demo/spmd_init_mod.f90"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/data/home/yuhao/DaRong_test_top_model/model_platform/models/atm/atm_demo/spmd_init_mod.f90"
module spmd_init_mod
    integer, public :: mytask_id, ier, mpicomm, npes
    logical, public :: masterproc
contains
    subroutine spmd_init(external_mpicomm)
        use mpi
        implicit none
        integer, intent(in) :: external_mpicomm
        
        mpicomm = external_mpicomm
        if (mpicomm .eq. MPI_COMM_WORLD) then
            call mpi_init(ier)
        end if
        call mpi_comm_rank(mpicomm, mytask_id, ier)
        call mpi_comm_size(mpicomm, npes, ier)
        if (mytask_id == 0) then
            masterproc = .true.
        else
            masterproc = .false.
        end if
    end subroutine
end module
