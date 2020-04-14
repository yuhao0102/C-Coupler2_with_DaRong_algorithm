grid_init_mod.o grid_init_mod.d : grid_init_mod.F90
grid_init_mod.o : spmd_init_mod.o
grid_init_mod.o : parse_namelist_mod.o
