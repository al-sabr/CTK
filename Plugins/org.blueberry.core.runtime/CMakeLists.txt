project(org_blueberry_core_runtime)

set(PLUGIN_export_directive "org_blueberry_core_runtime_EXPORT")

include("${CMAKE_CURRENT_LIST_DIR}/files.cmake")

ctkFunctionGetTargetLibraries(PLUGIN_target_libraries)

#[[ 
*** Only one aspect didn't get converted which is the MODULE_DEPENDS
*** 
mitk_create_plugin(
  MODULE_DEPENDS PUBLIC mbilog
)
]]

ctkMacroBuildPlugin(
  NAME ${PROJECT_NAME}
  EXPORT_DIRECTIVE ${PLUGIN_export_directive}
  SRCS ${PLUGIN_SRCS}
  MOC_SRCS ${PLUGIN_MOC_SRCS}
  UI_FORMS ${PLUGIN_UI_FORMS}
  RESOURCES ${PLUGIN_resources}
  TARGET_LIBRARIES ${PLUGIN_target_libraries}
  EXPORTED_INCLUDE_SUFFIXES
    src
    src/application
    src/dynamichelpers
    src/registry
)

# HOW TO ADAPT THIS FOR CTK PLUGIN SYSTEM.
# Uncommenting this line generate an error while configuration.
#target_compile_definitions(${PLUGIN_TARGET} PUBLIC "$<$<PLATFORM_ID:Windows>:POCO_NO_UNWINDOWS;WIN32_LEAN_AND_MEAN>")

configure_file("${CMAKE_CURRENT_SOURCE_DIR}/src/berryConfig.h.in" "${CMAKE_CURRENT_BINARY_DIR}/berryConfig.h" @ONLY)