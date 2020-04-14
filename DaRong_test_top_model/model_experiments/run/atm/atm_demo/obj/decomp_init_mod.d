decomp_init_mod.o decomp_init_mod.d : decomp_init_mod.F90
decomp_init_mod.o : spmd_init_mod.o
decomp_init_mod.o : grid_init_mod.o
decomp_init_mod.o : parse_namelist_mod.o
