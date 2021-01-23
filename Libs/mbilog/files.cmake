set(KIT_MOC_SRCS
  mbilog.h
  mbilogLoggingTypes.h
  mbilogTextDictionary.h
  #mbilogExport.h
  mbilogLogMessage.h
  mbilogBackendBase.h
  mbilogTextBackendBase.h
  mbilogBackendCout.h

  # Adding MITK logging system headers.
  mitkLog.h
  mitkLogMacros.h
  mitkException.h
  mitkExceptionMacros.h

  # ITK
  itkMacro.h
  itkExceptionObject.h
  itkSmartPointer.h
  itkWin32Header.h

  # ITK Mutext related stuff
  itkSimpleFastMutexLock.h
  itkThreadSupport.h
  itkWindows.h
)

set(KIT_SRCS
  mbilog.cpp
  mbilogLogMessage.cpp
  mbilogBackendCout.cpp
  mbilogBackendBase.cpp
  mbilogTextBackendBase.cpp

  mitkException.cpp
  mitkLog.cpp

  # ITK Mutex related stuff
  itkSimpleFastMutexLock.cxx
)
