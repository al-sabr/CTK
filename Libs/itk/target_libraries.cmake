#
# See CMake/ctkFunctionGetTargetLibraries.cmake
# 
# This file should list the libraries required to build the current CTK libraries
#

set(target_libraries
  KWSYS_LIBRARIES
  VXL_LIBRARIES
  ITKSYS_LIBRARIES
  VCL_LIBRARIES VNL_LIBRARIES
  CTKCore
)