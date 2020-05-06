/* Copyright (C) 1991-2018 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */
/* This header is separate from features.h so that the compiler can
   include it implicitly at the start of every compilation.  It must
   not itself include <features.h> or any other header that includes
   <features.h> because the implicit include comes before any feature
   test macros that may be defined in a source file before it first
   explicitly includes a system header.  GCC knows the name of this
   header in order to preinclude it.  */
/* glibc's intent is to support the IEC 559 math functionality, real
   and complex.  If the GCC (4.9 and later) predefined macros
   specifying compiler intent are available, use them to determine
   whether the overall intent is to support these features; otherwise,
   presume an older compiler has intent to support these features and
   define these macros by default.  */
/* wchar_t uses Unicode 10.0.0.  Version 10.0 of the Unicode Standard is
   synchronized with ISO/IEC 10646:2017, fifth edition, plus
   the following additions from Amendment 1 to the fifth edition:
   - 56 emoji characters
   - 285 hentaigana
   - 3 additional Zanabazar Square characters */
/* We do not support C11 <threads.h>.  */
! $Id$
!
! Earth System Modeling Framework
! Copyright 2002-2018, University Corporation for Atmospheric Research,
! Massachusetts Institute of Technology, Geophysical Fluid Dynamics
! Laboratory, University of Michigan, National Centers for Environmental
! Prediction, Los Alamos National Laboratory, Argonne National Laboratory,
! NASA Goddard Space Flight Center.
! Licensed under the University of Illinois-NCSA License.
!
!==============================================================================
#define ESMF_FILENAME "ESMF_LocalArrayWrapperType.F90"
!==============================================================================
!
! ESMF LocalArrayWrapperType module
module ESMF_LocalArrayWrapperTypeMod
!
!==============================================================================
!
! This file contains the LocalArrayWrapper type
!
!------------------------------------------------------------------------------
! INCLUDES
! < ignore blank lines below. they are created by the files which
! define various macros. >
#include "ESMF.h"
! !USES:
  use ESMF_UtilTypesMod ! ESMF utility types
  implicit none
!------------------------------------------------------------------------------
! !PUBLIC TYPES:
  public
!------------------------------------------------------------------------------
  ! Internal wrapper structures for passing f90 pointers to C++ and
  ! guaranteeing they are passed by reference on all compilers and all
  ! platforms. These are never seen outside this module.
  ! < these expand into defined type declarations >

#ifndef ESMF_NO_INTEGER_1_BYTE 
#ifndef PIO_TKR 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap1DI1 
 integer (ESMF_KIND_I1),dimension(:),pointer :: ptr1DI1 
 end type ESMF_LAWrap1DI1 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap2DI1 
 integer (ESMF_KIND_I1),dimension(:,:),pointer :: ptr2DI1 
 end type ESMF_LAWrap2DI1 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap3DI1 
 integer (ESMF_KIND_I1),dimension(:,:,:),pointer :: ptr3DI1 
 end type ESMF_LAWrap3DI1 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap4DI1 
 integer (ESMF_KIND_I1),dimension(:,:,:,:),pointer :: ptr4DI1 
 end type ESMF_LAWrap4DI1 
 
#ifndef ESMF_NO_GREATER_THAN_4D 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap5DI1 
 integer (ESMF_KIND_I1),dimension(:,:,:,:,:),pointer :: ptr5DI1 
 end type ESMF_LAWrap5DI1 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap6DI1 
 integer (ESMF_KIND_I1),dimension(:,:,:,:,:,:),pointer :: ptr6DI1 
 end type ESMF_LAWrap6DI1 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap7DI1 
 integer (ESMF_KIND_I1),dimension(:,:,:,:,:,:,:),pointer :: ptr7DI1 
 end type ESMF_LAWrap7DI1 
 
#endif 
#endif 
#endif 
#ifndef ESMF_NO_INTEGER_2_BYTE 
#ifndef PIO_TKR 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap1DI2 
 integer (ESMF_KIND_I2),dimension(:),pointer :: ptr1DI2 
 end type ESMF_LAWrap1DI2 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap2DI2 
 integer (ESMF_KIND_I2),dimension(:,:),pointer :: ptr2DI2 
 end type ESMF_LAWrap2DI2 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap3DI2 
 integer (ESMF_KIND_I2),dimension(:,:,:),pointer :: ptr3DI2 
 end type ESMF_LAWrap3DI2 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap4DI2 
 integer (ESMF_KIND_I2),dimension(:,:,:,:),pointer :: ptr4DI2 
 end type ESMF_LAWrap4DI2 
 
#ifndef ESMF_NO_GREATER_THAN_4D 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap5DI2 
 integer (ESMF_KIND_I2),dimension(:,:,:,:,:),pointer :: ptr5DI2 
 end type ESMF_LAWrap5DI2 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap6DI2 
 integer (ESMF_KIND_I2),dimension(:,:,:,:,:,:),pointer :: ptr6DI2 
 end type ESMF_LAWrap6DI2 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap7DI2 
 integer (ESMF_KIND_I2),dimension(:,:,:,:,:,:,:),pointer :: ptr7DI2 
 end type ESMF_LAWrap7DI2 
 
#endif 
#endif 
#endif 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap1DI4 
 integer (ESMF_KIND_I4),dimension(:),pointer :: ptr1DI4 
 end type ESMF_LAWrap1DI4 
 
#ifndef PIO_TKR 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap1DI8 
 integer (ESMF_KIND_I8),dimension(:),pointer :: ptr1DI8 
 end type ESMF_LAWrap1DI8 
 
#endif 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap1DR4 
 real (ESMF_KIND_R4),dimension(:),pointer :: ptr1DR4 
 end type ESMF_LAWrap1DR4 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap1DR8 
 real (ESMF_KIND_R8),dimension(:),pointer :: ptr1DR8 
 end type ESMF_LAWrap1DR8 
 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap2DI4 
 integer (ESMF_KIND_I4),dimension(:,:),pointer :: ptr2DI4 
 end type ESMF_LAWrap2DI4 
 
#ifndef PIO_TKR 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap2DI8 
 integer (ESMF_KIND_I8),dimension(:,:),pointer :: ptr2DI8 
 end type ESMF_LAWrap2DI8 
 
#endif 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap2DR4 
 real (ESMF_KIND_R4),dimension(:,:),pointer :: ptr2DR4 
 end type ESMF_LAWrap2DR4 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap2DR8 
 real (ESMF_KIND_R8),dimension(:,:),pointer :: ptr2DR8 
 end type ESMF_LAWrap2DR8 
 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap3DI4 
 integer (ESMF_KIND_I4),dimension(:,:,:),pointer :: ptr3DI4 
 end type ESMF_LAWrap3DI4 
 
#ifndef PIO_TKR 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap3DI8 
 integer (ESMF_KIND_I8),dimension(:,:,:),pointer :: ptr3DI8 
 end type ESMF_LAWrap3DI8 
 
#endif 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap3DR4 
 real (ESMF_KIND_R4),dimension(:,:,:),pointer :: ptr3DR4 
 end type ESMF_LAWrap3DR4 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap3DR8 
 real (ESMF_KIND_R8),dimension(:,:,:),pointer :: ptr3DR8 
 end type ESMF_LAWrap3DR8 
 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap4DI4 
 integer (ESMF_KIND_I4),dimension(:,:,:,:),pointer :: ptr4DI4 
 end type ESMF_LAWrap4DI4 
 
#ifndef PIO_TKR 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap4DI8 
 integer (ESMF_KIND_I8),dimension(:,:,:,:),pointer :: ptr4DI8 
 end type ESMF_LAWrap4DI8 
 
#endif 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap4DR4 
 real (ESMF_KIND_R4),dimension(:,:,:,:),pointer :: ptr4DR4 
 end type ESMF_LAWrap4DR4 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap4DR8 
 real (ESMF_KIND_R8),dimension(:,:,:,:),pointer :: ptr4DR8 
 end type ESMF_LAWrap4DR8 
 
 
#ifndef ESMF_NO_GREATER_THAN_4D 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap5DI4 
 integer (ESMF_KIND_I4),dimension(:,:,:,:,:),pointer :: ptr5DI4 
 end type ESMF_LAWrap5DI4 
 
#ifndef ESMF_NO_INTEGER_I8 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap5DI8 
 integer (ESMF_KIND_I8),dimension(:,:,:,:,:),pointer :: ptr5DI8 
 end type ESMF_LAWrap5DI8 
 
#endif 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap5DR4 
 real (ESMF_KIND_R4),dimension(:,:,:,:,:),pointer :: ptr5DR4 
 end type ESMF_LAWrap5DR4 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap5DR8 
 real (ESMF_KIND_R8),dimension(:,:,:,:,:),pointer :: ptr5DR8 
 end type ESMF_LAWrap5DR8 
 
 
#ifndef PIO_TKR 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap6DI4 
 integer (ESMF_KIND_I4),dimension(:,:,:,:,:,:),pointer :: ptr6DI4 
 end type ESMF_LAWrap6DI4 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap6DI8 
 integer (ESMF_KIND_I8),dimension(:,:,:,:,:,:),pointer :: ptr6DI8 
 end type ESMF_LAWrap6DI8 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap6DR4 
 real (ESMF_KIND_R4),dimension(:,:,:,:,:,:),pointer :: ptr6DR4 
 end type ESMF_LAWrap6DR4 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap6DR8 
 real (ESMF_KIND_R8),dimension(:,:,:,:,:,:),pointer :: ptr6DR8 
 end type ESMF_LAWrap6DR8 
 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap7DI4 
 integer (ESMF_KIND_I4),dimension(:,:,:,:,:,:,:),pointer :: ptr7DI4 
 end type ESMF_LAWrap7DI4 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap7DI8 
 integer (ESMF_KIND_I8),dimension(:,:,:,:,:,:,:),pointer :: ptr7DI8 
 end type ESMF_LAWrap7DI8 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap7DR4 
 real (ESMF_KIND_R4),dimension(:,:,:,:,:,:,:),pointer :: ptr7DR4 
 end type ESMF_LAWrap7DR4 
 
 ! <Created by macro - do not edit directly > 
 type ESMF_LAWrap7DR8 
 real (ESMF_KIND_R8),dimension(:,:,:,:,:,:,:),pointer :: ptr7DR8 
 end type ESMF_LAWrap7DR8 
 
 
#endif 
 
#endif 
 
! < end macro - do not edit directly > 
 

end module ESMF_LocalArrayWrapperTypeMod
