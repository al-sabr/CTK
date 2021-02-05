#[[
if(UNIX AND NOT APPLE)
  set(qt5_depends "${qt5_depends}+X11Extras")
endif()

mitk_create_module(
  PACKAGE_DEPENDS
    PUBLIC CTK|CTKPluginFramework ${qt5_depends} Poco|Util
    PRIVATE VTK
  DEPENDS
    PUBLIC qtsingleapplication
    PRIVATE MitkCore
)
]]

project(CTKAppUtil)

include(files.cmake)

find_package(CppMicroServices COMPONENTS usLogService usWebConsole usHttpService)
#
# See CTK/CMake/ctkMacroBuildLib.cmake for details
#

set(KIT_export_directive "CTK_APPUTIL_EXPORT")

# Target libraries - See CMake/ctkFunctionGetTargetLibraries.cmake
# The following macro will read the target libraries from the file 'target_libraries.cmake'
set(KIT_target_libraries)

ctkFunctionGetTargetLibraries(KIT_target_libraries)

ctkMacroBuildLib(
  NAME ${PROJECT_NAME}
  EXPORT_DIRECTIVE ${KIT_export_directive}
  SRCS ${KIT_SRCS}
  MOC_SRCS ${KIT_MOC_SRCS}
  TARGET_LIBRARIES ${KIT_target_libraries}
  LIBRARY_TYPE STATIC#${CTK_LIBRARY_MODE}
  )