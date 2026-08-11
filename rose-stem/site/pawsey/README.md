# Setonix

This section details the changes required to run LFRic on **Setonix**.

## Dependencies

For **version 3.2**, update `lfric_core` in `dependencies.yaml` to use the following revision. This revision contains the changes required to run with **CCE 18.0.1** and **Cray MPICH 9.0.1**:

```yaml
lfric_core:
  source: git@github.com:ddeeptimahanti/lfric_core.git
  ref: 666770aaf375c8888858d37095c08d7714ae9904
```

## Cray Compiler Linking Error

When compiling with **CCE 18.0.1**, the `ftn` compiler may report the following error during the linking stage:

```text
ftn-2116 ftn: INTERNAL
"driver" was terminated due to receipt of signal 013: Segmentation fault.
```

This error causes Cylc to terminate the workflow.

As a workaround, a condition has been added to:

```text
rose-stem/templates/runtime/generate_runtime_build.cylc
```

to allow the workflow to continue even when this specific linking error is returned.

> **Note:** This workaround forces the build task to return success on Setonix despite the compiler error. The resulting executable should therefore be verified before being used for production runs.

## Variables Used Before Definition with CCE 18.0.1

**CCE 18.0.1** reports the following errors during compilation:

```text
ftn-7212 ftn: ERROR PC2_BL_FORCED_CU, File = large_scale_cloud/pc2_bl_forced_cu.f90, Line = 119
Variable "dcfl" is used before it is defined.

ftn-7212 ftn: ERROR PC2_BL_FORCED_CU, File = large_scale_cloud/pc2_bl_forced_cu.f90, Line = 119
Variable "cf_forced" is used before it is defined.

ftn-7212 ftn: ERROR PC2_BL_FORCED_CU, File = large_scale_cloud/pc2_bl_forced_cu.f90, Line = 119
Variable "cf_base" is used before it is defined.

ftn-7212 ftn: ERROR PC2_BL_FORCED_CU, File = large_scale_cloud/pc2_bl_forced_cu.f90, Line = 119
Variable "dqcl" is used before it is defined.

ftn-7212 ftn: ERROR PC2_BL_FORCED_CU, File = large_scale_cloud/pc2_bl_forced_cu.f90, Line = 119
Variable "qcl_tol" is used before it is defined.

ftn-7212 ftn: ERROR PC2_BL_FORCED_CU, File = large_scale_cloud/pc2_bl_forced_cu.f90, Line = 119
Variable "qcl_forced" is used before it is defined.
```

To resolve these errors, initialise the affected variables to `0.0` in:

```text
lfric_apps/science/physics_schemes/source/large_scale_cloud/pc2_bl_forced_cu.F90
```

The affected variables are:

```text
dcfl
cf_forced
cf_base
dqcl
qcl_tol
qcl_forced
```

For example:

```fortran
dcfl       = 0.0
cf_forced  = 0.0
cf_base    = 0.0
dqcl       = 0.0
qcl_tol    = 0.0
qcl_forced = 0.0
```

These initialisations prevent the **CCE 18.0.1** compiler from reporting the variables as being used before they are defined.


