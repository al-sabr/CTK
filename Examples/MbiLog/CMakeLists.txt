project(MbiLogExample)

include(files)
# Target libraries - See CMake/ctkFunctionGetTargetLibraries.cmake
# The following macro will read the target libraries from the file 'target_libraries.cmake'
ctkFunctionGetTargetLibraries(KIT_target_libraries)

ctkMacroBuildApp(
  NAME ${PROJECT_NAME}
  SRCS ${KIT_SRCS}
  TARGET_LIBRARIES ${target_libraries}
  )

#mitk_create_executable(LogExample DEPENDS CTKPluginframework)
