# Copied from MITK project and changed to fit CTK
function(ctkFunctionInstallProvisioningFiles)
  foreach(file ${ARGN})
    get_filename_component(file_name "${file}" NAME)
    CTK_INSTALL(FILES ${file}.install RENAME "${file_name}")
  endforeach()
endfunction()
