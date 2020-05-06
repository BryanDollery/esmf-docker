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
#define ESMF_FILENAME "ESMF_TypeKindGet.F90"
! ESMF TypeKindGet module
module ESMF_TypeKindGetMod
!==============================================================================
!
! This file contains wordsize functions that are automatically
! generated from macros to handle the type/kind overloading.
!
!------------------------------------------------------------------------------
! INCLUDES
! < ignore blank lines below. they are created by the files which
! define various macros. >
#include "ESMF.h"
!------------------------------------------------------------------------------
! !USES:
     use ESMF_UtilTypesMod
     use ESMF_LogErrMod
     implicit none
!------------------------------------------------------------------------------
! !PRIVATE TYPES:
      private
!------------------------------------------------------------------------------
! !PUBLIC FUNCTION:
      public ESMF_TypeKindGet
!------------------------------------------------------------------------------
#undef ESMF_METHOD
#define ESMF_METHOD "ESMF_TypeKindGet"
!BOP
! !IROUTINE: ESMF_TypeKindGet -- Generic interface to return the correct
! ESMF_TypeKind_Flag parameter of a scalar.
!
! !INTERFACE:
    interface ESMF_TypeKindGet
!------------------------------------------------------------------------------ 
! <This section created by macro - do not edit directly> 
#ifndef ESMF_NO_INTEGER_1_BYTE 
 module procedure ESMF_TypeKindGetI1 
#endif 
#ifndef ESMF_NO_INTEGER_2_BYTE 
 module procedure ESMF_TypeKindGetI2 
#endif 
 module procedure ESMF_TypeKindGetI4 
 module procedure ESMF_TypeKindGetI8 
 module procedure ESMF_TypeKindGetR4 
 module procedure ESMF_TypeKindGetR8 
! < end macro - do not edit directly > 
!------------------------------------------------------------------------------ 

!EOP
    end interface
    contains
!==============================================================================
!------------------------------------------------------------------------------
!------------------------------------------------------------------------------ 
! <This section created by macro - do not edit directly> 
 
!! < start of macros which become actual subroutine bodies after expansion > 
 
!TODO: add interface documentation 
!BOP 
! !IROUTINE: ESMF_TypeKindGet - Return the ESMF_TypeKind parameter corresponding to a scalar 
! 
! !INTERFACE: 
! ! Private name; call using ESMF_TypeKindGet() 
! function ESMF_TypeKindGet<typekind>(var, rc) 
! 
! !RETURN VALUE: 
! type(ESMF_TypeKind_Flag) :: ESMF_TypeKindGet<typekind> 
! 
! !ARGUMENTS: 
! <type>(ESMF_KIND_<typekind>), intent(in) :: var 
! integer, intent(out), optional :: rc 
! 
! !DESCRIPTION: 
! Return the ESMF_TypeKind parameter that corresponds to the scalar 
! (var) argument. Valid typekind supported by the framework are: 
! integers of 1-byte, 2-byte, 4-byte, and 8-byte size, and 
! reals of 4-byte and 8-bytes size. 
! 
! The arguments are: 
! \begin{description} 
! \item [var] 
! Scalar of any supported type and kind 
! \item [rc] 
! Return code; equals {\tt ESMF\_SUCCESS} if there are no errors. 
! \end{description} 
! 
!EOP 
!---------------------------------------------------------------------------- 
 
#ifndef ESMF_NO_INTEGER_1_BYTE 
!------------------------------------------------------------------------------ 
! <Created by macro - do not edit directly > 
!------------------------------------------------------------------------------ 

#undef ESMF_METHOD 
!define ESMF_METHOD "ESMF_TypeKindGet##mtypekind" 
#define ESMF_METHOD "ESMF_TypeKindGet" 
 type(ESMF_TypeKind_Flag) function ESMF_TypeKindGetI1(var, rc) 

 integer(ESMF_KIND_I1), intent(in) :: var 
 integer, intent(out), optional :: rc 

 if (present(rc)) rc = ESMF_RC_NOT_IMPL 

 ! the purpose of dummy argument var is to support TK overloading 
 ! some compilers will notice that var is unused, and issue warnings 
 if (var==var) continue ! dummy check to quiet down compiler warnings 

 ESMF_TypeKindGetI1 = ESMF_TYPEKIND_I1 

 if (present(rc)) rc = ESMF_SUCCESS 

 end function ESMF_TypeKindGetI1 

!--------------------------------------------------------------------------- 
 
#endif 
#ifndef ESMF_NO_INTEGER_2_BYTE 
!------------------------------------------------------------------------------ 
! <Created by macro - do not edit directly > 
!------------------------------------------------------------------------------ 

#undef ESMF_METHOD 
!define ESMF_METHOD "ESMF_TypeKindGet##mtypekind" 
#define ESMF_METHOD "ESMF_TypeKindGet" 
 type(ESMF_TypeKind_Flag) function ESMF_TypeKindGetI2(var, rc) 

 integer(ESMF_KIND_I2), intent(in) :: var 
 integer, intent(out), optional :: rc 

 if (present(rc)) rc = ESMF_RC_NOT_IMPL 

 ! the purpose of dummy argument var is to support TK overloading 
 ! some compilers will notice that var is unused, and issue warnings 
 if (var==var) continue ! dummy check to quiet down compiler warnings 

 ESMF_TypeKindGetI2 = ESMF_TYPEKIND_I2 

 if (present(rc)) rc = ESMF_SUCCESS 

 end function ESMF_TypeKindGetI2 

!--------------------------------------------------------------------------- 
 
#endif 
!------------------------------------------------------------------------------ 
! <Created by macro - do not edit directly > 
!------------------------------------------------------------------------------ 

#undef ESMF_METHOD 
!define ESMF_METHOD "ESMF_TypeKindGet##mtypekind" 
#define ESMF_METHOD "ESMF_TypeKindGet" 
 type(ESMF_TypeKind_Flag) function ESMF_TypeKindGetI4(var, rc) 

 integer(ESMF_KIND_I4), intent(in) :: var 
 integer, intent(out), optional :: rc 

 if (present(rc)) rc = ESMF_RC_NOT_IMPL 

 ! the purpose of dummy argument var is to support TK overloading 
 ! some compilers will notice that var is unused, and issue warnings 
 if (var==var) continue ! dummy check to quiet down compiler warnings 

 ESMF_TypeKindGetI4 = ESMF_TYPEKIND_I4 

 if (present(rc)) rc = ESMF_SUCCESS 

 end function ESMF_TypeKindGetI4 

!--------------------------------------------------------------------------- 
 
!------------------------------------------------------------------------------ 
! <Created by macro - do not edit directly > 
!------------------------------------------------------------------------------ 

#undef ESMF_METHOD 
!define ESMF_METHOD "ESMF_TypeKindGet##mtypekind" 
#define ESMF_METHOD "ESMF_TypeKindGet" 
 type(ESMF_TypeKind_Flag) function ESMF_TypeKindGetI8(var, rc) 

 integer(ESMF_KIND_I8), intent(in) :: var 
 integer, intent(out), optional :: rc 

 if (present(rc)) rc = ESMF_RC_NOT_IMPL 

 ! the purpose of dummy argument var is to support TK overloading 
 ! some compilers will notice that var is unused, and issue warnings 
 if (var==var) continue ! dummy check to quiet down compiler warnings 

 ESMF_TypeKindGetI8 = ESMF_TYPEKIND_I8 

 if (present(rc)) rc = ESMF_SUCCESS 

 end function ESMF_TypeKindGetI8 

!--------------------------------------------------------------------------- 
 
!------------------------------------------------------------------------------ 
! <Created by macro - do not edit directly > 
!------------------------------------------------------------------------------ 

#undef ESMF_METHOD 
!define ESMF_METHOD "ESMF_TypeKindGet##mtypekind" 
#define ESMF_METHOD "ESMF_TypeKindGet" 
 type(ESMF_TypeKind_Flag) function ESMF_TypeKindGetR4(var, rc) 

 real(ESMF_KIND_R4), intent(in) :: var 
 integer, intent(out), optional :: rc 

 if (present(rc)) rc = ESMF_RC_NOT_IMPL 

 ! the purpose of dummy argument var is to support TK overloading 
 ! some compilers will notice that var is unused, and issue warnings 
 if (var==var) continue ! dummy check to quiet down compiler warnings 

 ESMF_TypeKindGetR4 = ESMF_TYPEKIND_R4 

 if (present(rc)) rc = ESMF_SUCCESS 

 end function ESMF_TypeKindGetR4 

!--------------------------------------------------------------------------- 
 
!------------------------------------------------------------------------------ 
! <Created by macro - do not edit directly > 
!------------------------------------------------------------------------------ 

#undef ESMF_METHOD 
!define ESMF_METHOD "ESMF_TypeKindGet##mtypekind" 
#define ESMF_METHOD "ESMF_TypeKindGet" 
 type(ESMF_TypeKind_Flag) function ESMF_TypeKindGetR8(var, rc) 

 real(ESMF_KIND_R8), intent(in) :: var 
 integer, intent(out), optional :: rc 

 if (present(rc)) rc = ESMF_RC_NOT_IMPL 

 ! the purpose of dummy argument var is to support TK overloading 
 ! some compilers will notice that var is unused, and issue warnings 
 if (var==var) continue ! dummy check to quiet down compiler warnings 

 ESMF_TypeKindGetR8 = ESMF_TYPEKIND_R8 

 if (present(rc)) rc = ESMF_SUCCESS 

 end function ESMF_TypeKindGetR8 

!--------------------------------------------------------------------------- 
 
 
! < end macro - do not edit directly > 
!------------------------------------------------------------------------------ 

end module ESMF_TypeKindGetMod
