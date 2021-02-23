set(KIT_MOC_SRCS
  # Adding MITK logging system headers.
  mitkLog.h
  mitkLogMacros.h
  mitkException.h
  mitkExceptionMacros.h

 
)

set(KIT_SRCS
  mitkException.cpp
  mitkLog.cpp

  mitkApplyTransformMatrixOperation.cpp
  
  mitkBaseGeometry.cpp
  mitkBaseProperty.cpp
  mitkColorProperty.cpp
  mitkDataNode.cpp
  mitkDataStorage.cpp
 
  mitkGeometry3D.cpp

  mitkGeometryTransformHolder.cpp
  
  mitkIdentifiable.cpp
  
  mitkIPropertyOwner.cpp
  mitkIPropertyProvider.cpp
 
  mitkLevelWindow.cpp
  
  mitkNumericConstants.cpp
  
  mitkStringProperty.cpp

  mitkVector.cpp
  
  mitkDataInteractor.cpp
  
  mitkEventConfig.cpp
  
  mitkEventStateMachine.cpp
  
  mitkInteractionEventHandler.cpp
  mitkEventConfig.cpp
 
)