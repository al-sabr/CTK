#
# See CMake/ctkFunctionGetTargetLibraries.cmake
# 
# This file should list the libraries required to build the current CTK libraries
#

set(target_libraries
  ITK_LIBRARIES
  ITK
  VTK_LIBRARIES
  VTK
  CppMicroServices
  ITKFoundationCommon
  ITKFoundationSpatialObjects
  ITKFoundationTransform
  CTKCore
  CTKmbilog
)