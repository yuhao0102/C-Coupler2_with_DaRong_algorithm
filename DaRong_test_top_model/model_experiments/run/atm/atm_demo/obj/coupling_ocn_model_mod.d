coupling_ocn_model_mod.o coupling_ocn_model_mod.d : coupling_ocn_model_mod.F90
coupling_ocn_model_mod.o : spmd_init_mod.o
coupling_ocn_model_mod.o : parse_namelist_mod.o
coupling_ocn_model_mod.o : grid_init_mod.o
coupling_ocn_model_mod.o : decomp_init_mod.o
coupling_ocn_model_mod.o : variable_init_mod.o
