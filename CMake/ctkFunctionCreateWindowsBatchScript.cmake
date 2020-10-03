function(ctkFunctionCreateWindowsBatchScript in out build_type)

  if(${build_type} STREQUAL "debug")
    ctkFunctionGetLibrarySearchPaths(MITK_RUNTIME_PATH ${build_type} DEBUG)
  else()
    ctkFunctionGetLibrarySearchPaths(MITK_RUNTIME_PATH ${build_type} RELEASE)
  endif()

  set(VS_BUILD_TYPE ${build_type})

  configure_file(${in} ${out} @ONLY)

endfunction()