##############################################################################
# (c) Crown copyright 2025 Met Office. All rights reserved.
# The file LICENCE, distributed with this code, contains details of the terms
# under which the code may be used.
##############################################################################
##############################################################################
# Various things specific to fast-debug lfric_atm when using the
# Cray Fortran compiler.
# To override flags specified in LFRic Core, use
# FFLAGS_SAFE_OPTIMISATION, to add an additional flag to what is specified
# in Core, use FFLAGS_EXTRA. If you need to add debugging flags to a module,
# modify FFLAGS_DEBUG for the target module.
# All flag modification should be `private` so they are not inherited by
# submodules.
##############################################################################

# ==========================================================================
# NON-DEBUG FLAGS
# ==========================================================================
# UKCA
%ukca_emiss_mode_mod.o: private FFLAGS_SAFE_OPTIMISATION = -O0
%ukca_step_control_mod.o: private FFLAGS_SAFE_OPTIMISATION = -O0

# UM
%parcel_ascent_5a.o: private FFLAGS_EXTRA = $(FFLAGS_UM_PHYSICS) -hvector0

# LFRic Apps
%aerosol_ukca_alg_mod_psy.o: private FFLAGS_SAFE_OPTIMISATION = -O0
%bl_exp_alg_mod_psy.o: private FFLAGS_SAFE_OPTIMISATION = -O0
%bl_imp_alg_mod_psy.o: private FFLAGS_SAFE_OPTIMISATION = -O0
%conv_comorph_alg_mod_psy.o: private FFLAGS_SAFE_OPTIMISATION = -O0
%conv_comorph_kernel_mod.o: private FFLAGS_SAFE_OPTIMISATION = -O0
%conv_gr_alg_mod_psy.o: private FFLAGS_SAFE_OPTIMISATION = -O0
%gungho_model_mod.o: private FFLAGS_SAFE_OPTIMISATION = -O0
%init_aerosol_fields_alg_mod_psy.o: private FFLAGS_SAFE_OPTIMISATION = -O0
%jules_extra_kernel_mod.o: private FFLAGS_SAFE_OPTIMISATION = -O0
large_scale_precipitation/%.o: private FFLAGS_SAFE_OPTIMISATION = -O2 -hfp0 -hflex_mp=strict

# ==========================================================================
# DEBUG FLAGS
# ==========================================================================
# UKCA
%ukca_emiss_mode_mod.o: private FFLAGS_DEBUG = 
%ukca_step_control_mod.o: private FFLAGS_DEBUG = 

# LFRic Apps
%aerosol_ukca_alg_mod_psy.o: private FFLAGS_DEBUG = 
%bl_exp_alg_mod_psy.o: private FFLAGS_DEBUG = 
%bl_imp_alg_mod_psy.o: private FFLAGS_DEBUG = 
%conv_comorph_alg_mod_psy.o: private FFLAGS_DEBUG = 
%conv_comorph_kernel_mod.o: private FFLAGS_DEBUG = 
%conv_gr_alg_mod_psy.o: private FFLAGS_DEBUG = 
%gungho_model_mod.o: private FFLAGS_DEBUG = 
%init_aerosol_fields_alg_mod_psy.o: private FFLAGS_DEBUG = 
%jules_extra_kernel_mod.o: private FFLAGS_DEBUG = 
