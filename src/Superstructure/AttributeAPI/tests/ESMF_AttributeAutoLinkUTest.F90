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
!
program ESMF_AttributeAutoLinkUTest
!------------------------------------------------------------------------------
! INCLUDES
#include "ESMF.h"
#if 0
! $Id$
!
! Earth System Modeling Framework
! Copyright 2002-2014, University Corporation for Atmospheric Research,
! Massachusetts Institute of Technology, Geophysical Fluid Dynamics
! Laboratory, University of Michigan, National Centers for Environmental
! Prediction, Los Alamos National Laboratory, Argonne National Laboratory,
! NASA Goddard Space Flight Center.
! Licensed under the University of Illinois-NCSA License.
!
!==============================================================================
!
#endif
#if 0
!------------------------------------------------------------------------------
! Macros for Attribute testing
!
! The structure of this file and these macros are compatible with the gcc
! preprocessor - they assume the use of ## as a paste operator, require that
! no additional spaces be added (e.g. no pre-tokenization as done by some
! preprocessors which assume C syntax), assume an option exists to suppress
! C-specific syntax directives such as #line or #pragma, and that an option
! exists to produce output on stdout and not into a file. The output of
! the preprocessor phase is a valid .F90 file ready to be compiled by the
! standard fortran compiler. (gcc is *not* used for compilation.)
!
! The macros are intended to be written with 
\ at the end of each line of
! a multiline macro, and the output piped thru 'tr' to translate each
! 
 into <cr> to produce multiple lines of fortran code from a single
! macro invocation. If any preprocessor directives are to be left in the
! output file (e.g. #include ""), the source should use #directive (e.g.
! #include "header.h" ) again using 'tr' to substitute # for # after
! preprocessing is completed.
!------------------------------------------------------------------------------
#endif
! variable declarations
! variable declarations
! main test body
! main test body
!
!==============================================================================
!BOP
! !PROGRAM: ESMF_AttributeAutoLinkUTest - Attribute Tests
!
! !DESCRIPTION:
!
! The code in this file drives F90 Attribute tests.
! The companion file ESMF\_Attribute.F90 contains the definitions for the
! Attribute methods.
!
!-----------------------------------------------------------------------------
! !USES:
      use ESMF_TestMod ! test methods
      use ESMF ! the ESMF Framework
      implicit none
!------------------------------------------------------------------------------
! The following line turns the CVS identifier string into a printable variable.
      character(*), parameter :: version = &
      '$Id$'
!------------------------------------------------------------------------------
!-------------------------------------------------------------------------
!=========================================================================
      ! individual test failure message
      character(ESMF_MAXSTR) :: failMsg, name
      ! cumulative result: count failures; no failures equals "all pass"
      integer :: result = 0
      ! local variables
      type(ESMF_Field) :: field
      type(ESMF_FieldBundle) :: fieldbundle
      type(ESMF_State) :: state, state2
      type(ESMF_LocStream) :: locstream
      integer :: linkcount
      ! macro variables
      character(ESMF_MAXSTR) :: attrname, attrnameOut, attrvalue 
 integer :: rc, count, items 
 type(ESMF_TypeKind_Flag) :: attrTK 
 
 character(3*ESMF_MAXSTR) :: inASCII, outASCII 
 logical :: correct 
 integer :: i 
 
 real(ESMF_KIND_R8), dimension(3) :: inR8l, defaultR8l, & 
 dfltoutR8l, outR8l 
 character(ESMF_MAXSTR) :: inChar, outChar, & 
 defaultChar, dfltoutChar 
 real(ESMF_KIND_R8) :: inR8, outR8,& 
 defaultR8, dfltoutR8 
 real(ESMF_KIND_R8), dimension(4) :: defaultR8lWrong 
 
 ! non exhaustive constant value variables 
 real(ESMF_KIND_R8) :: outConstantR8 
 real(ESMF_KIND_R8), dimension(3) :: outConstantR8l 
 character(ESMF_MAXSTR) :: outConstantChar 
 character(ESMF_MAXSTR), dimension(3) :: outConstantCharl 
 
 logical :: isPresent 
 
#ifdef ESMF_TESTEXHAUSTIVE 
 
 integer :: itemCount 
 
 integer(ESMF_KIND_I4) :: inI4, outI4, & 
 defaultI4, dfltoutI4 
 integer(ESMF_KIND_I4), dimension(3) :: inI4l, outI4l, & 
 defaultI4l, dfltoutI4l 
 integer(ESMF_KIND_I4), dimension(4) :: defaultI4lWrong 
 integer(ESMF_KIND_I4), dimension(10) :: outI4lLong 
 integer(ESMF_KIND_I8) :: inI8, outI8, & 
 defaultI8, dfltoutI8 
 integer(ESMF_KIND_I8), dimension(3) :: inI8l, outI8l, & 
 defaultI8l, dfltoutI8l 
 integer(ESMF_KIND_I8), dimension(4) :: defaultI8lWrong 
 integer(ESMF_KIND_I8), dimension(10) :: outI8lLong 
 real(ESMF_KIND_R4) :: inR4, outR4, & 
 defaultR4, dfltoutR4 
 real(ESMF_KIND_R4), dimension(3) :: inR4l, outR4l, & 
 defaultR4l, dfltoutR4l 
 real(ESMF_KIND_R4), dimension(4) :: defaultR4lWrong 
 real(ESMF_KIND_R4), dimension(10) :: outR4lLong 
 character(ESMF_MAXSTR) :: inEmpty, outEmpty 
 character(ESMF_MAXSTR), dimension(3) :: inCharl, defaultCharl, & 
 dfltoutCharl, outCharl 
 character(ESMF_MAXSTR), dimension(4) :: defaultCharlWrong 
 character(ESMF_MAXSTR), dimension(10) :: outCharlLong 
 logical :: inLog, outLog, & 
 defaultLog, dfltoutLog 
 logical, dimension(3) :: inLogl, defaultLogl, & 
 dfltoutLogl, outLogl 
 logical, dimension(4) :: defaultLoglWrong 
 logical, dimension(10) :: outLoglLong 
 real(ESMF_KIND_R8), dimension(10) :: outR8lLong 
 
 ! exhaustive constant value variables 
 integer(ESMF_KIND_I4) :: outConstantI4 
 integer(ESMF_KIND_I4), dimension(3) :: outConstantI4l 
 integer(ESMF_KIND_I8) :: outConstantI8 
 integer(ESMF_KIND_I8), dimension(3) :: outConstantI8l 
 real(ESMF_KIND_R4) :: outConstantR4 
 real(ESMF_KIND_R4), dimension(3) :: outConstantR4l 
 logical :: outConstantLogical 
 logical, dimension(3) :: outConstantLogicall 
 
 character(ESMF_MAXSTR), dimension(3) :: attpackList, attpackListOut, & 
 attpackListOut2, attpackDfltList, & 
 attpackListOut3, attpackListOut4 
 
#endif 
! < end macro - do not edit directly > 
!------------------------------------------------------------------------------
!-------------------------------------------------------------------------------
! The unit tests are divided into Sanity and Exhaustive. The Sanity tests are
! always run. When the environment variable, EXHAUSTIVE, is set to ON then
! the EXHAUSTIVE and sanity tests both run. If the EXHAUSTIVE variable is set
! to OFF, then only the sanity unit tests.
! Special strings (Non-exhaustive and exhaustive) have been
! added to allow a script to count the number and types of unit tests.
!-------------------------------------------------------------------------------
  !-----------------------------------------------------------------------------
  call ESMF_TestStart(ESMF_SRCLINE, rc=rc)
  if (rc /= ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
  !-----------------------------------------------------------------------------
      !------------------------------------------------------------------------
      ! preparations
      locstream = ESMF_LocStreamCreate(20, rc=rc)
      field = ESMF_FieldCreate(locstream, ESMF_TYPEKIND_R8, name="field", rc=rc)
      fieldbundle = ESMF_FieldBundleCreate(fieldList=(/field/), &
                                           name="fieldbundle", rc=rc)
      state = ESMF_StateCreate(name="state", rc=rc)
      state2 = ESMF_StateCreate(name="state2", rc=rc)
      if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    !-------------------------------------------------------------------------
    ! Attribute hierarchy linking
    !-------------------------------------------------------------------------
      !NEX_UTest
      ! Link a State Attribute hierarchy to a Field Attribute hierarchy State Test
      call ESMF_StateAdd(state, (/field/), rc=rc)
      write(failMsg, *) "Did not return ESMF_SUCCESS"
      write(name, *) "Linking a State hierarchy to a Field hierarchy Test"
      call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)
      !------------------------------------------------------------------------
      !NEX_UTest
      ! Check Attribute link count
      call ESMF_AttributeGet(state, count=linkcount, &
                             attcountflag=ESMF_ATTGETCOUNT_ATTLINK, rc=rc)
      write(failMsg, *) "Did not return ESMF_SUCCESS"
      write(name, *) "Check the Attribute link count"
      call ESMF_Test(((rc==ESMF_SUCCESS) &
                     .and. (linkcount == 1)), name, failMsg, result, ESMF_SRCLINE)
      !------------------------------------------------------------------------
      !NEX_UTest
      ! Link a State Attribute hierarchy to a FieldBundle Attribute hierarchy State Test
      call ESMF_StateAdd(state, (/fieldbundle/), rc=rc)
      write(failMsg, *) "Did not return ESMF_SUCCESS"
      write(name, *) "Linking a State hierarchy to a FieldBundle hierarchy Test"
      call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)
      !------------------------------------------------------------------------
      !NEX_UTest
      ! Check Attribute link count
      call ESMF_AttributeGet(state, count=linkcount, &
                             attcountflag=ESMF_ATTGETCOUNT_ATTLINK, rc=rc)
      write(failMsg, *) "Did not return ESMF_SUCCESS"
      write(name, *) "Check the Attribute link count"
      call ESMF_Test(((rc==ESMF_SUCCESS) &
                     .and. (linkcount == 2)), name, failMsg, result, ESMF_SRCLINE)
      !------------------------------------------------------------------------
      !NEX_UTest
      ! Link a State Attribute hierarchy to a State Attribute hierarchy State Test
      call ESMF_StateAdd(state, (/state2/), rc=rc)
      write(failMsg, *) "Did not return ESMF_SUCCESS"
      write(name, *) "Linking a State hierarchy to a State hierarchy Test"
      call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)
      !------------------------------------------------------------------------
      !NEX_UTest
      ! Check Attribute link count
      call ESMF_AttributeGet(state, count=linkcount, &
                             attcountflag=ESMF_ATTGETCOUNT_ATTLINK, rc=rc)
      write(failMsg, *) "Did not return ESMF_SUCCESS"
      write(name, *) "Check the Attribute link count"
      call ESMF_Test(((rc==ESMF_SUCCESS) &
                     .and. (linkcount == 3)), name, failMsg, result, ESMF_SRCLINE)
      !------------------------------------------------------------------------
      !NEX_UTest
      ! Unlink a State Attribute hierarchy from a State Attribute hierarchy State Test
      call ESMF_StateRemove(state, (/"state2"/), rc=rc)
      write(failMsg, *) "Did not return ESMF_SUCCESS"
      write(name, *) "Unlinking a State hierarchy to a State hierarchy Test"
      call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)
      !------------------------------------------------------------------------
      !NEX_UTest
      ! Check Attribute link count
      call ESMF_AttributeGet(state, count=linkcount, &
                             attcountflag=ESMF_ATTGETCOUNT_ATTLINK, rc=rc)
      write(failMsg, *) "Did not return ESMF_SUCCESS"
      write(name, *) "Check the Attribute link count"
      call ESMF_Test(((rc==ESMF_SUCCESS) &
                     .and. (linkcount == 2)), name, failMsg, result, ESMF_SRCLINE)
      !------------------------------------------------------------------------
      !NEX_UTest
      ! Unlink a State Attribute hierarchy from a FieldBundle Attribute hierarchy State Test
      call ESMF_StateRemove(state, (/"fieldbundle"/), rc=rc)
      write(failMsg, *) "Did not return ESMF_SUCCESS"
      write(name, *) "Unlinking a State hierarchy to a State hierarchy Test"
      call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)
      !------------------------------------------------------------------------
      !NEX_UTest
      ! Check Attribute link count
      call ESMF_AttributeGet(state, count=linkcount, &
                             attcountflag=ESMF_ATTGETCOUNT_ATTLINK, rc=rc)
      write(failMsg, *) "Did not return ESMF_SUCCESS"
      write(name, *) "Check the Attribute link count"
      call ESMF_Test(((rc==ESMF_SUCCESS) &
                     .and. (linkcount == 1)), name, failMsg, result, ESMF_SRCLINE)
      !------------------------------------------------------------------------
      !NEX_UTest
      ! Unlink a State Attribute hierarchy from a Field Attribute hierarchy State Test
      call ESMF_StateRemove(state, (/"field"/), rc=rc)
      write(failMsg, *) "Did not return ESMF_SUCCESS"
      write(name, *) "Unlinking a State hierarchy to a State hierarchy Test"
      call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)
      !------------------------------------------------------------------------
      !NEX_UTest
      ! Check Attribute link count
      call ESMF_AttributeGet(state, count=linkcount, &
                             attcountflag=ESMF_ATTGETCOUNT_ATTLINK, rc=rc)
      write(failMsg, *) "Did not return ESMF_SUCCESS"
      write(name, *) "Check the Attribute link count"
      call ESMF_Test(((rc==ESMF_SUCCESS) &
                     .and. (linkcount == 0)), name, failMsg, result, ESMF_SRCLINE)
      !------------------------------------------------------------------------
      !------------------------------------------------------------------------
      ! clean up
      call ESMF_LocStreamDestroy(locstream, rc=rc)
      call ESMF_FieldDestroy(field, rc=rc)
      call ESMF_FieldBundleDestroy(fieldbundle, rc=rc)
      call ESMF_StateDestroy(state, rc=rc)
      call ESMF_StateDestroy(state2, rc=rc)
      if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
  !-----------------------------------------------------------------------------
  call ESMF_TestEnd(ESMF_SRCLINE)
  !-----------------------------------------------------------------------------
end program ESMF_AttributeAutoLinkUTest
