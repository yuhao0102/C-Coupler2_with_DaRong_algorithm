variable_init_mod.o variable_init_mod.d : variable_init_mod.F90
variable_init_mod.o : spmd_init_mod.o
variable_init_mod.o : grid_init_mod.o
variable_init_mod.o : decomp_init_mod.o
