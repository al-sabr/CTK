include(CMakePackageConfigHelpers OPTIONAL)

# During minor releases bugs may be identified that identify broken interface, or
# useless interfaces that need to be retained to not break backwards compatibilty.
# These ITK_FUTURE_LEGACY_REMOVE are another level of granularity for
# which backwards compatible features we want to maintain.
cmake_dependent_option(ITK_FUTURE_LEGACY_REMOVE
      "Completely remove compilation of code which will become deprecated by default in ITKv5." OFF
      "ITK_LEGACY_REMOVE" OFF)
cmake_dependent_option(ITK_LEGACY_SILENT
      "Silence all legacy code messages when ITK_LEGACY_REMOVE:BOOL=OFF." OFF
      "NOT ITK_LEGACY_REMOVE" OFF)
      

set(CTK_CONFIG_DIR_CONFIG ${CTK_SUPERBUILD_BINARY_DIR})
set(CTK_CMAKE_DIR_CONFIG ${CTK_CMAKE_DIR})
set(CTK_CMAKE_UTILITIES_DIR_CONFIG ${CTK_CMAKE_UTILITIES_DIR})
set(CTK_CONFIG_H_INCLUDE_DIR_CONFIG ${CTK_CONFIG_H_INCLUDE_DIR})
set(CTK_EXPORT_HEADER_TEMPLATE_DIR_CONFIG ${CTK_SOURCE_DIR}/Libs)
set(CTK_LIBRARY_DIR_CONFIG ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})

# Import from ITK/CMakeLists.txt->Line#541

# Generate ITKConfig.cmake for the build tree.
set(ITK_CONFIG_CODE "
set(ITK_MODULES_DIR \"${ITK_MODULES_DIR}\")")

set(ITK_CONFIG_TARGETS_CONDITION " AND NOT ITK_BINARY_DIR")
set(ITK_CONFIG_TARGETS_FILE "${ITK_BINARY_DIR}/ITKTargets.cmake")
set(ITK_CONFIG_MODULE_API_FILE "${ITK_SOURCE_DIR}/CMake/ITKModuleAPI.cmake")
configure_file(../ITKConfig.cmake.in ITKConfig.cmake @ONLY)

# Generate ITKConfig.cmake for the install tree.
set(ITK_CONFIG_CODE "
# Compute the installation prefix from this ITKConfig.cmake file location.
get_filename_component(ITK_INSTALL_PREFIX \"\${CMAKE_CURRENT_LIST_FILE}\" PATH)")
# Construct the proper number of get_filename_component(... PATH)
# calls to compute the installation prefix.
string(REGEX REPLACE "/" ";" _count "${ITK_INSTALL_PACKAGE_DIR}")
foreach(p ${_count})
  set(ITK_CONFIG_CODE "${ITK_CONFIG_CODE}
get_filename_component(ITK_INSTALL_PREFIX \"\${ITK_INSTALL_PREFIX}\" PATH)")
endforeach()
set(ITK_CONFIG_CODE "${ITK_CONFIG_CODE}
set(ITK_MODULES_DIR \"\${ITK_INSTALL_PREFIX}/${ITK_INSTALL_PACKAGE_DIR}/Modules\")")
set(ITK_USE_FILE "\${ITK_INSTALL_PREFIX}/${ITK_INSTALL_PACKAGE_DIR}/UseITK.cmake")
set(ITK_CONFIG_CMAKE_DIR "\${ITK_INSTALL_PREFIX}/${ITK_INSTALL_PACKAGE_DIR}")
set(ITK_CONFIG_TARGETS_CONDITION "")
set(ITK_CONFIG_TARGETS_FILE "\${ITK_INSTALL_PREFIX}/${ITK_INSTALL_PACKAGE_DIR}/ITKTargets.cmake")
set(ITK_CONFIG_MODULE_API_FILE "\${ITK_INSTALL_PREFIX}/${ITK_INSTALL_PACKAGE_DIR}/ITKModuleAPI.cmake")
if(NOT ITK_USE_SYSTEM_FFTW)
  # Location installed with the FFTW ExternalProject.
  set(FFTW_LIBDIR "\${ITK_INSTALL_PREFIX}/lib/ITK-${ITK_VERSION_MAJOR}.${ITK_VERSION_MINOR}")
  set(FFTW_INCLUDE_PATH "\${ITK_INSTALL_PREFIX}/include/ITK-${ITK_VERSION_MAJOR}.${ITK_VERSION_MINOR}/Algorithms")
endif()

#[[
configure_file(../ITKConfig.cmake.in CMakeFiles/ITKConfig.cmake @ONLY)

#-----------------------------------------------------------------------------
install(FILES ${ITK_BINARY_DIR}/CMakeFiles/ITKConfig.cmake
              ${ITK_BINARY_DIR}/ITKConfigVersion.cmake
              CMake/ITKModuleAPI.cmake
              CMake/UseITK.cmake
              CMake/itkImageIOFactoryRegisterManager.h.in
              CMake/itkTransformIOFactoryRegisterManager.h.in
              CMake/itkMeshIOFactoryRegisterManager.h.in
  DESTINATION ${ITK_INSTALL_PACKAGE_DIR}
  COMPONENT Development)
get_property(ITKTargets_MODULES GLOBAL PROPERTY ITKTargets_MODULES)
if(ITKTargets_MODULES)
  install(EXPORT ITKTargets DESTINATION ${ITK_INSTALL_PACKAGE_DIR}
          COMPONENT Development)
else()
  set(CMAKE_CONFIGURABLE_FILE_CONTENT "# No targets!")
  configure_file(${CMAKE_ROOT}/Modules/CMakeConfigurableFile.in
                 ${ITK_BINARY_DIR}/CMakeFiles/ITKTargets.cmake @ONLY)
  install(FILES ${ITK_BINARY_DIR}/CMakeFiles/ITKTargets.cmake
          DESTINATION ${ITK_INSTALL_PACKAGE_DIR} COMPONENT Development)
endif()

install(FILES "LICENSE" "NOTICE" "README.md" DESTINATION ${ITK_INSTALL_DOC_DIR} COMPONENT Runtime)
]]
#-----------------------------------------------------------------------------
configure_file(
  ${CTK_SOURCE_DIR}/CMake/itkConfig.h.in
  ${CTK_CONFIG_H_INCLUDE_DIR}/itkConfig.h @ONLY
  )

install(
  FILES ${CTK_CONFIG_H_INCLUDE_DIR}/itkConfig.h
  DESTINATION ${CTK_INSTALL_INCLUDE_DIR} COMPONENT Development
  )


set(itk_install_config ${CMAKE_BINARY_DIR}/CMakeFiles/ITKConfig.cmake)

configure_package_config_file(
  ${CMAKE_SOURCE_DIR}/CMake/ITKConfig.cmake.in
  ${itk_install_config}
  INSTALL_DESTINATION ${CTK_INSTALL_CMAKE_DIR}
  PATH_VARS
    CTK_CONFIG_DIR_CONFIG
    ITK_CONFIG_CMAKE_DIR #CTK_CMAKE_DIR_CONFIG 
    CTK_CMAKE_UTILITIES_DIR_CONFIG
    CTK_CONFIG_H_INCLUDE_DIR_CONFIG
    CTK_EXPORT_HEADER_TEMPLATE_DIR_CONFIG
    CTK_LIBRARY_DIR_CONFIG
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
  )

install(
  FILES ${itk_install_config}
  DESTINATION ${CTK_INSTALL_CMAKE_DIR} COMPONENT Development
  )

# Import from ITK/CMakeLists.txt->Line#151
configure_file(${CTK_SOURCE_DIR}/CMake/ITKConfigVersion.cmake.in ITKConfigVersion.cmake @ONLY)

#-----------------------------------------------------------------------------
# Configure and install 'ITKConfigVersion.cmake'
set(itk_config_version ${CTK_SUPERBUILD_BINARY_DIR}/ITKConfigVersion.cmake)
write_basic_package_version_file(
  ${itk_config_version}
  VERSION ${ITK_MAJOR_VERSION}.${ITK_MINOR_VERSION}.${ITK_PATCH_VERSION}
  COMPATIBILITY SameMajorVersion
  )

install(
  FILES ${itk_config_version}
  DESTINATION ${CTK_INSTALL_CMAKE_DIR} COMPONENT Development
  )



# Code imported from ITK/CMakeLists.txt/Line#171
#[[
if(NOT ITK_INSTALL_PACKAGE_DIR)
  set(ITK_INSTALL_PACKAGE_DIR "lib/cmake/itk-${ITK_MAJOR_VERSION}.${ITK_MINOR_VERSION}")
endif()
 
message("ITK_INSTALL_PACKAGE_DIR :                  ${ITK_INSTALL_PACKAGE_DIR}")  
]]

# ITK placeholder for configuration generation.
# Code imported from ITK/CMakeLists.txt/Line#542

set(ITK_OLDEST_VALIDATED_POLICIES_VERSION "3.10.2")
set(ITK_NEWEST_VALIDATED_POLICIES_VERSION "3.14.0")
cmake_minimum_required(VERSION ${ITK_OLDEST_VALIDATED_POLICIES_VERSION} FATAL_ERROR)
if("${CMAKE_VERSION}" VERSION_LESS_EQUAL "${ITK_NEWEST_VALIDATED_POLICIES_VERSION}")
  #Set and use the newest available cmake policies that are validated to work
  set(ITK_CMAKE_POLICY_VERSION "${CMAKE_VERSION}")
else()
  set(ITK_CMAKE_POLICY_VERSION "${ITK_NEWEST_VALIDATED_POLICIES_VERSION}")
endif()
cmake_policy(VERSION ${ITK_CMAKE_POLICY_VERSION})

# ---------------- Tools -----------------
# Code imported from MITK/CMakeLists.txt/Line#1416

configure_file(${CTK_SOURCE_DIR}/CMake/ToolExtensionITKFactory.cpp.in
               ${CTK_BINARY_DIR}/ToolExtensionITKFactory.cpp.in COPYONLY)
configure_file(${CTK_SOURCE_DIR}/CMake/ToolExtensionITKFactoryLoader.cpp.in
               ${CTK_BINARY_DIR}/ToolExtensionITKFactoryLoader.cpp.in COPYONLY)
configure_file(${CTK_SOURCE_DIR}/CMake/ToolGUIExtensionITKFactory.cpp.in
               ${CTK_BINARY_DIR}/ToolGUIExtensionITKFactory.cpp.in COPYONLY)