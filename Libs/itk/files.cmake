set(KIT_MOC_SRCS

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
  itkDataObject.h
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
  itkWeakPointer.h
  itkRealTimeStamp.h
  itkRealTimeInterval.h

  itkFixedArray.h
  itkFixedArray.hxx
  itkNumericTraitsFixedArrayPixel.h
  itkPixelTraits.h
  itkVector.h
  itkVector.hxx
  itkRegion.h
  itkImageRegion.h
  itkImageSourceCommon.h
  itkImageRegionSplitterBase.h
  itkImageRegionSplitterSlowDimension.h
  itkImageIORegion.h
  
  itkProcessObject.h
  itkConceptChecking.h
  itkMath.h
  itkMathDetail.h
  itkSize.h
  itkContinuousIndex.h

  itkPoint.h
  itkPoint.hxx
  itkNumericTraitsPointPixel.h

  itkVersion.h
  itkTotalProgressReporter.h
  itkPlatformMultiThreader.h

  itkDirectory.h
  itkNumericTraitsVectorPixel.h
  itkIndex.h
  itkProgressReporter.h
)

set(KIT_SRCS
  # ITK Mutex related stuff
  itkSimpleFastMutexLock.cxx
  itkExceptionObject.cxx
  itkLightObject.cxx
  itkSingleton.cxx
  itkObject.cxx
  itkObjectFactoryBase.cxx
  itkDataObject.cxx
  itkEventObject.cxx
  itkCommand.cxx
  itkIndent.cxx
  itkMetaDataDictionary.cxx
  itkMetaDataObjectBase.cxx

  itkNumericTraits.cxx
  itkThreadPool.cxx
  itkMultiThreaderBase.cxx
  itkRealTimeStamp.cxx
  itkRealTimeInterval.cxx

  itkOutputWindow.cxx
  itkThreadPool.cxx

  itkRegion.cxx
  itkMath.cxx
  itkNumericTraitsPointPixel.cxx
  itkNumericTraitsFixedArrayPixel.cxx
  itkVector.cxx

  itkVersion.cxx
  ${CTK_BINARY_DIR}/itkBuildInformation.cxx

  itkTotalProgressReporter.cxx
  itkPlatformMultiThreader.cxx
  
  itkImageSourceCommon.cxx
  itkImageRegionSplitterBase.cxx
  itkImageIORegion.cxx
  itkImageRegionSplitterSlowDimension.cxx
  itkProcessObject.cxx

  itkDirectory.cxx
  itkNumericTraitsVectorPixel.cxx
  itkProgressReporter.cxx
)


if(WIN32)
  list(APPEND KIT_SRCS itkWin32OutputWindow.cxx)
endif()
if(ITK_USE_WIN32_THREADS OR ITK_USE_PTHREADS)
  list(APPEND KIT_SRCS itkPoolMultiThreader.cxx itkThreadPool.cxx)
endif()

if(ITK_DYNAMIC_LOADING)
  list(APPEND KIT_SRCS itkDynamicLoader.cxx)
endif()

if(ITK_USE_TBB)
  list(APPEND KIT_SRCS itkTBBMultiThreader.cxx)
endif()