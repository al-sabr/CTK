set(DOCUMENTATION "This module contains the third party <a
href=\"http://vxl.sourceforge.net\">VNL</a> numeric library from the VXL vision
library suite.")

itk_module(ITKVNL
  DESCRIPTION
    "${DOCUMENTATION}"
)

set(${itk-module}-targets ${itk-module}Targets)
set(${itk-module}-targets-install "\${ITK_INSTALL_PREFIX}/${ITK_INSTALL_PACKAGE_DIR}/Modules/Targets/${itk-module}Targets.cmake")
set(${itk-module}_TARGETS_FILE_INSTALL "${${itk-module}-targets-install}")
#set(${itk-module}-targets-build-directory "${ITK_DIR}/${ITK_INSTALL_PACKAGE_DIR}/Modules/Targets")
set(${itk-module}-targets-build-directory "${CTK_SOURCE_DIR}/${ITK_INSTALL_PACKAGE_DIR}/Modules/Targets")
file(MAKE_DIRECTORY ${${itk-module}-targets-build-directory})
set(${itk-module}-targets-build "${${itk-module}-targets-build-directory}/${itk-module}Targets.cmake")