#
# See CMake/ctkFunctionGetTargetLibraries.cmake
# 
# This file should list the libraries required to build the current CTK libraries
#

set(target_libraries
  CppMicroServices
  CppMicroServices_LIBRARIES
  ITK_LIBRARIES
  ITK
  VTK_LIBRARIES
  VTK
  ITKFoundationCommon
  ITKFoundationSpatialObjects
  ITKFoundationTransform
  CTKCore
  CTKmbilog
)