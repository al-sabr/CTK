project(CTKmbilog)

include(files.cmake)

option(MBILOG_ENABLE_DEBUG_MESSAGES "Enable extra debug log output" OFF)
mark_as_advanced(MBILOG_ENABLE_DEBUG_MESSAGES)

if(MBILOG_ENABLE_DEBUG_MESSAGES)
  set(_define_enable_debug "#define MBILOG_ENABLE_DEBUG")
endif(MBILOG_ENABLE_DEBUG_MESSAGES)

configure_file("${CMAKE_CURRENT_SOURCE_DIR}/mbilogConfig.cmake.in"
"${CMAKE_CURRENT_BINARY_DIR}/mbilogConfig.cmake" @ONLY)

configure_file("${CMAKE_CURRENT_SOURCE_DIR}/mbilogConfig.h.in"
"${CMAKE_CURRENT_BINARY_DIR}/mbilogConfig.h" @ONLY)

#
# See CTK/CMake/ctkMacroBuildLib.cmake for details
#

string(TIMESTAMP CONFIGURE_DATE "%Y-%m-%d %H:%M")

## MAKE_MAP_ENTRY is a macro to facilitate placing items in the itk::BuildInformation class
##                /--------------------------_---------------------------_-------------------------------------------------/
##                |    KEY                   |    VALUE                  | Description of value                            |
##                \--------------------------\---------------------------\-------------------------------------------------\
set(MAPPING_VALUES "
  MAKE_MAP_ENTRY( \"PROJECT_URL\",           \"http://www.itk.org\",      \"The URL of project.\"                     );
  MAKE_MAP_ENTRY( \"VERSION\",               \"${ITK_VERSION}\"    ,      \"The version at configuration time.\"      );
  MAKE_MAP_ENTRY( \"CONFIGURE_DATE\",        \"${CONFIGURE_DATE}\",       \"The date of configuration.\"              );

  MAKE_MAP_ENTRY( \"GIT_CONFIG_SHA1\",       \"${GIT_CONFIG_SHA1}${GIT_LOCAL_MODIFICATIONS}\",
                                                                               \"The git HEAD SHA1 has at configuration.\" );
  MAKE_MAP_ENTRY( \"GIT_CONFIG_REFSPEC\",    \"${GIT_CONFIG_REFSPEC}\",   \"The git HEAD ref spec.\"                  );
  MAKE_MAP_ENTRY( \"GIT_CONFIG_DATE\",       \"${GIT_CONFIG_DATE}\",      \"The git HEAD date\"                       );
  MAKE_MAP_ENTRY( \"GIT_VERSION_DESC\",      \"${GIT_VERSION_DESC}\",     \"The git HEAD version tag-commits-hash\"   );

  MAKE_MAP_ENTRY( \"CMAKE_VERSION\",         \"${CMAKE_VERSION}\",        \"The version of cmake used to configure.\" );
  MAKE_MAP_ENTRY( \"CMAKE_GENERATOR\",       \"${CMAKE_GENERATOR}\",      \"The generator used for building.\"        );
  MAKE_MAP_ENTRY( \"CMAKE_BUILD_TYPE\",      \"${CMAKE_BUILD_TYPE}\",     \"The build type requested.\"               );

  MAKE_MAP_ENTRY( \"CMAKE_C_COMPILER_ID\",   \"${CMAKE_C_COMPILER_ID}\",  \"The C compiler ID used for building.\"    );
  MAKE_MAP_ENTRY( \"CMAKE_C_COMPILER_VERSION\",   \"${CMAKE_C_COMPILER_VERSION}\",
                                                                          \"The C compiler version used for building.\"    );
  MAKE_MAP_ENTRY( \"CMAKE_C_COMPILER\",      \"${CMAKE_C_COMPILER}\",     \"The C compiler.\"                       );
  MAKE_MAP_ENTRY( \"CMAKE_C_FLAGS\",         \"${CMAKE_C_FLAGS} ${CMAKE_CXX_FLAGS_${CMAKE_BUILD_TYPE}}\",
                                                                          \"The C compiler flags.\"                 );

  MAKE_MAP_ENTRY( \"CMAKE_CXX_STANDARD\",    \"${CMAKE_CXX_STANDARD}\",   \"The CXX standard specified.\"             );
  MAKE_MAP_ENTRY( \"CMAKE_CXX_COMPILER_ID\", \"${CMAKE_CXX_COMPILER_ID}\",\"The CXX compiler ID used for building.\"  );
  MAKE_MAP_ENTRY( \"CMAKE_CXX_COMPILER_VERSION\",   \"${CMAKE_CXX_COMPILER_VERSION}\",
                                                                          \"The CXX compiler version used for building.\"  );
  MAKE_MAP_ENTRY( \"CMAKE_CXX_COMPILER\",    \"${CMAKE_CXX_COMPILER}\",   \"The CXX compiler.\"                       );
  MAKE_MAP_ENTRY( \"CMAKE_CXX_FLAGS\",       \"${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_${CMAKE_BUILD_TYPE}}\",
                                                                          \"The CXX compiler flags.\"                 );
")

configure_file(itkBuildInformation.cxx.in ${CTK_BINARY_DIR}/itkBuildInformation.cxx)

set(KIT_export_directive "MBILOG_EXPORT")

# Target libraries - See CMake/ctkFunctionGetTargetLibraries.cmake
# The following macro will read the target libraries from the file 'target_libraries.cmake'
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
  #GENERATE_EXPORT_HEADER TRUE
  )

  #-----------------------------------------------------------------------------
# Choose a directory for the generated headers.
#[[
if(NOT KWSYS_HEADER_ROOT)
set(KWSYS_HEADER_ROOT "${PROJECT_BINARY_DIR}")
endif()
set(KWSYS_HEADER_DIR "${KWSYS_HEADER_ROOT}/${KWSYS_NAMESPACE}")
include_directories(${KWSYS_HEADER_ROOT})
]]

target_link_libraries(${PROJECT_NAME} itksys)