project(org_mitk_core_services)

set(PLUGIN_export_directive "MITK_CORE_SERVICES_PLUGIN")

include("${CMAKE_CURRENT_LIST_DIR}/files.cmake")

ctkFunctionGetTargetLibraries(PLUGIN_target_libraries)

ctkMacroBuildPlugin(
  NAME ${PROJECT_NAME}
  EXPORT_DIRECTIVE ${PLUGIN_export_directive}
  SRCS ${PLUGIN_SRCS}
  MOC_SRCS ${PLUGIN_MOC_SRCS}
  TARGET_LIBRARIES ${PLUGIN_target_libraries}
  EXPORTED_INCLUDE_SUFFIXES
    src
)

#[[
mitk_create_plugin(
  EXPORT_DIRECTIVE MITK_CORE_SERVICES_PLUGIN
  EXPORTED_INCLUDE_SUFFIXES src
  MODULE_DEPENDS PUBLIC MitkCore
)]]