#
# KWSYS
#

set(proj KWSYS)

set(${proj}_DEPENDENCIES "")

ExternalProject_Include_Dependencies(${proj}
  PROJECT_VAR proj
  DEPENDS_VAR ${proj}_DEPENDENCIES
  EP_ARGS_VAR ${proj}_EXTERNAL_PROJECT_ARGS
  USE_SYSTEM_VAR ${CMAKE_PROJECT_NAME}_USE_SYSTEM_${proj}
  )

if(${CMAKE_PROJECT_NAME}_USE_SYSTEM_${proj})
  message(FATAL_ERROR "Enabling ${CMAKE_PROJECT_NAME}_USE_SYSTEM_${proj} is not supported !")
endif()

# Sanity checks
if(DEFINED KWSYS_DIR AND NOT EXISTS ${KWSYS_DIR})
  message(FATAL_ERROR "KWSYS_DIR variable is defined but corresponds to non-existing directory")
endif()

if(NOT DEFINED KWSYS_DIR)

  set(revision_tag 6b9c233c4e1b9e15b280886734b7a992b003428b)
  if(${proj}_REVISION_TAG)
    set(revision_tag ${${proj}_REVISION_TAG})
  endif()

  set(location_args )
  if(${proj}_URL)
    set(location_args URL ${${proj}_URL})
  elseif(${proj}_GIT_REPOSITORY)
    set(location_args GIT_REPOSITORY ${${proj}_GIT_REPOSITORY}
                      GIT_TAG ${revision_tag})
  else()
    set(location_args GIT_REPOSITORY "${EP_GIT_PROTOCOL}://gitlab.kitware.com/utils/kwsys.git"
                      GIT_TAG ${revision_tag})
  endif()

  ExternalProject_Add(${proj}
    ${${proj}_EXTERNAL_PROJECT_ARGS}
    SOURCE_DIR ${CMAKE_BINARY_DIR}/${proj}
    BINARY_DIR ${proj}-build
    PREFIX ${proj}${ep_suffix}
    ${location_args}
    INSTALL_COMMAND ""
    CMAKE_CACHE_ARGS
      ${ep_common_cache_args}
      #-DKWSYS_NAMESPACE:STRING=itksys
      #-DKWSYS_NAMESPACE_ALIAS:STRING=KWSYS::itksys
      -DKWSYS_USE_SystemTools:BOOL=ON
      -DKWSYS_USE_RegularExpression:BOOL=ON
      -DKWSYS_USE_Directory:BOOL=ON
      -DKWSYS_USE_Base64:BOOL=ON
      -DKWSYS_USE_MD5:BOOL=ON
      -DKWSYS_USE_CommandLineArguments:BOOL=ON
      -DKWSYS_USE_Process:BOOL=ON
      -DKWSYS_USE_DynamicLoader:BOOL=OFF
      -DKWSYS_USE_Glob:BOOL=ON
      -DKWSYS_USE_Registry:BOOL=ON
      -DKWSYS_USE_SystemInformation:BOOL=ON
      DEPENDS
        ${${proj}_DEPENDENCIES}
    )
    set(KWSYS_DIR ${CMAKE_BINARY_DIR}/${proj}-build)


else()
  ExternalProject_Add_Empty(${proj} DEPENDS ${${proj}_DEPENDENCIES})
endif()

mark_as_superbuild(
  VARS KWSYS_DIR:PATH
  LABELS "FIND_PACKAGE"
  )
