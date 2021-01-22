/*=========================================================================
  *
  *  Copyright NumFOCUS
  *
  *  Licensed under the Apache License, Version 2.0 (the "License");
  *  you may not use this file except in compliance with the License.
  *  You may obtain a copy of the License at
  *
  *         http://www.apache.org/licenses/LICENSE-2.0.txt
  *
  *  Unless required by applicable law or agreed to in writing, software
  *  distributed under the License is distributed on an "AS IS" BASIS,
  *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  *  See the License for the specific language governing permissions and
  *  limitations under the License.
  *
  *=========================================================================*/
  
 #ifndef itkSmartPointer_h
 #define itkSmartPointer_h
  
 #include <iostream>
 #include <utility>
 #include <type_traits>
 //#include "itkConfigure.h"
  
  
 namespace itk
 {
 template <typename TObjectType>
 class SmartPointer
 {
 public:
   using ObjectType = TObjectType;
  
   template <typename T>
   using EnableIfConvertible = typename std::enable_if<std::is_convertible<T *, TObjectType *>::value>;
  
   constexpr SmartPointer() noexcept = default;
  
   SmartPointer(const SmartPointer & p) noexcept
     : m_Pointer(p.m_Pointer)
   {
     this->Register();
   }
  
   constexpr SmartPointer(std::nullptr_t) noexcept {}
  
   template <typename T, typename = typename EnableIfConvertible<T>::type>
   SmartPointer(const SmartPointer<T> & p) noexcept
     : m_Pointer(p.m_Pointer)
   {
     this->Register();
   }
  
   SmartPointer(SmartPointer<ObjectType> && p) noexcept
     : m_Pointer(p.m_Pointer)
   {
     p.m_Pointer = nullptr;
   }
  
   template <typename T, typename = typename EnableIfConvertible<T>::type>
   SmartPointer(SmartPointer<T> && p) noexcept
     : m_Pointer(p.m_Pointer)
   {
     p.m_Pointer = nullptr;
   }
  
   SmartPointer(ObjectType * p) noexcept
     : m_Pointer(p)
   {
     this->Register();
   }
  
   ~SmartPointer() { this->UnRegister(); }
  
   ObjectType * operator->() const noexcept { return m_Pointer; }
  
   ObjectType & operator*() const noexcept { return *m_Pointer; }
  
   explicit operator bool() const noexcept { return m_Pointer != nullptr; }
  
   operator ObjectType *() const noexcept { return m_Pointer; }
  
   bool
   IsNotNull() const noexcept
   {
     return m_Pointer != nullptr;
   }
  
   bool
   IsNull() const noexcept
   {
     return m_Pointer == nullptr;
   }
  
  
   ObjectType *
   GetPointer() const noexcept
   {
     return m_Pointer;
   }
  
   // cppcheck-suppress operatorEqVarError
   SmartPointer &
   operator=(SmartPointer r) noexcept
   {
     // The Copy-Swap idiom is used, with the implicit copy from the
     // value-based argument r (intentionally not reference). If a move
     // is requested it will be moved into r with the move constructor.
     this->Swap(r);
     return *this;
   }
  
   SmartPointer & operator=(std::nullptr_t) noexcept
   {
     this->UnRegister();
     this->m_Pointer = nullptr;
     return *this;
   }
  
   ObjectType *
   Print(std::ostream & os) const
   {
     if (this->IsNull())
     {
       os << "(null)";
     }
     else
     {
       // This prints the object pointed to by the pointer
       (*m_Pointer).Print(os);
     }
     return m_Pointer;
   }
  
 #if !defined(ITK_LEGACY_REMOVE)
   void
   swap(SmartPointer & other) noexcept
   {
     this->Swap(other);
   }
 #endif
  
   void
   Swap(SmartPointer & other) noexcept
   {
     ObjectType * tmp = this->m_Pointer;
     this->m_Pointer = other.m_Pointer;
     other.m_Pointer = tmp;
   }
  
 private:
   ObjectType * m_Pointer{ nullptr };
  
   template <typename T>
   friend class SmartPointer;
  
   void
   Register() noexcept
   {
     if (m_Pointer)
     {
       m_Pointer->Register();
     }
   }
  
   void
   UnRegister() noexcept
   {
     if (m_Pointer)
     {
       m_Pointer->UnRegister();
     }
   }
 };
  
  
 template <class T, class TU>
 bool
 operator==(const SmartPointer<T> & l, const SmartPointer<TU> & r) noexcept
 {
   return (l.GetPointer() == r.GetPointer());
 }
 template <class T>
 bool
 operator==(const SmartPointer<T> & l, std::nullptr_t) noexcept
 {
   return (l.GetPointer() == nullptr);
 }
 template <class T>
 bool
 operator==(std::nullptr_t, const SmartPointer<T> & r) noexcept
 {
   return (nullptr == r.GetPointer());
 }
  
 template <class T, class TU>
 bool
 operator!=(const SmartPointer<T> & l, const SmartPointer<TU> & r) noexcept
 {
   return (l.GetPointer() != r.GetPointer());
 }
 template <class T>
 bool
 operator!=(const SmartPointer<T> & l, std::nullptr_t) noexcept
 {
   return (l.GetPointer() != nullptr);
 }
 template <class T>
 bool
 operator!=(std::nullptr_t, const SmartPointer<T> & r) noexcept
 {
   return (nullptr != r.GetPointer());
 }
  
  
 template <class T, class TU>
 bool
 operator<(const SmartPointer<T> & l, const SmartPointer<TU> & r) noexcept
 {
   return (l.GetPointer() < r.GetPointer());
 }
  
 template <class T, class TU>
 bool
 operator>(const SmartPointer<T> & l, const SmartPointer<TU> & r) noexcept
 {
   return (l.GetPointer() > r.GetPointer());
 }
  
 template <class T, class TU>
 bool
 operator<=(const SmartPointer<T> & l, const SmartPointer<TU> & r) noexcept
 {
   return (l.GetPointer() <= r.GetPointer());
 }
  
 template <class T, class TU>
 bool
 operator>=(const SmartPointer<T> & l, const SmartPointer<TU> & r) noexcept
 {
   return (l.GetPointer() >= r.GetPointer());
 }
  
 template <typename T>
 std::ostream &
 operator<<(std::ostream & os, const SmartPointer<T> p)
 {
   p.Print(os);
   return os;
 }
  
 template <typename T>
 inline void
 swap(SmartPointer<T> & a, SmartPointer<T> & b) noexcept
 {
   a.Swap(b);
 }
  
 } // end namespace itk
  
 #endif