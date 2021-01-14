# See CMake/ctkFunctionGetTargetLibraries.cmake
#
# This file should list the libraries required to build the current CTK plugin.
# For specifying required plugins, see the manifest_headers.cmake file.
#

set(target_libraries
  CTKPluginFramework
  CTKmbilog
  QT_LIBRARIES
)

if(CTK_USE_Qt5)
  list(append target_libraries Qt5::Gui Qt5::Xml)
endif()