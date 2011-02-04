/*=============================================================================

  Library: CTK

  Copyright (c) German Cancer Research Center,
    Division of Medical and Biological Informatics

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

=============================================================================*/

#include "ctkDicomAppHostingTypesHelper.h"

#include <stdexcept>

ctkDicomSoapRectangle::ctkDicomSoapRectangle(const QString& name,const QRect& rect)
  : QtSoapStruct(QtSoapQName(name))
{
  this->insert(new QtSoapSimpleType(QtSoapQName("Height"),
                                    rect.height()));
  this->insert(new QtSoapSimpleType(QtSoapQName("Width"),
                                    rect.width()));
  this->insert(new QtSoapSimpleType(QtSoapQName("RefPointX"),
                                    rect.x()));
  this->insert(new QtSoapSimpleType(QtSoapQName("RefPointY"),
                                    rect.y()));
}

QRect ctkDicomSoapRectangle::getQRect(const QtSoapType& type)
{
  return QRect (type["RefPointX"].value().toInt(),
                type["RefPointY"].value().toInt(),
                type["Width"].value().toInt(),
                type["Height"].value().toInt());
}


ctkDicomSoapState::ctkDicomSoapState(const QString& name, ctkDicomAppHosting::State s )
  : QtSoapSimpleType(QtSoapQName(name), toStringValue(s))
{}

ctkDicomAppHosting::State ctkDicomSoapState::getState(const QtSoapType& type)
{
  return fromString( type.value().toString() );
}

ctkDicomAppHosting::State ctkDicomSoapState::fromString(const QString& string)
{
  if (string == "IDLE") return ctkDicomAppHosting::IDLE;
  if (string == "INPROGRESS") return ctkDicomAppHosting::INPROGRESS;
  if (string == "COMPLETED") return ctkDicomAppHosting::COMPLETED;
  if (string == "SUSPENDED") return ctkDicomAppHosting::SUSPENDED;
  if (string == "CANCELED") return ctkDicomAppHosting::CANCELED;
  if (string == "EXIT") return ctkDicomAppHosting::EXIT;
  throw std::runtime_error((string + "Invalid STATE:").toStdString());
  return ctkDicomAppHosting::EXIT;
}

QString ctkDicomSoapState::toStringValue(ctkDicomAppHosting::State state)
{
  switch(state)
  {
  case ctkDicomAppHosting::IDLE:
    return "IDLE";
  case ctkDicomAppHosting::INPROGRESS:
    return "INPROGRESS";
  case ctkDicomAppHosting::COMPLETED:
    return "COMPLETED";
  case ctkDicomAppHosting::SUSPENDED:
    return "SUSPENDED";
  case ctkDicomAppHosting::CANCELED:
    return "CANCELED";
  case ctkDicomAppHosting::EXIT:
    return "EXIT";
  default:
    throw std::runtime_error( "Invalid value for state" );

  }
}


ctkDicomSoapStatus::ctkDicomSoapStatus(const QString& name,
                                       const ctkDicomAppHosting::Status& s)
  : QtSoapStruct(QtSoapQName(name))
{
  this->insert(new QtSoapSimpleType(QtSoapQName("StatusType"),
                                    s.statusType) );
  this->insert(new QtSoapSimpleType(
                 QtSoapQName("CodingSchemeDesignator"),
                 s.codingSchemeDesignator) );
  this->insert(new QtSoapSimpleType(
                 QtSoapQName("CodeValue"),
                 s.codeValue) );
  this->insert(new QtSoapSimpleType(
                 QtSoapQName("CodeMeaning"),
                 s.codeMeaning) );
}

ctkDicomAppHosting::Status ctkDicomSoapStatus::getStatus(const QtSoapType& type)
{
  ctkDicomAppHosting::Status s;

  s.statusType = static_cast<ctkDicomAppHosting::StatusType>
      (type["StatusType"].value().toInt());
  s.codingSchemeDesignator =
      type["CodingSchemeDesignator"].value().toString();
  s.codeValue =
      type["CodeValue"].value().toString();
  s.codeMeaning =
      type["CodeMeaning"].value().toString();
  return s;
}


ctkDicomSoapUID::ctkDicomSoapUID(const QString& name, const QString& uid)
  : QtSoapSimpleType(QtSoapQName(name), uid)
{}

QString ctkDicomSoapUID::getUID(const QtSoapType& type)
{
  return type.value().toString();
}


ctkDicomSoapBool::ctkDicomSoapBool(const QString& name, bool boolean)
  : QtSoapSimpleType(QtSoapQName(name), boolean)
{}

bool ctkDicomSoapBool::getBool(const QtSoapType& type)
{
  return  type.value().toBool();
}


ctkDicomSoapArrayOfStringType::ctkDicomSoapArrayOfStringType(const QString& typeName,
                                                             const QString& name, const QStringList& array)
  : QtSoapArray(QtSoapQName(name), QtSoapType::String, array.size())
{
  for (QStringList::ConstIterator it = array.constBegin();
       it < array.constEnd(); it++)
  {
    this->append(new QtSoapSimpleType(QtSoapQName(typeName),*it));
  }
}

QStringList ctkDicomSoapArrayOfStringType::getArray(const QtSoapArray& array)
{
  QStringList list;
  for (int i = 0; i < array.count() ; i++)
  {
    const QString str = array.at(i).value().toString();
    list << str;
  }
  return list;
}


ctkDicomSoapArrayOfUUIDS::ctkDicomSoapArrayOfUUIDS(const QString& name, const QList<QUuid>& array)
  : QtSoapArray(QtSoapQName(name), QtSoapType::String, array.size())
{
  for (QList<QUuid>::ConstIterator it = array.constBegin();
       it < array.constEnd(); it++)
  {
    this->append(new QtSoapSimpleType(QtSoapQName("UUID"),(*it).toString()));
  }
}

QList<QUuid> ctkDicomSoapArrayOfUUIDS::getArray(const QtSoapArray& array)
{
  QList<QUuid> list;
  for (int i = 0; i < array.count() ; i++)
  {
    const QString str = array.at(i).value().toString();
    list << QUuid(str);
  }
  return list;
}


ctkDicomSoapObjectDescriptor::ctkDicomSoapObjectDescriptor(const QString& name,
                                                           const ctkDicomAppHosting::ObjectDescriptor& od)
  : QtSoapStruct(QtSoapQName(name))
{
  this->insert(new QtSoapSimpleType(QtSoapQName("DescriptorUUID"),
                                    od.descriptorUUID) );
  this->insert(new QtSoapSimpleType(
                 QtSoapQName("MimeType"),
                 od.mimeType) );
  this->insert(new QtSoapSimpleType(
                 QtSoapQName("ClassUID"),
                 od.classUID) );
  this->insert(new QtSoapSimpleType(
                 QtSoapQName("TransferSyntaxUID"),
                 od.transferSyntaxUID) );
  this->insert(new QtSoapSimpleType(
                 QtSoapQName("Modality"),
                 od.modality) );
}

ctkDicomAppHosting::ObjectDescriptor ctkDicomSoapObjectDescriptor::getObjectDescriptor(const QtSoapType& type)
{
  ctkDicomAppHosting::ObjectDescriptor od;

  od.descriptorUUID = QUuid(type["DescriptorUUID"].value().toString());
  od.mimeType =
      type["MimeType"].value().toString();
  od.classUID =
      type["ClassUID"].value().toString();
  od.transferSyntaxUID =
      type["TransferSyntaxUID"].value().toString();
  od.modality =
      type["Modality"].value().toString();
  return od;
}


ctkDicomSoapSeries::ctkDicomSoapSeries(const QString& name,
                                       const ctkDicomAppHosting::Series& s)
  : QtSoapStruct(QtSoapQName(name))
{
  this->insert(new QtSoapSimpleType(QtSoapQName("SeriesUID"),
                                    s.seriesUID) );
  QtSoapArray* odescriptors = new QtSoapArray(QtSoapQName("ObjectDescriptors"), QtSoapType::Other,
                                              s.objectDescriptors.size());

  for (QList<ctkDicomAppHosting::ObjectDescriptor>::ConstIterator it = s.objectDescriptors.constBegin();
       it < s.objectDescriptors.constEnd(); it++)
  {
    odescriptors->append(new ctkDicomSoapObjectDescriptor("ObjectDescriptor",*it));
  }
  this->insert(odescriptors);
}

ctkDicomAppHosting::Series ctkDicomSoapSeries::getSeries(const QtSoapType& type)
{
  ctkDicomAppHosting::Series s;

  s.seriesUID = type["SeriesUID"].value().toString();
  QList<ctkDicomAppHosting::ObjectDescriptor> list;
  const QtSoapArray& array = static_cast<const QtSoapArray&>(type["ObjectDescriptors"]);
  for (int i = 0; i < array.count(); i++)
  {
    const ctkDicomAppHosting::ObjectDescriptor od =
        ctkDicomSoapObjectDescriptor::getObjectDescriptor(array.at(i));
    list.append(od);
  }
  s.objectDescriptors = list;
  return s;
}


ctkDicomSoapStudy::ctkDicomSoapStudy(const QString& name,
                                     const ctkDicomAppHosting::Study& s)
  : QtSoapStruct(QtSoapQName(name))
{
  this->insert(new QtSoapSimpleType(QtSoapQName("StudyUID"),
                                    s.studyUID) );
  QtSoapArray* odescriptors = new QtSoapArray(QtSoapQName("ObjectDescriptors"), QtSoapType::Other,
                                              s.objectDescriptors.size());

  for (QList<ctkDicomAppHosting::ObjectDescriptor>::ConstIterator it = s.objectDescriptors.constBegin();
       it < s.objectDescriptors.constEnd(); it++)
  {
    odescriptors->append(new ctkDicomSoapObjectDescriptor("ObjectDescriptor", *it));
  }
  this->insert(odescriptors);

  QtSoapArray* series = new QtSoapArray(QtSoapQName("Series"), QtSoapType::Other,
                                        s.series.size());

  for (QList<ctkDicomAppHosting::Series>::ConstIterator it = s.series.constBegin();
       it < s.series.constEnd(); it++)
  {
    series->append(new ctkDicomSoapSeries("Series",*it));
  }
  this->insert(series);
}

ctkDicomAppHosting::Study ctkDicomSoapStudy::getStudy(const QtSoapType& type)
{
  ctkDicomAppHosting::Study s;

  s.studyUID = type["StudyUID"].value().toString();
  QList<ctkDicomAppHosting::ObjectDescriptor> list;
  const QtSoapArray& array = static_cast<const QtSoapArray&>(type["ObjectDescriptors"]);
  for (int i = 0; i < array.count() ; i++)
  {
    const ctkDicomAppHosting::ObjectDescriptor od =
        ctkDicomSoapObjectDescriptor::getObjectDescriptor(array.at(i));
    list.append(od);
  }
  s.objectDescriptors = list;
  QList<ctkDicomAppHosting::Series> listSeries;
  const QtSoapArray& array2 = static_cast<const QtSoapArray&>(type["Series"]);
  for (int i = 0; i < array2.count() ; i++)
  {
    const ctkDicomAppHosting::Series series =
        ctkDicomSoapSeries::getSeries(array2.at(i));
    listSeries.append(series);
  }
  s.series = listSeries;

  return s;
}


ctkDicomSoapPatient::ctkDicomSoapPatient(const QString& name,
                                         const ctkDicomAppHosting::Patient& p)
  : QtSoapStruct(QtSoapQName(name))
{
  this->insert(new QtSoapSimpleType(QtSoapQName("Name"),
                                    p.name) );
  this->insert(new QtSoapSimpleType(QtSoapQName("ID"),
                                    p.id) );
  this->insert(new QtSoapSimpleType(QtSoapQName("AssigningAuthority"),
                                    p.assigningAuthority) );
  this->insert(new QtSoapSimpleType(QtSoapQName("Sex"),
                                    p.sex) );
  this->insert(new QtSoapSimpleType(QtSoapQName("BirthDate"),
                                    p.birthDate) );
  QtSoapArray* odescriptors = new QtSoapArray(QtSoapQName("ObjectDescriptors"), QtSoapType::Other,
                                              p.objectDescriptors.size());

  for (QList<ctkDicomAppHosting::ObjectDescriptor>::ConstIterator it = p.objectDescriptors.constBegin();
       it < p.objectDescriptors.constEnd(); it++)
  {
    odescriptors->append(new ctkDicomSoapObjectDescriptor("ObjectDescriptor",*it));
  }
  this->insert(odescriptors);

  QtSoapArray* study = new QtSoapArray(QtSoapQName("Studies"), QtSoapType::Other,
                                       p.studies.size());

  for (QList<ctkDicomAppHosting::Study>::ConstIterator it = p.studies.constBegin();
       it < p.studies.constEnd(); it++)
  {
    study->append(new ctkDicomSoapStudy("Study",*it));
  }
  this->insert(study);
}

ctkDicomAppHosting::Patient ctkDicomSoapPatient::getPatient(const QtSoapType& type)
{
  ctkDicomAppHosting::Patient p;

  p.name = type["Name"].value().toString();
  p.id = type["ID"].value().toString();
  p.assigningAuthority = type["AssigningAuthority"].value().toString();
  p.sex = type["Sex"].value().toString();
  p.birthDate = type["Birthdate"].value().toString();

  QList<ctkDicomAppHosting::ObjectDescriptor> list;
  const QtSoapArray& array = static_cast<const QtSoapArray&> (type["ObjectDescriptors"]);
  for (int i = 0; i < array.count() ; i++)
  {
    const ctkDicomAppHosting::ObjectDescriptor od =
        ctkDicomSoapObjectDescriptor::getObjectDescriptor(array.at(i));
    list.append(od);
  }

  p.objectDescriptors = list;
  QList<ctkDicomAppHosting::Study> listPatient;
  const QtSoapArray& array2 = static_cast<const QtSoapArray&>(type["Studies"]);
  for (int i = 0; i < array2.count() ; i++)
  {
    const ctkDicomAppHosting::Study study =
        ctkDicomSoapStudy::getStudy(array2.at(i));
    listPatient.append(study);
  }

  p.studies = listPatient;
  return p;
}


ctkDicomSoapAvailableData::ctkDicomSoapAvailableData(const QString& name,
                                                     const ctkDicomAppHosting::AvailableData& ad)
  : QtSoapStruct(QtSoapQName(name))
{
  QtSoapArray* odescriptors = new QtSoapArray(QtSoapQName("ObjectDescriptors"), QtSoapType::Other,
                                              ad.objectDescriptors.size());

  for (QList<ctkDicomAppHosting::ObjectDescriptor>::ConstIterator it = ad.objectDescriptors.constBegin();
       it < ad.objectDescriptors.constEnd(); it++)
  {
    odescriptors->append(new ctkDicomSoapObjectDescriptor("ObjectDescriptor",*it));
  }
  this->insert(odescriptors);

  QtSoapArray* patient = new QtSoapArray(QtSoapQName("Patient") ,QtSoapType::Other,
                                         ad.patients.size());

  for (QList<ctkDicomAppHosting::Patient>::ConstIterator it = ad.patients.constBegin();
       it < ad.patients.constEnd(); it++){
    patient->append(new ctkDicomSoapPatient("Patient",*it));
  }
  this->insert(patient);
}

ctkDicomAppHosting::AvailableData ctkDicomSoapAvailableData::getAvailableData (const QtSoapType& type)
{
  ctkDicomAppHosting::AvailableData ad;

  QList<ctkDicomAppHosting::ObjectDescriptor> list;
  const QtSoapArray& array = static_cast<const QtSoapArray&> (type["ObjectDescriptors"]);
  for (int i = 0; i < array.count() ; i++)
  {
    const ctkDicomAppHosting::ObjectDescriptor od =
        ctkDicomSoapObjectDescriptor::getObjectDescriptor(array.at(i));
    list.append(od);
  }
  ad.objectDescriptors = list;
  QList<ctkDicomAppHosting::Patient> listPatients;
  const QtSoapArray& array2 = static_cast<const QtSoapArray&>(type["Patients"]);
  for (int i = 0; i < array2.count() ; i++)
  {
    const ctkDicomAppHosting::Patient patient =
        ctkDicomSoapPatient::getPatient(array2.at(i));
    listPatients.append(patient);
  }
  ad.patients = listPatients;
  return ad;
}


ctkDicomSoapObjectLocator::ctkDicomSoapObjectLocator(const QString& name,
                                                     const ctkDicomAppHosting::ObjectLocator& ol)
  : QtSoapStruct(QtSoapQName(name))
{
  this->insert(new QtSoapSimpleType(QtSoapQName("Locator"),
                                    ol.locator) );
  this->insert(new QtSoapSimpleType(
                 QtSoapQName("Source"),
                 ol.source) );
  this->insert(new QtSoapSimpleType(
                 QtSoapQName("TransfertSyntax"),
                 ol.transferSyntax) );
  this->insert(new QtSoapSimpleType(
                 QtSoapQName("Length"),
                 ol.length) );
  this->insert(new QtSoapSimpleType(
                 QtSoapQName("Offset"),
                 ol.offset) );
  this->insert(new QtSoapSimpleType(
                 QtSoapQName("URI"),
                 ol.URI) );
}

ctkDicomAppHosting::ObjectLocator ctkDicomSoapObjectLocator::getObjectLocator(const QtSoapType& type)
{
  ctkDicomAppHosting::ObjectLocator ol;

  ol.locator = QUuid(type["Locator"].value().toString());
  ol.source = QUuid(type["Source"].value().toString());
  ol.transferSyntax =
      type["TransferSyntax"].value().toString();
  ol.length =
      type["Length"].value().toInt();
  ol.offset =
      type["Offset"].value().toInt();
  ol.URI =
      type["URI"].value().toString();
  return ol;
}


ctkDicomSoapArrayOfObjectLocators::ctkDicomSoapArrayOfObjectLocators(
  const QString& name, const QList<ctkDicomAppHosting::ObjectLocator>& array)
  : QtSoapArray(QtSoapQName(name), QtSoapType::String, array.size())
{
  for (QList<ctkDicomAppHosting::ObjectLocator>::ConstIterator it = array.constBegin();
       it < array.constEnd(); it++)
  {
    this->append(new ctkDicomSoapObjectLocator("objectLocator",(*it)));
  }
}

QList<ctkDicomAppHosting::ObjectLocator> ctkDicomSoapArrayOfObjectLocators::getArray(const QtSoapArray& array)
{
  QList<ctkDicomAppHosting::ObjectLocator> list;

  for (int i = 0; i < array.count() ; i++)
  {
    const ctkDicomAppHosting::ObjectLocator ol =
        ctkDicomSoapObjectLocator::getObjectLocator(array.at(i));
    list << ol;
  }
  return list;
}

