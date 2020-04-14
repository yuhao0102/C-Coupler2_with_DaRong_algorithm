module variable_mod
    real(kind=4), public, allocatable :: ssh(:,:), shf(:,:)
    real(kind=4), public, allocatable :: sst(:,:), mld(:,:)
    real(kind=4), public, allocatable :: sst_l(:), mld_l(:)
    real(kind=4), public, allocatable :: ssh_l(:), shf_l(:)
    real(kind=4), public, allocatable :: sstm(:), mldm(:)
    real(kind=4), public, allocatable :: sshm(:), shfm(:)
    integer, public, allocatable      :: mask(:)
    real, public, allocatable   :: psl(:),prect(:),flds(:),fsds(:)
contains
    subroutine variable_init
        !call read_input_variables
        call scatter_fields
    end subroutine variable_init

    subroutine read_input_variables
        use mpi
        use spmd_init_mod, only:masterproc
        use grid_init_mod, only:latlen, lonlen

        implicit none
        include "netcdf.inc"

        character*1024 :: input_data_dir, input_file_name
        character*1024 :: input_file_dir_name
        integer :: ncid_input, ret
        integer :: sshid, shfid, sstid, mldid
        integer :: i, j

        input_data_dir = ''
        input_file_name = "ocn_demo.059106-0591071.nc"
        input_file_dir_name = input_data_dir//input_file_name
        allocate(mask(lonlen*latlen))

        if (masterproc) then
             ret = nf_open (input_file_name, nf_nowrite, ncid_input)
			 ret = nf_inq_varid (ncid_input, "z0", sshid)
			 ret = nf_inq_varid (ncid_input, "net1", shfid)
			 ret = nf_inq_varid (ncid_input, "sst", sstid)
			 ret = nf_inq_varid (ncid_input, "mld", mldid)

			 allocate(shf(lonlen, latlen))
			 allocate(sst(lonlen, latlen))
			 allocate(ssh(lonlen, latlen))
			 allocate(mld(lonlen, latlen))

			 ret = nf_get_var_real (ncid_input, sshid, ssh)
			 ret = nf_get_var_real (ncid_input, shfid, shf)
			 ret = nf_get_var_real (ncid_input, sstid, sst)
 			 ret = nf_get_var_real (ncid_input, mldid, mld)

 			 mask=1
             do i = 1,lonlen
             do j = 1,latlen
                 if (sst(i,j) .gt. 1.e+10) then
		    mask(i+lonlen*(j-1)) = 0
		end if
             end do
             end do

        else
            allocate(ssh(1,1),shf(1,1),sst(1,1),mld(1,1))
        end if
    end subroutine read_input_variables
    subroutine scatter_field(global_field, local_field)
        use mpi
        use spmd_init_mod, only:masterproc, ier, mpicomm, npes
        use decomp_init_mod, only:local_grid_cell_index, decomp_size
        use grid_init_mod, only:latlen, lonlen
        implicit none
        real(kind=4), intent(in)  :: global_field(lonlen, latlen)
        real(kind=4), intent(out) :: local_field(decomp_size)
        !----------local variables-----------------------------------
        !real(kind=4) gfield(decomp_size, npes)
        real(kind=4) lfield(decomp_size)
        integer :: p, i, j, m
        integer :: displs(1:npes)  !scatter displacements
        integer :: sndcnts(1:npes) !scatter send counts
        integer :: recvcnt  !scatter receive count
        integer, allocatable :: global_local_grid_cell_index(:)
        real(kind=4),allocatable :: gfield(:)

        recvcnt = decomp_size
        call mpi_gather(decomp_size, 1, MPI_INTEGER, sndcnts, 1, MPI_INTEGER, 0, mpicomm, ier)

        if (masterproc) then
            displs(1) = 0
            do p=2, npes
                displs(p) = displs(p-1) + sndcnts(p-1)
            end do
        endif
        
        allocate(global_local_grid_cell_index(sum(sndcnts)))
        allocate(gfield(sum(sndcnts)))
        call mpi_gatherv(local_grid_cell_index, decomp_size, MPI_INTEGER, global_local_grid_cell_index, sndcnts, displs, MPI_INTEGER, 0, mpicomm, ier)

        if (masterproc) then
            print *, sndcnts
            do p=1, npes
                do i=1, sndcnts(p)
                    m = global_local_grid_cell_index(displs(p) + i)
                    !gfield(i,p) = global_field(mod(m-1,lonlen)+1,(m-1)/lonlen+1)
                    !gfield(m) = global_field(mod(m-1,lonlen)+1,(m-1)/lonlen+1)
                    gfield(displs(p) + i) = global_field(mod(m-1,lonlen)+1,(m-1)/lonlen+1)
                end do
            end do
        end if
        
        call mpi_scatterv(gfield, sndcnts, displs, mpi_real4, lfield, recvcnt, mpi_real4, 0, mpicomm, ier)
        do i=1,decomp_size
            local_field(i) = lfield(i)
        end do
    end subroutine scatter_field
    
    subroutine scatter_fields
        use mpi
        use spmd_init_mod, only:mpicomm, ier
        use decomp_init_mod, only:decomp_size
        use grid_init_mod, only:lonlen, latlen
        implicit none

        allocate(sst_l(decomp_size))
        allocate(shf_l(decomp_size))
        allocate(ssh_l(decomp_size))
        allocate(mld_l(decomp_size))

        !call scatter_field(psl, psl_l)
        !call scatter_field(prect, prect_l)
        !call scatter_field(flds, flds_l)
        !call scatter_field(fsds, fsds_l)

        !call mpi_bcast(maskm,lonlen*latlen, mpi_integer, 0, mpicomm, ier)

        allocate(sstm(decomp_size))
        allocate(shfm(decomp_size))
        allocate(sshm(decomp_size))
        allocate(mldm(decomp_size))

        allocate(psl(decomp_size))
        allocate(prect(decomp_size))
        allocate(flds(decomp_size))
        allocate(fsds(decomp_size))
        allocate(mask(lonlen*latlen)) 
        mask = 1 
    end subroutine scatter_fields

end module
