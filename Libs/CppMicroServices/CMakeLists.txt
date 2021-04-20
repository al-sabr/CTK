project(CTKCppMicroServices)

include(files.cmake)

#
# See CTK/CMake/ctkMacroBuildLib.cmake for details
#

function(us_cache_var _var_name _var_default _var_type _var_help)
  set(_advanced 0)
  set(_force)
  foreach(_argn ${ARGN})
    if(_argn STREQUAL ADVANCED)
      set(_advanced 1)
    elseif(_argn STREQUAL FORCE)
      set(_force FORCE)
    endif()
  endforeach()

  if(US_IS_EMBEDDED)
    if(NOT DEFINED ${_var_name} OR _force)
      set(${_var_name} ${_var_default} PARENT_SCOPE)
    endif()
  else()
    set(${_var_name} ${_var_default} CACHE ${_var_type} "${_var_help}" ${_force})
    if(_advanced)
      mark_as_advanced(${_var_name})
    endif()
  endif()
endfunction()

us_cache_var(US_NAMESPACE "us" STRING "The namespace for the C++ Micro Services symbols")

set(us_internal_config_h_file "${CMAKE_CURRENT_BINARY_DIR}/InternalGlobalConfig.h")
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/InternalGlobalConfig.h.in ${us_internal_config_h_file})

set(KIT_export_directive "CTK_CPPMICROSERVICES_Core_EXPORT")

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
  LIBRARY_TYPE STATIC
  BYPASS_REGEX TRUE
  )