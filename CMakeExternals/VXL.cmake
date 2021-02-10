#
# VXL
#

set(proj VXL)

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
if(DEFINED VXL_DIR AND NOT EXISTS ${VXL})
  message(FATAL_ERROR "VXL_DIR variable is defined but corresponds to non-existing directory")
endif()

if(NOT DEFINED VXL_DIR)

  set(revision_tag faa3fcf45bb6c4374431b42bc3b5ad9ce518dbd8)
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
    set(location_args GIT_REPOSITORY "${EP_GIT_PROTOCOL}://github.com/vxl/vxl.git"
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
      -DVXL_BUILD_EXAMPLES:BOOL=OFF
      -DBUILD_TESTING:BOOL=OFF
      -DVXL_BUILD_CORE_NUMERICS:BOOL=ON
      -DVXL_BUILD_CORE_GEOMETRY:BOOL=OFF
      -DVXL_BUILD_CORE_SERIALISATION:BOOL=ON
      -DVXL_BUILD_CORE_UTILITIES:BOOL=OFF
      -DVXL_BUILD_CORE_IMAGING:BOOL=OFF
      -DVXL_BUILD_CORE_VIDEO:BOOL=OFF
      -DVXL_BUILD_CORE_PROBABILITY:BOOL=OFF
      -DVXL_BUILD_VGUI:BOOL=OFF
      -DVXL_FORCE_V3P_BZLIB2:BOOL=OFF
      -DVXL_USING_NATIVE_BZLIB2:BOOL=TRUE # for disable build built-in bzip2 (v3p/bzlib/CMakeLists.txt#L10-L26)
      -DVXL_FORCE_V3P_CLIPPER:BOOL=ON # TODO : need add clipper port to turn off
      -DVXL_FORCE_V3P_DCMTK:BOOL=OFF
      -DVXL_FORCE_V3P_GEOTIFF:BOOL=OFF
      -DVXL_FORCE_V3P_J2K:BOOL=OFF
      -DVXL_FORCE_V3P_JPEG:BOOL=OFF
      -DVXL_FORCE_V3P_OPENJPEG2:BOOL=ON # TODO : need fix compile error when using openjpeg port to turn off
      -DVXL_FORCE_V3P_PNG:BOOL=OFF
      -DVXL_FORCE_V3P_TIFF:BOOL=OFF
      -DVXL_FORCE_V3P_ZLIB:BOOL=OFF
      -DVXL_USE_DCMTK:BOOL=OFF # TODO : need fix dcmtk support to turn on
      -DVXL_USE_GEOTIFF:BOOL=ON
      -DVXL_USE_WIN_WCHAR_T:BOOL=${USE_WIN_WCHAR_T}
     DEPENDS
      ${${proj}_DEPENDENCIES}
    )
  set(VXL_DIR ${CMAKE_BINARY_DIR}/${proj}-build)

else()
  ExternalProject_Add_Empty(${proj} DEPENDS ${${proj}_DEPENDENCIES})
endif()

mark_as_superbuild(
  VARS VXL_DIR:PATH
  LABELS "FIND_PACKAGE"
  )
