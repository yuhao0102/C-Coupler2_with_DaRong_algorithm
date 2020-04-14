module parse_namelist_mod
    integer, public :: time_step, coupling_freq, decomp_type_id
    integer, public :: num_point
    real(kind=4), public :: overlapping_rate
contains
    subroutine parse_namelist
        implicit none
        namelist /ocn_demo_nml/ time_step  ,decomp_type_id  , &
            coupling_freq,num_point,overlapping_rate
        open(10, file="./ocn_demo.nml")
        read(10, nml=ocn_demo_nml)
    end subroutine parse_namelist
end module
