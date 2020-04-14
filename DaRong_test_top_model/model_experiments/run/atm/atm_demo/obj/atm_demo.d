atm_demo.o atm_demo.d : atm_demo.f90
atm_demo.o : model_setting_mod.o
atm_demo.o : spmd_init_mod.o
atm_demo.o : parse_namelist_mod.o
