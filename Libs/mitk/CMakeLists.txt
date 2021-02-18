project(CTKmitk)

#find_package(ITK COMPONENTS ITKInternal REQUIRED)

include(files.cmake)

set(KIT_export_directive "MITK_EXPORT")

# Target libraries - See CMake/ctkFunctionGetTargetLibraries.cmake
# The following macro will read the target libraries from the file 'target_libraries.cmake'

#find_package(ITK COMPONENTS ITKInternal REQUIRED) 

set(KIT_target_libraries)

ctkFunctionGetTargetLibraries(KIT_target_libraries)

ctkMacroBuildLib(
  NAME ${PROJECT_NAME}
  EXPORT_DIRECTIVE ${KIT_export_directive}
  GENERATE_MOC_SRCS ${KIT_GENERATE_MOC_SRCS}
  SRCS ${KIT_SRCS}
  MOC_SRCS ${KIT_MOC_SRCS}
  TARGET_LIBRARIES ${KIT_target_libraries}
  LIBRARY_TYPE ${CTK_LIBRARY_MODE}
  BYPASS_REGEX TRUE
  )

#target_link_libraries(${PROJECT_NAME} ITKInternal)