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
program ESMF_AttPackLocStreamUTest
!------------------------------------------------------------------------------
! INCLUDES
#include "ESMF.h"
! variable declarations
!
!==============================================================================
!BOP
! !PROGRAM: ESMF_AttPackLocStreamUTest - AttPack LocStream Unit Tests
!
! !DESCRIPTION:
!
! The code in this file drives F90 AttPack LocStream unit tests.
! The companion file ESMF\_Attribute.F90 contains the definitions for the
! Attribute methods.
!EOP
!-----------------------------------------------------------------------------
! !USES:
  use ESMF_TestMod ! test methods
  use ESMF ! the ESMF Framework
  implicit none
!------------------------------------------------------------------------------
! The following line turns the CVS identifier string into a printable variable.
  character(*), parameter :: version = '$Id$'
!------------------------------------------------------------------------------
  ! individual test failure message
  character(ESMF_MAXSTR) :: failMsg
  character(ESMF_MAXPATHLEN) :: name
  integer :: rc
  integer :: result = 0
  ! local variables
  type(ESMF_LocStream) :: locStream
  
#ifdef ESMF_TESTEXHAUSTIVE 
 integer :: i 
 type(ESMF_AttPack) :: attpack, attpack2 
 character(ESMF_MAXSTR) :: conv, nestconv, purp, nestpurp 
 
 integer(ESMF_KIND_I4) :: inI4, outI4, inI4l(3), outI4l(3) 
 integer(ESMF_KIND_I8) :: inI8, outI8, inI8l(3), outI8l(3) 
 real(ESMF_KIND_R4) :: inR4, outR4, inR4l(3), outR4l(3) 
 real(ESMF_KIND_R4) :: inR8, outR8, inR8l(3), outR8l(3) 
 character(ESMF_MAXSTR) :: inChar, outChar, inCharl(3), outCharl(3) 
 logical :: inLog, outLog, inLogl(3), outLogl(3) 
 
 character(ESMF_MAXSTR), dimension(12) :: attpackList, & 
 attpackListTNames, & 
 attpackListTNames2 
 character(ESMF_MAXSTR), dimension(3) :: attpackListOut2, & 
 attpackListOut3, & 
 attpackListOut4, & 
 attpackDfltList, & 
 attpackDfltList2 
 character(ESMF_MAXSTR) :: attrname, attrvalue, filename, baseline 
 
 logical :: rc_logical, isPresent 
 integer :: count, attrcount, packcount 
 character(ESMF_MAXSTR), dimension(1) :: exclusions 
 
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
  locstream = ESMF_LocStreamCreate(20, rc=rc)
  !------------------------------------------------------------------------------ 
! <This section created by macro - do not edit directly> 
 
#ifdef ESMF_TESTEXHAUSTIVE 
 
 conv = "customconvention" 
 purp = "custompurpose   " 
 attpackList(1) = "ESMF_I4" 
 attpackList(2) = "ESMF_I4_list" 
 attpackList(3) = "ESMF_I8" 
 attpackList(4) = "ESMF_I8_list" 
 attpackList(5) = "ESMF_R4" 
 attpackList(6) = "ESMF_R4_list" 
 attpackList(7) = "ESMF_R8" 
 attpackList(8) = "ESMF_R8_list" 
 attpackList(9) = "ESMF_Logical" 
 attpackList(10) = "ESMF_Logical_list" 
 attpackList(11) = "ESMF_Character" 
 attpackList(12) = "ESMF_Character_list" 
 
 inI4 = 4 
 inI4l = (/1,2,3/) 
 inI8 = 4 
 inI8l = (/1,2,3/) 
 inR4 = 4 
 inR4l = (/1,2,3/) 
 inR8 = 4 
 inR8l = (/1,2,3/) 
 inLog = .true. 
 inLogl(1) = .true. 
 inLogl(2) = .false. 
 inLogl(3) = .true. 
 inChar = "charAttribute" 
 InCharl(1) = "Character String 1" 
 InCharl(2) = "Character String 2" 
 InCharl(3) = "Character String 3" 
 
 !------------------------------------------------------------------------- 
 ! Attribute package redundancy and addition 
 !------------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Create a custom Attribute package on "a LocStream" Test 
 call ESMF_AttributeAdd(locStream, conv, purp, attrList=attpackList, & 
 attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Creating a custom Attribute package on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Add to a custom Attribute package on "a LocStream" Test 
 attpackList(1) = "ESMF_I4_new" 
 call ESMF_AttributeAdd(locStream, conv, purp, attrList=attpackList(1:1), & 
 rc=rc) 
 attrcount = -5 
 call ESMF_AttributeGet(locStream, count=attrcount, attpack=attpack, & 
 attnestflag=ESMF_ATTNEST_OFF, rc=rc) 
 packcount = -5 
 call ESMF_AttributeGet(locStream, & 
 attnestflag=ESMF_ATTNEST_OFF, & 
 attcountflag=ESMF_ATTGETCOUNT_ATTPACK, & 
 count=packcount, rc=rc) 
 ! reset the attrList 
 attpackList(1) = "ESMF_I4" 
 ! remove the additional attribute 
 call ESMF_AttributeRemove(locStream, name="ESMF_I4_new", attpack=attpack, & 
 rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Add to a custom Attribute package on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS) & 
 .and. attrcount == 13 & 
 .and. packcount == 1, name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Create a redundant Attribute package using attpack on "a LocStream" Test 
 call ESMF_AttributeAdd(locStream, conv, purp, attrList=attpackList(1:5), & 
 redundant=.true., attpack=attpack2, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Creating a redundant Attribute package using attpack on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Add to a custom Attribute package using attpack on "a LocStream" Test 
 attpackList(1) = "ESMF_I4_new" 
 call ESMF_AttributeAdd(locStream, conv, purp, attrList=attpackList(1:1), & 
 attpack=attpack2, rc=rc) 
 attpackList(1) = "ESMF_I4_new2" 
 call ESMF_AttributeAdd(locStream, conv, purp, attrList=attpackList(1:1), & 
 rc=rc) 
 attrcount = -5 
 call ESMF_AttributeGet(locStream, count=attrcount, attpack=attpack2, & 
 attnestflag=ESMF_ATTNEST_OFF, rc=rc) 
 packcount = -5 
 call ESMF_AttributeGet(locStream, & 
 attnestflag=ESMF_ATTNEST_OFF, & 
 attcountflag=ESMF_ATTGETCOUNT_ATTPACK, & 
 count=packcount, rc=rc) 
 ! reset the attrList 
 attpackList(1) = "ESMF_I4" 
 ! remove this attpack to avoid confusion with remaining tests 
 call ESMF_AttributeRemove(locStream, attpack=attpack2, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Add to a custom Attribute package using attpack on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS) & 
 .and. attrcount == 7 & 
 .and. packcount == 2, name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 purp = "doodle          " 
 ! Add to a custom Attribute package that cannot be found on "a LocStream" Test 
 call ESMF_AttributeAdd(locStream, conv, purp, attrList=attpackList(1:5), & 
 rc=rc) 
 call ESMF_AttributeGetAttPack(locStream, conv, purp, attpack=attpack2, & 
 rc=rc) 
 attrcount = -5 
 call ESMF_AttributeGet(locStream, count=attrcount, attpack=attpack2, & 
 attnestflag=ESMF_ATTNEST_OFF, rc=rc) 
 packcount = -5 
 call ESMF_AttributeGet(locStream, & 
 attnestflag=ESMF_ATTNEST_OFF, & 
 attcountflag=ESMF_ATTGETCOUNT_ATTPACK, & 
 count=packcount, rc=rc) 
 ! reset the purp 
 purp = "custompurpose   " 
 ! remove this attpack to avoid confusion with remaining tests 
 call ESMF_AttributeRemove(locStream, attpack=attpack2, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Add to a custom Attribute package that cannot be found on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS) & 
 .and. attrcount == 5 & 
 .and. packcount == 2, name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !------------------------------------------------------------------------- 
 ! Attribute package custom 
 !------------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Set an ESMF_I4 Attribute in an Attribute package on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name="ESMF_I4", value=inI4, & 
 attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting an ESMF_I4 Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get an ESMF_I4 Attribute using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name="ESMF_I4", attpack=attpack, value=outI4, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value" 
 write(name, *) "Getting an ESMF_I4 Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS).and.(inI4==outI4), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Set an ESMF_I4 list Attribute in an Attribute package using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name="ESMF_I4_list", valueList=inI4l, & 
 attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting an ESMF_I4 list Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get an ESMF_I4 list Attribute using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name="ESMF_I4_list", attpack=attpack, & 
 valueList=outI4l, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value" 
 write(name, *) "Getting an ESMF_I4 list Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS).and. all (inI4l==outI4l), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Set an ESMF_I8 Attribute in an Attribute package using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name="ESMF_I8", value=inI8, & 
 attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting an ESMF_I8 Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get an ESMF_I8 Attribute using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name="ESMF_I8", attpack=attpack, value=outI8, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value" 
 write(name, *) "Getting an ESMF_I8 Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS).and. (inI8==outI8), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Set an ESMF_I8 list Attribute in an Attribute package using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name="ESMF_I8_list", valueList=inI8l, & 
 attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting an ESMF_I8 list Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get an ESMF_I8 list Attribute using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name="ESMF_I8_list", attpack=attpack, & 
 valueList=outI8l, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value" 
 write(name, *) "Getting an ESMF_I8 list Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS).and. all (inI8l==outI8l), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Set an ESMF_R4 Attribute in an Attribute package using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name="ESMF_R4", value=inR4, & 
 attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting an ESMF_R4 Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get an ESMF_R4 Attribute using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name="ESMF_R4", attpack=attpack, value=outR4, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value" 
 write(name, *) "Getting an ESMF_R4 Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS).and.(inR4==outR4), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Set an ESMF_R4 list Attribute in an Attribute package using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name="ESMF_R4_list", valueList=inR4l, & 
 attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting an ESMF_R4 list Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get an ESMF_R4 list Attribute using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name="ESMF_R4_list", attpack=attpack, & 
 valueList=outR4l, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value" 
 write(name, *) "Getting an ESMF_R4 list Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS).and. all (inR4l==outR4l), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Set an ESMF_R8 Attribute in an Attribute package using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name="ESMF_R8", value=inR8, & 
 attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting an ESMF_R8name Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get an ESMF_R8 Attribute using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name="ESMF_R8", attpack=attpack, value=outR8, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value" 
 write(name, *) "Getting an ESMF_R8 Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS).and.(inR8==outR8), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Set an ESMF_R8 list Attribute in an Attribute package using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name="ESMF_R8_list", valueList=inR8l, & 
 attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting an ESMF_R8 list Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get an ESMF_R8 list Attribute using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name="ESMF_R8_list", attpack=attpack, & 
 valueList=outR8l, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value" 
 write(name, *) "Getting an ESMF_R8 list Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS) .and. all (inR8l==outR8l), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Set a logical Attribute in an Attribute package using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name="ESMF_Logical", value=inLog, & 
 attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting a logical Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get a logical Attribute using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name="ESMF_Logical", attpack=attpack, value=outLog, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value" 
 write(name, *) "Getting a logical Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS) .and. (inLog.eqv.outLog), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Set a logical list Attribute in an Attribute package using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name="ESMF_Logical_list", valueList=inLogl, & 
 attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting a logical list Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get a logical list Attribute using an AttPack object on a Array Test 
 call ESMF_AttributeGet(locStream, name="ESMF_Logical_list", attpack=attpack, & 
 valueList=OutLogl, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Getting a logical list Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS) .and. all (InLogl(1:2).eqv.OutLogl(1:2)), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Set a character Attribute in an Attribute package using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name="ESMF_Character", value=inChar, & 
 attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting a character Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get a character Attribute using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name="ESMF_Character", attpack=attpack, value=outChar, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value" 
 write(name, *) "Getting a character Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS) .and. (inChar==outChar), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Set a character list Attribute in an Attribute package using an AttPack object on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name="ESMF_Character_list", valueList=inCharl, & 
 attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting a character list Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get a character list Attribute using an AttPack object on a Array Test 
 call ESMF_AttributeGet(locStream, name="ESMF_Character_list", attpack=attpack, & 
 valueList=OutCharl, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Getting a character list Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS) .and. all (InCharl(1:2)==OutCharl(1:2)), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Remove an Attribute on "a LocStream" Test 
 call ESMF_AttributeRemove(locStream, name="ESMF_Character_list", attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Removing an Char list Attribute using an AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 isPresent = .false. 
 ! Test for the presence of an AttPack object using a specList on "a LocStream" 
 call ESMF_AttributeGetAttPack(locStream, (/conv, purp/), & 
 isPresent=isPresent, rc=rc) 
 write(failMsg, *) "Did not return isPresent=True" 
 write(name, *) "Test for the presence of an AttPack object using a specList on mobj" 
 call ESMF_Test((rc==ESMF_SUCCESS .and. isPresent.eqv..true.), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get an AttPack using a specList on "a LocStream" test 
 call ESMF_AttributeGetAttPack(locStream, specList=(/conv, purp/), & 
 attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Get an AttPack using a specList on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get the count of an AttPack object on "a LocStream" 
 count = -5 
 call ESMF_AttributeGet(locStream, convention=conv, purpose=purp, & 
 attnestflag=ESMF_ATTNEST_ON, count=count, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Test for getting the Attribute count of an Attpack on mobj, ", & 
 "count = ", count 
 call ESMF_Test((rc==ESMF_SUCCESS .and. count.eq.11), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get the count of an AttPack object on "a LocStream" 
 count = -5 
 call ESMF_AttributeGet(locStream, attpack=attpack, & 
 attnestflag=ESMF_ATTNEST_ON, count=count, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Test for getting the Attribute count using an Attpack object on mobj, ", & 
 "count = ", count 
 call ESMF_Test((rc==ESMF_SUCCESS .and. count.eq.11), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get the count of an AttPack object on "a LocStream" 
 count = -5 
 call ESMF_AttributeGet(locStream, convention=conv, purpose=purp, & 
 attnestflag=ESMF_ATTNEST_ON, & 
 attcountflag=ESMF_ATTGETCOUNT_ATTPACK, & 
 count=count, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Test for getting the Attpack count of an Attpack on mobj, ", & 
 "count = ", count 
 call ESMF_Test((rc==ESMF_SUCCESS .and. count.eq.0), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get the count of an AttPack object on "a LocStream" 
 count = -5 
 call ESMF_AttributeGet(locStream, attpack=attpack, & 
 attnestflag=ESMF_ATTNEST_ON, & 
 attcountflag=ESMF_ATTGETCOUNT_ATTPACK, & 
 count=count, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Test for getting the Attpack count using an Attpack object on mobj, ", & 
 "count = ", count 
 call ESMF_Test((rc==ESMF_SUCCESS .and. count.eq.0), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get the count of an AttPack object on "a LocStream" 
 count = -5 
 call ESMF_AttributeGet(locStream, convention=conv, purpose=purp, & 
 attnestflag=ESMF_ATTNEST_ON, & 
 attcountflag=ESMF_ATTGETCOUNT_ATTLINK, & 
 count=count, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Test for getting the Attlink count of an Attpack on mobj, ", & 
 "count = ", count 
 call ESMF_Test((rc==ESMF_SUCCESS .and. count.eq.0), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get the count of an AttPack object on "a LocStream" 
 count = -5 
 call ESMF_AttributeGet(locStream, attpack=attpack, & 
 attnestflag=ESMF_ATTNEST_ON, & 
 attcountflag=ESMF_ATTGETCOUNT_ATTLINK, & 
 count=count, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Test for getting the Attlink count using an Attpack object on mobj, ", & 
 "count = ", count 
 call ESMF_Test((rc==ESMF_SUCCESS .and. count.eq.0), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !------------------------------------------------------------------------- 
 ! Attribute package - custom nested 
 !------------------------------------------------------------------------- 
 nestconv = "customconvention_top" 
 nestpurp = "custompurpose_top" 
 attpackListTNames2(1) = "ESMF_I4name2" 
 attpackListTNames2(2) = "ESMF_I4namelist2" 
 attpackListTNames2(3) = "ESMF_I8name2" 
 attpackListTNames2(4) = "ESMF_I8namelist2" 
 attpackListTNames2(5) = "ESMF_R4name2" 
 attpackListTNames2(6) = "ESMF_R4namelist2" 
 attpackListTNames2(7) = "ESMF_R8name2" 
 attpackListTNames2(8) = "ESMF_R8namelist2" 
 attpackListTNames2(9) = "Logical_name2" 
 attpackListTNames2(10) = "Logical_namelist2" 
 attpackListTNames2(11) = "Character_name2" 
 attpackListTNames2(12) = "Character_namelist2" 
 attpackDfltList2(1) = "Custom4" 
 attpackDfltList2(2) = "Custom5" 
 attpackDfltList2(3) = "Custom6" 
 attrname = "Character_namelist2" 
 
 !EX_UTest 
 ! Add multiple Attributes to a nested Attribute package on "a LocStream" Test 
 call ESMF_AttributeAdd(locStream, convention=nestconv, purpose=nestpurp, & 
 attrList=attpackListTNames2, nestConvention=conv, nestPurpose=purp, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Adding multiple Attributes to a nested Attribute package on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Remove an Attribute in a nested Attribute package on "a LocStream" Test 
 call ESMF_AttributeRemove(locStream, name=attrname, convention=nestconv, & 
 purpose=nestpurp, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Removeing an Attribute in a nested Attribute package on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Remove an Attribute in a nested Attribute package on "a LocStream" Test, again 
 call ESMF_AttributeRemove(locStream, name=attrname, convention=nestconv, & 
 purpose=nestpurp, rc=rc) 
 write(failMsg, *) "Did not return ESMC_RC_NOT_FOUND" 
 write(name, *) "Removeing an Attribute in a nested Attribute package on mobj Test, again" 
 call ESMF_Test((rc==ESMC_RC_NOT_FOUND), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get a char list default Attribute in a nested Attribute package on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name=attrname, & 
 valueList=attpackListOut4, defaultvalueList=attpackDfltList2, & 
 convention=nestconv, purpose=nestpurp, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Getting a default Attribute character list in a nested Attribute package on mobj test2" 
 call ESMF_Test((rc==ESMF_SUCCESS) .and. all (attpackListOut4 == attpackDfltList2), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !------------------------------------------------------------------------- 
 ! Attribute nestflag get, set and remove 
 !------------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get a nested AttPack on "a LocStream" test 
 call ESMF_AttributeGetAttPack(locStream, conv, purp, & 
 attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Get an AttPack using a specList on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 attrname = "ESMF_Character" 
 !EX_UTest 
 ! Get a char list attribute in a nested Attribute package on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name=attrname, & 
 value=outChar, convention=conv, purpose=purp, & 
 attnestflag=ESMF_ATTNEST_ON, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Getting a char list Attribute in a nested Attribute package on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS) .and. inChar == outChar, & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Set an ESMF_R8 list Attribute using a nested AttPack object object on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name="ESMF_R8_list", valueList=inR8l, & 
 attpack=attpack, attnestflag=ESMF_ATTNEST_ON, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting an ESMF_R8 list Attribute using a nested AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get an ESMF_R8 list Attribute using a nested AttPack object on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name="ESMF_R8_list", attpack=attpack, & 
 attnestflag=ESMF_ATTNEST_ON, valueList=outR8l, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value" 
 write(name, *) "Getting an ESMF_R8 list Attribute using a nested AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS) .and. all (inR8l==outR8l), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Set a logical Attribute using a nested AttPack object on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name="ESMF_Logical", value=inLog, & 
 attpack=attpack, attnestflag=ESMF_ATTNEST_ON, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting a logical Attribute using a nested AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get a logical Attribute using a nested AttPack object on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name="ESMF_Logical", attpack=attpack, & 
 attnestflag=ESMF_ATTNEST_ON, value=outLog, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value" 
 write(name, *) "Getting a logical Attribute using a nested AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS) .and. (inLog.eqv.outLog), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Set a character Attribute using a nested AttPack object on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name="ESMF_Character", value=inChar, & 
 attpack=attpack, attnestflag=ESMF_ATTNEST_ON, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting a character Attribute using a nested AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get a character Attribute using a nested AttPack object on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name="ESMF_Character", attpack=attpack, & 
 attnestflag=ESMF_ATTNEST_ON, value=outChar, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value" 
 write(name, *) "Getting a character Attribute using a nested AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS) .and. (inChar==outChar), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Remove an Attribute using a nested AttPack object on "a LocStream" Test 
 call ESMF_AttributeRemove(locStream, name="ESMF_Character", & 
 attpack=attpack, attnestflag=ESMF_ATTNEST_ON, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Removing an Char list Attribute using a nested AttPack object on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 isPresent = .false. 
 ! Test for the presence of a nested AttPack2 on "a LocStream" 
 call ESMF_AttributeGetAttPack(locStream, conv, purp, isPresent=isPresent, & 
 attnestflag=ESMF_ATTNEST_ON, rc=rc) 
 write(failMsg, *) "Did not return isPresent=True" 
 write(name, *) "Test for the presence of a nested AttPack2 on mobj" 
 call ESMF_Test((rc==ESMF_SUCCESS .and. isPresent.eqv..true.), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get a character Attribute using a nested AttPack object on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name="ESMF_Character", attpack=attpack, & 
 attnestflag=ESMF_ATTNEST_OFF, value=outChar, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value" 
 write(name, *) "Getting a character Attribute in a nested AttPack with ESMF_ATTNEST_OFF on ", "a LocStream", " Test" 
 call ESMF_Test((rc/=ESMF_SUCCESS), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 isPresent = .false. 
 ! Test for the presence of a nested AttPack on "a LocStream" 
 call ESMF_AttributeGet(locStream, name="ESMF_Character", convention=conv, purpose=purp, & 
 attnestflag=ESMF_ATTNEST_ON, isPresent=isPresent, rc=rc) 
 write(failMsg, *) "Did not return isPresent=True" 
 write(name, *) "Test for the presence of a nested AttPack on mobj" 
 call ESMF_Test((rc==ESMF_SUCCESS .and. isPresent.eqv..false.), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 isPresent = .false. 
 ! Test for the presence of a nested AttPack on "a LocStream" 
 call ESMF_AttributeGet(locStream, 3, attrname, convention=conv, purpose=purp, & 
 attnestflag=ESMF_ATTNEST_ON, isPresent=isPresent, rc=rc) 
 write(failMsg, *) "Did not return isPresent=True" 
 write(name, *) "Test for the presence of a nested AttPack on mobj" 
 call ESMF_Test((rc==ESMF_SUCCESS .and. isPresent.eqv..true.), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !------------------------------------------------------------------------- 
 ! Attribute package counts 
 !------------------------------------------------------------------------- 
 
 ! Get the count of an AttPack object on "a LocStream" Test 
 count = -5 
 !EX_UTest 
 call ESMF_AttributeGet(locStream, count, & 
 convention=nestconv, purpose=nestpurp, & 
 attcountflag=ESMF_ATTGETCOUNT_ATTRIBUTE, & 
 attnestflag=ESMF_ATTNEST_OFF, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Test for getting the count of Attributes in a ", & 
 " nested Attpack, count = ", count 
 call ESMF_Test((rc==ESMF_SUCCESS .and. count.eq.11), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 ! Get the count of an AttPack object on "a LocStream" Test 
 count = -5 
 !EX_UTest 
 call ESMF_AttributeGet(locStream, count, & 
 convention=nestconv, purpose=nestpurp, & 
 attcountflag=ESMF_ATTGETCOUNT_ATTPACK, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Test for getting the count of Attpacks in a ", & 
 " nested Attpack, count = ", count 
 call ESMF_Test((rc==ESMF_SUCCESS .and. count.eq.1), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 ! Get the count of an AttPack object on "a LocStream" Test 
 count = -5 
 !EX_UTest 
 call ESMF_AttributeGet(locStream, count, & 
 convention=nestconv, purpose=nestpurp, & 
 attcountflag=ESMF_ATTGETCOUNT_ATTLINK, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Test for getting the count of Attlinks in a ", & 
 " nested Attpack, count = ", count 
 call ESMF_Test((rc==ESMF_SUCCESS .and. count.eq.0), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 ! Get the count of an AttPack object on "a LocStream" Test 
 count = -5 
 !EX_UTest 
 call ESMF_AttributeGet(locStream, count, & 
 convention=conv, purpose=purp, & 
 attcountflag=ESMF_ATTGETCOUNT_ATTRIBUTE, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Test for getting the count of Attributes in a ", & 
 " nested Attpack, count = ", count 
 call ESMF_Test((rc==ESMF_SUCCESS .and. count.eq.10), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 ! Get the count of an AttPack object on "a LocStream" Test 
 count = -5 
 !EX_UTest 
 call ESMF_AttributeGet(locStream, count, & 
 convention=conv, purpose=purp, & 
 attcountflag=ESMF_ATTGETCOUNT_ATTPACK, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Test for getting the count of Attpacks in a ", & 
 " nested Attpack, count = ", count 
 call ESMF_Test((rc==ESMF_SUCCESS .and. count.eq.0), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 ! Get the count of an AttPack object on "a LocStream" Test 
 count = -5 
 !EX_UTest 
 call ESMF_AttributeGet(locStream, count, & 
 convention=conv, purpose=purp, & 
 attcountflag=ESMF_ATTGETCOUNT_ATTLINK, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Test for getting the count of Attlinks in a ", & 
 " nested Attpack, count = ", count 
 call ESMF_Test((rc==ESMF_SUCCESS .and. count.eq.0), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !------------------------------------------------------------------------- 
 ! Attribute nestflag 
 !------------------------------------------------------------------------- 
 
 ! Get the count of an AttPack object on "a LocStream" Test 
 count = -5 
 !EX_UTest 
 call ESMF_AttributeGet(locStream, count, & 
 convention=nestconv, purpose=nestpurp, & 
 attcountflag=ESMF_ATTGETCOUNT_ATTRIBUTE, & 
 attnestflag=ESMF_ATTNEST_OFF, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Test for getting the count of Attributes in a ", & 
 " nested Attpack, count = ", count 
 call ESMF_Test((rc==ESMF_SUCCESS .and. count.eq.11), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 ! Get the count of an AttPack object on "a LocStream" Test 
 count = -5 
 !EX_UTest 
 call ESMF_AttributeGet(locStream, count, & 
 convention=nestconv, purpose=nestpurp, & 
 attcountflag=ESMF_ATTGETCOUNT_ATTRIBUTE, & 
 attnestflag=ESMF_ATTNEST_ON, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Test for getting the count of Attributes in a ", & 
 "nested Attpack, count = ", count 
 call ESMF_Test((rc==ESMF_SUCCESS .and. count.eq.21), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 ! Get all Attributes in an AttPack object by index on "a LocStream" Test 
 !EX_UTest 
 do i = 1, count 
 call ESMF_AttributeGet(locStream, attributeIndex=i, name=name, & 
 convention=nestconv, purpose=nestpurp, & 
 attnestflag=ESMF_ATTNEST_ON, rc=rc) 
 if (rc /= ESMF_SUCCESS) continue 
 enddo 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Get all Attributes in an AttPack object by index Test", & 
 ", count = ", count, & 
 ", convention = ", trim(conv), & 
 ", purpose = ", trim(purp) 
 call ESMF_Test((rc==ESMF_SUCCESS), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 ! Get the count of an AttPack object on "a LocStream" Test 
 count = -5 
 !EX_UTest 
 call ESMF_AttributeGet(locStream, attributeIndex=12, name=name, & 
 convention=nestconv, purpose=nestpurp, & 
 attnestflag=ESMF_ATTNEST_OFF, rc=rc) 
 write(failMsg, *) "Did not return ESMC_RC_NOT_FOUND, rc = ", rc 
 write(name, *) "Test for getting an Attribute in a nested Attpack by ", & 
 " index too large with ATTNESTFLAG_OFF" 
 call ESMF_Test((rc==ESMC_RC_NOT_FOUND), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 ! Get the count of an AttPack object on "a LocStream" Test 
 count = -5 
 !EX_UTest 
 call ESMF_AttributeGet(locStream, attributeIndex=12, name=attrname, & 
 convention=nestconv, purpose=nestpurp, & 
 attnestflag=ESMF_ATTNEST_ON, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS, rc = ", rc 
 write(name, *) "Test for getting an Attribute in a nested Attpack by ", & 
 " index too large with ATTNESTFLAG_ON" 
 call ESMF_Test((rc==ESMF_SUCCESS), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !------------------------------------------------------------------------- 
 ! Attribute package - custom with removal and defaults
 !------------------------------------------------------------------------- 
 conv = "customconvention2" 
 purp = "custompurpose2" 
 attpackList(1) = "Custom1" 
 attpackList(2) = "Custom2" 
 attpackList(3) = "Custom3" 
 
 !EX_UTest 
 ! Create a custom Attribute package on "a LocStream" Test 
 call ESMF_AttributeAdd(locStream, convention=conv, & 
 purpose=purp, attrList=attpackList(1:3), rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Creating a custom Attribute package on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !------------------------------------------------------------------------- 
 ! AttributeWrite 
 !------------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Write the Attribute package to .xml from "a LocStream" Test 
 call ESMF_AttributeWrite(locStream, convention=conv, purpose=purp, & 
 attwriteflag=ESMF_ATTWRITE_XML, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Writing an Attribute package to .xml from ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS .or. rc==ESMF_RC_LIB_NOT_PRESENT), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! compare the output file to the baseline file 
 exclusions(1) = "ESMF Version" 
 write (filename, "(2a)") "LocStream002", ".xml" 
 write (baseline, "(3a)") "baseline_", "LocStream002", ".xml" 
 rc_logical = ESMF_TestFileCompare(filename, baseline, & 
 exclusionList=exclusions) 
 write(failMsg, *) "Did not return True" 
 write(name, *) "Compare the XML output file to the baseline file" 
 call ESMF_Test(rc_logical.eqv..true., name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 print *, "rc = ", rc_logical, " filename = ", trim(filename), & 
 " and baseline = ", trim(baseline) 
 
 !EX_UTest 
 ! Write the Attribute package to .stdout from "a LocStream" Test 
 call ESMF_AttributeWrite(locStream, convention=conv, purpose=purp, & 
 attwriteflag=ESMF_ATTWRITE_TAB, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Writing an Attribute package to .stdout from ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! compare the output file to the baseline file 
 write (filename, "(2a)") "LocStream002", ".stdout" 
 write (baseline, "(3a)") "baseline_", "LocStream002", ".stdout" 
 rc_logical = ESMF_TestFileCompare(filename, baseline) 
 write(failMsg, *) "Did not return True" 
 write(name, *) "Compare the stdout output file to the baseline file" 
 call ESMF_Test(rc_logical.eqv..true., name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 print *, "rc = ", rc_logical, " filename = ", trim(filename), & 
 " and baseline = ", trim(baseline) 
 
 !------------------------------------------------------------------------- 
 ! Get an Attribute which was not set from an Attribute package 
 !------------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get an ESMF_I4 Attribute from "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name="NotHere", value=outI4, & 
 convention=conv, purpose=purp, rc=rc) 
 write(failMsg, *) "Did not return ESMF_RC_ATTR_NOTSET" 
 write(name, *) "Getting a nonexistent Attribute from ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_RC_ATTR_NOTSET), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 attrname = "Custom1" 
 attrvalue = "m/s" 
 
 !EX_UTest 
 ! Set an Attribute in an Attribute package on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name=attrname, value=attrvalue, & 
 convention=conv, purpose=purp, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting an Attribute in an Attribute package on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 attrname = "Custom2" 
 
 !EX_UTest 
 ! Set a char list Attribute in an Attribute package on "a LocStream" Test 
 call ESMF_AttributeSet(locStream, name=attrname, & 
 valueList=attpackList(1:3), convention=conv, purpose=purp, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Setting a char list Attribute in an Attribute package on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Get a char list Attribute in an Attribute package on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name=attrname, & 
 valueList=attpackListOut3, convention=conv, purpose=purp, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Getting a char list Attribute in an Attribute package on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS) .and. all (attpackList(1:3) == attpackListOut3), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Remove an Attribute in an Attribute package on "a LocStream" Test 
 call ESMF_AttributeRemove(locStream, name=attrname, convention=conv, purpose=purp, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Removeing an Attribute in an Attribute package on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 attpackDfltList(1) = "Custom4" 
 attpackDfltList(2) = "Custom5" 
 attpackDfltList(3) = "Custom6" 
 !EX_UTest 
 ! Get a char list default Attribute in an Attribute package on "a LocStream" Test 
 call ESMF_AttributeGet(locStream, name=attrname, & 
 valueList=attpackListOut2, defaultvalueList=attpackDfltList, & 
 convention=conv, purpose=purp, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Getting a default Attribute character list in an Attribute package on ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS) .and. all (attpackListOut2 == attpackDfltList), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Test for the presence of an AttPack object on "a LocStream" 
 call ESMF_AttributeGet(locStream, name="NotHere", value=outI4, & 
 attpack=attpack, isPresent=isPresent, rc=rc) 
 write(failMsg, *) "Did not return isPresent=False" 
 write(name, *) "Test for the presence of an AttPack object on mobj" 
 call ESMF_Test((rc==ESMF_SUCCESS .and. isPresent.eqv..false.), & 
 name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Remove the entire Attribute package from "a LocStream" Test 
 call ESMF_AttributeRemove(locStream, convention=conv, purpose=purp, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Removing the entire Attribute package from ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
 !EX_UTest 
 ! Remove the entire Attribute package from "a LocStream" Test 
 call ESMF_AttributeRemove(locStream, attpack=attpack, rc=rc) 
 write(failMsg, *) "Did not return ESMF_SUCCESS" 
 write(name, *) "Removing the entire Attribute package from ", "a LocStream", " Test" 
 call ESMF_Test((rc==ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE) 
 !---------------------------------------------------------------------- 
 
#endif 
! < end macro - do not edit directly > 
!------------------------------------------------------------------------------
  call ESMF_LocStreamDestroy(locStream, rc=rc)
  if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
  !-----------------------------------------------------------------------------
  call ESMF_TestEnd(ESMF_SRCLINE)
  !-----------------------------------------------------------------------------
end program ESMF_AttPackLocStreamUTest
