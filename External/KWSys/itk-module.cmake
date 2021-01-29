set(DOCUMENTATION "This module contains the third party Kitware KWSys library.
KWSys provides a platform-independent API to many common system
features that are implemented differently on every platform.  The
library is intended to be shared among many projects.  For more information, see
Modules/ThirdParty/KWSys/src/README.kwsys.")

itk_module(ITKKWSys
  DESCRIPTION
    "${DOCUMENTATION}"
)



set(${itk-module}-targets ${itk-module}Targets)
set(${itk-module}-targets-install "\${ITK_INSTALL_PREFIX}/${ITK_INSTALL_PACKAGE_DIR}/Modules/Targets/${itk-module}Targets.cmake")
set(${itk-module}_TARGETS_FILE_INSTALL "${${itk-module}-targets-install}")
set(${itk-module}-targets-build-directory "${ITK_DIR}/${ITK_INSTALL_PACKAGE_DIR}/Modules/Targets")
file(MAKE_DIRECTORY ${${itk-module}-targets-build-directory})
set(${itk-module}-targets-build "${${itk-module}-targets-build-directory}/${itk-module}Targets.cmake")

