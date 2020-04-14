model_setting_mod.o model_setting_mod.d : model_setting_mod.f90
model_setting_mod.o : parse_namelist_mod.o
model_setting_mod.o : spmd_init_mod.o
model_setting_mod.o : coupling_ocn_model_mod.o
model_setting_mod.o : grid_init_mod.o
model_setting_mod.o : decomp_init_mod.o
model_setting_mod.o : variable_init_mod.o
