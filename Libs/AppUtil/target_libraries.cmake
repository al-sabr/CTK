#
# See CMake/ctkFunctionGetTargetLibraries.cmake
# 
# This file should list the libraries required to build the current CTK libraries
#

set(target_libraries
  CTKCore
  CTKPluginFramework
  CTKmbilog
  CTKqtsingleapplication
  CppMicroServices
  Qt5::Widgets Qt5::WebEngine
  Poco::Util
  )

if(UNIX AND NOT APPLE)
  set(qt5_depends {qt5_depends} X11Extras)
  list(APPEND target_libraries qt5_depends)
endif()