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

  itkLightObject.h
  itkSingleton.h
  itkSingletonMacro.h
  itkIntTypes.h
  itkObjectFactory.h
  itkObjectFactoryBase.h
  itkCreateObjectFunction.h
  itkObject.h
  itkEventObject.h
  itkCommand.h
  itkIndent.h
  itkMetaDataDictionary.h
  itkMetaDataObjectBase.h
  itkCommonEnums.h
  # ITK Mutext related stuff
  itkSimpleFastMutexLock.h
  itkWindows.h
  itkOutputWindow.h

  itkThreadSupport.h
  itkPoolMultiThreader.h
  itkMultiThreaderBase.h
  itkThreadPool.h
  itkNumericTraits.h

  itkFixedArray.h
  itkFixedArray.hxx
  itkNumericTraitsFixedArrayPixel.h
  itkPixelTraits.h
  itkVector.h
  itkVector.hxx
  itkRegion.h
  itkImageRegion.h
  itkImageRegion.hxx
  itkConceptChecking.h
  itkMath.h
  itkMathDetail.h
  itkSize.h
  itkContinuousIndex.h

  itkPoint.h
  itkPoint.hxx
  itkNumericTraitsPointPixel.h

  itkVersion.h
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
  itkExceptionObject.cxx
  itkLightObject.cxx
  itkSingleton.cxx
  itkObject.cxx
  itkEventObject.cxx
  itkCommand.cxx
  itkIndent.cxx
  itkMetaDataDictionary.cxx
  itkMetaDataObjectBase.cxx

  itkNumericTraits.cxx
  itkThreadPool.cxx
  itkMultiThreaderBase.cxx

  itkOutputWindow.cxx
  itkThreadPool.cxx

  itkRegion.cxx
  itkMath.cxx
  itkNumericTraitsPointPixel.cxx
  itkNumericTraitsFixedArrayPixel.cxx
  itkVector.cxx

  itkVersion.cxx

)


if(WIN32)
  list(APPEND KIT_SRCS itkWin32OutputWindow.cxx)
endif()
if(ITK_USE_WIN32_THREADS OR ITK_USE_PTHREADS)
  list(APPEND KIT_SRCS itkPoolMultiThreader.cxx itkThreadPool.cxx)
endif()