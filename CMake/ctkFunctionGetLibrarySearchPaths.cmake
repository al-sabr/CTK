#! Helper function that gets all library search paths.
#!
#! Usage:
#!
#!   mitkFunctionGetLibrarySearchPaths(search_path intermediate_dir [DEBUG|MINSIZEREL|RELWITHDEBINFO])
#!
#!
#! The function creates the variable ${search_path}. The variable intermediate_dir contains
#! paths that should be added to the search_path but should not be checked for existance,
#! because the are not yet created. The option DEBUG, MINSIZEREL or RELWITHDEBINFO can be used to indicate that
#! not the paths for release configuration are requested but the debug, min size release or "release with debug info"
#! paths.
#!

function(ctkFunctionGetLibrarySearchPaths search_path intermediate_dir)

  cmake_parse_arguments(PARSE_ARGV 2 GLS "RELEASE;DEBUG;MINSIZEREL;RELWITHDEBINFO" "" "")
  
  # HOW TO CONVERT THIS TO CTK?
  #[[
  set(_dir_candidates
      "${MITK_CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
      "${MITK_CMAKE_RUNTIME_OUTPUT_DIRECTORY}/plugins"
      "${MITK_CMAKE_LIBRARY_OUTPUT_DIRECTORY}"
      "${MITK_CMAKE_LIBRARY_OUTPUT_DIRECTORY}/plugins"
     )

  if(MITK_EXTERNAL_PROJECT_PREFIX)
    list(APPEND _dir_candidates
         "${CTK_EXTERNAL_PROJECT_PREFIX}/bin"
         "${CTK_EXTERNAL_PROJECT_PREFIX}/lib"
        )
  endif()
  ]]

  # Determine the Qt5 library installation prefix
  set(_qmake_location )
  ## if(MITK_USE_Qt5 AND TARGET ${Qt5Core_QMAKE_EXECUTABLE})
  if(Qt5_DIR AND TARGET ${Qt5Core_QMAKE_EXECUTABLE})
    get_property(_qmake_location TARGET ${Qt5Core_QMAKE_EXECUTABLE}
                 PROPERTY IMPORT_LOCATION)
  endif()
  if(_qmake_location)
    if(NOT _qt_install_libs)
      if(WIN32)
        execute_process(COMMAND ${_qmake_location} -query QT_INSTALL_BINS
                        OUTPUT_VARIABLE _qt_install_libs
                        OUTPUT_STRIP_TRAILING_WHITESPACE)
      else()
        execute_process(COMMAND ${_qmake_location} -query QT_INSTALL_LIBS
                        OUTPUT_VARIABLE _qt_install_libs
                        OUTPUT_STRIP_TRAILING_WHITESPACE)
      endif()
      file(TO_CMAKE_PATH "${_qt_install_libs}" _qt_install_libs)
      set(_qt_install_libs ${_qt_install_libs} CACHE INTERNAL "Qt library installation prefix" FORCE)
    endif()
    if(_qt_install_libs)
      list(APPEND _dir_candidates ${_qt_install_libs})
    endif()
  elseif(MITK_USE_Qt5)
    message(WARNING "The qmake executable could not be found.")
  endif()

  get_property(_additional_paths GLOBAL PROPERTY MITK_ADDITIONAL_LIBRARY_SEARCH_PATHS)

  if(TARGET OpenSSL::SSL)
    if(GLS_DEBUG)
      get_target_property(_openssl_location OpenSSL::SSL IMPORTED_LOCATION_DEBUG)
    else()
      get_target_property(_openssl_location OpenSSL::SSL IMPORTED_LOCATION_RELEASE)
    endif()
    if(_openssl_location)
      get_filename_component(_openssl_location ${_openssl_location} DIRECTORY)
      set(_openssl_location "${_openssl_location}/../../bin")
      if(EXISTS ${_openssl_location})
        get_filename_component(_openssl_location ${_openssl_location} ABSOLUTE)
        list(APPEND _dir_candidates ${_openssl_location})
      endif()
    endif()
  endif()

  # How to convert this for CTK?
  #[[
  if(MITK_USE_CTK)
    list(APPEND _dir_candidates "${CTK_LIBRARY_DIRS}")
    foreach(_ctk_library ${CTK_LIBRARIES})
      if(${_ctk_library}_LIBRARY_DIRS)
        list(APPEND _dir_candidates "${${_ctk_library}_LIBRARY_DIRS}")
      endif()
    endforeach()
  endif()
  ]]

  if(USE_BLUEBERRY)
    if(DEFINED CTK_PLUGIN_RUNTIME_OUTPUT_DIRECTORY)
      if(IS_ABSOLUTE "${CTK_PLUGIN_RUNTIME_OUTPUT_DIRECTORY}")
        list(APPEND _dir_candidates "${CTK_PLUGIN_RUNTIME_OUTPUT_DIRECTORY}")
      else()
        list(APPEND _dir_candidates "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${CTK_PLUGIN_RUNTIME_OUTPUT_DIRECTORY}")
      endif()
    endif()
  endif()

  # Do we need this line since CTK_LIBRARY_DIRS is already available in CTK.
  if(CTK_LIBRARY_DIRS)
    list(APPEND _dir_candidates ${CTK_LIBRARY_DIRS})
  endif()
  #[[ MITK code commented and adapted to CTK previously. 
  if(MITK_LIBRARY_DIRS)
    list(APPEND _dir_candidates ${MITK_LIBRARY_DIRS})
  endif()]]#

  ###################################################################
  #get the search paths added by the mitkFunctionAddLibrarySearchPath
  file(GLOB _additional_path_info_files "${CTK_SUPERBUILD_BINARY_DIR}/CTK-AdditionalLibPaths/*.cmake")

  foreach(_additional_path_info_file ${_additional_path_info_files})
    get_filename_component(_additional_info_name ${_additional_path_info_file} NAME_WE)
    include(${_additional_path_info_file})
    if(GLS_DEBUG)
      list(APPEND _dir_candidates ${${_additional_info_name}_ADDITIONAL_DEBUG_LIBRARY_SEARCH_PATHS})
    elseif(GLS_MINSIZEREL)
      list(APPEND _dir_candidates ${${_additional_info_name}_ADDITIONAL_MINSIZEREL_LIBRARY_SEARCH_PATHS})
    elseif(GLS_RELWITHDEBINFO)
      list(APPEND _dir_candidates ${${_additional_info_name}_ADDITIONAL_RELWITHDEBINFO_LIBRARY_SEARCH_PATHS})
    else() #Release
      list(APPEND _dir_candidates ${${_additional_info_name}_ADDITIONAL_RELEASE_LIBRARY_SEARCH_PATHS})
    endif()
  endforeach(_additional_path_info_file ${_additional_path_info_files})


  ###############################################
  #sanitize all candidates and compile final list
  list(REMOVE_DUPLICATES _dir_candidates)

  set(_search_dirs )
  foreach(_dir ${_dir_candidates})
    if(EXISTS "${_dir}/${intermediate_dir}")
      list(APPEND _search_dirs "${_dir}/${intermediate_dir}")
    else()
      list(APPEND _search_dirs "${_dir}")
    endif()
  endforeach()

  # Special handling for "internal" search dirs. The intermediate directory
  # might not have been created yet, so we can't check for its existence.
  # Hence we just add it for Windows without checking.
  set(_internal_search_dirs "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/plugins")
  if(WIN32)
    foreach(_dir ${_internal_search_dirs})
      set(_search_dirs "${_dir}/${intermediate_dir}" ${_search_dirs})
    endforeach()
  else()
    set(_search_dirs ${_internal_search_dirs} ${_search_dirs})
  endif()
  list(REMOVE_DUPLICATES _search_dirs)

  set(${search_path} ${_search_dirs} PARENT_SCOPE)
endfunction()
