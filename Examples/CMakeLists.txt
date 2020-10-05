set(CTK_DEFAULT_SUBPROJECTS CTK-Examples)



#-----------------------------------------------------------------------------
# Add example executables
#-----------------------------------------------------------------------------

set(CTK_DIR ${PROJECT_BINARY_DIR})
set(CTK_EXPORTS_FILE_INCLUDED 1)

set(_example_dirs
  MbiLog
)

foreach(_example_dir ${_example_dirs})
  add_subdirectory(${_example_dir})
endforeach()
