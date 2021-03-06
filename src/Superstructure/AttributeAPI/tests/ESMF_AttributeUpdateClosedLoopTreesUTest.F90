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
module ESMF_AttributeUpdateClosedLoopTreesUTestMod

  use ESMF

  implicit none

  private

  public userm1_setvm, userm1_register
  public userm2_setvm, userm2_register
  public usercpl_setvm, usercpl_register

  contains

  !-------------------------------------------------------------------------
!   !  The SetVM Register routines for Gridcomp1

  subroutine userm1_setvm(comp, rc)
    type(ESMF_GridComp)  :: comp
    integer, intent(out) :: rc

#ifdef ESMF_TESTWITHTHREADS
    type(ESMF_VM) :: vm
    logical :: pthreadsEnabled
#endif

    ! Initialize return code
    rc = ESMF_SUCCESS

#ifdef ESMF_TESTWITHTHREADS
    ! The following call will turn on ESMF-threading (single threaded)
    ! for this component. If you are using this file as a template for
    ! your own code development you probably don't want to include the
    ! following call unless you are interested in exploring ESMF's
    ! threading features.

    ! First test whether ESMF-threading is supported on this machine
    call ESMF_VMGetGlobal(vm, rc=rc)
    call ESMF_VMGet(vm, pthreadsEnabledFlag=pthreadsEnabled, rc=rc)
    if (pthreadsEnabled) then
      call ESMF_GridCompSetVMMinThreads(comp, rc=rc)
    endif
#endif

  end subroutine userm1_setvm

  subroutine userm1_register(comp, rc)
    type(ESMF_GridComp)  :: comp
    integer, intent(out) :: rc

    ! Initialize return code
    rc = ESMF_SUCCESS

    ! Register the callback routines.

    call ESMF_GridCompSetEntryPoint(comp, ESMF_METHOD_INITIALIZE, userm1_init, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_GridCompSetEntryPoint(comp, ESMF_METHOD_RUN, userm1_run, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_GridCompSetEntryPoint(comp, ESMF_METHOD_FINALIZE, userm1_final, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out

  end subroutine userm1_register

!-------------------------------------------------------------------------
!   !  The SetVM Register routines for Gridcomp2

  subroutine userm2_setvm(comp, rc)
    type(ESMF_GridComp)  :: comp
    integer, intent(out) :: rc

#ifdef ESMF_TESTWITHTHREADS
    type(ESMF_VM) :: vm
    logical :: pthreadsEnabled
#endif

    ! Initialize return code
    rc = ESMF_SUCCESS

#ifdef ESMF_TESTWITHTHREADS
    ! The following call will turn on ESMF-threading (single threaded)
    ! for this component. If you are using this file as a template for
    ! your own code development you probably don't want to include the
    ! following call unless you are interested in exploring ESMF's
    ! threading features.

    ! First test whether ESMF-threading is supported on this machine
    call ESMF_VMGetGlobal(vm, rc=rc)
    call ESMF_VMGet(vm, pthreadsEnabledFlag=pthreadsEnabled, rc=rc)
    if (pthreadsEnabled) then
      call ESMF_GridCompSetVMMinThreads(comp, rc=rc)
    endif
#endif

  end subroutine userm2_setvm

  subroutine userm2_register(comp, rc)
    type(ESMF_GridComp)  :: comp
    integer, intent(out) :: rc

    ! Initialize return code
    rc = ESMF_SUCCESS

    ! Register the callback routines.

    call ESMF_GridCompSetEntryPoint(comp, ESMF_METHOD_INITIALIZE, userm2_init, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_GridCompSetEntryPoint(comp, ESMF_METHOD_RUN, userm2_run, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_GridCompSetEntryPoint(comp, ESMF_METHOD_FINALIZE, userm2_final, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out

  end subroutine userm2_register

!-------------------------------------------------------------------------
!   !  The SetVM Register routines for cplcomp

  subroutine usercpl_setvm(comp, rc)
    type(ESMF_CplComp) :: comp
    integer, intent(out) :: rc

#ifdef ESMF_TESTWITHTHREADS
    type(ESMF_VM) :: vm
    logical :: pthreadsEnabled
#endif

    ! Initialize return code
    rc = ESMF_SUCCESS

#ifdef ESMF_TESTWITHTHREADS
    ! The following call will turn on ESMF-threading (single threaded)
    ! for this component. If you are using this file as a template for
    ! your own code development you probably don't want to include the
    ! following call unless you are interested in exploring ESMF's
    ! threading features.

    ! First test whether ESMF-threading is supported on this machine
    call ESMF_VMGetGlobal(vm, rc=rc)
    call ESMF_VMGet(vm, pthreadsEnabledFlag=pthreadsEnabled, rc=rc)
    if (pthreadsEnabled) then
      call ESMF_CplCompSetVMMinThreads(comp, rc=rc)
    endif
#endif

  end subroutine usercpl_setvm

  subroutine usercpl_register(comp, rc)
    type(ESMF_CplComp) :: comp
    integer, intent(out) :: rc

    ! Initialize return code
    rc = ESMF_SUCCESS

    ! Register the callback routines.
    call ESMF_CplCompSetEntryPoint(comp, ESMF_METHOD_INITIALIZE, usercpl_init, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_CplCompSetEntryPoint(comp, ESMF_METHOD_RUN, usercpl_run, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_CplCompSetEntryPoint(comp, ESMF_METHOD_FINALIZE, usercpl_final, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out

  end subroutine usercpl_register

!-------------------------------------------------------------------------
!   !  User Comp Component created by higher level calls, here is the
!   !   Initialization routine.


  subroutine userm1_init(comp, importState, exportState, clock, rc)
    type(ESMF_GridComp) :: comp
    type(ESMF_State) :: importState, exportState
    type(ESMF_Clock) :: clock
    integer, intent(out) :: rc

    type(ESMF_AttPack)        :: attpack
    type(ESMF_VM)               :: vm
    integer                     :: petCount, status, myPet
    character(ESMF_MAXSTR)      :: name1,name2,name3,name4,value1,value2, &
                                   value3,value4,convESMF,purpGen,convCC
    type(ESMF_ArraySpec)        :: arrayspec
    type(ESMF_Grid)             :: grid1, grid2
    type(ESMF_Field)            :: field1, field12, field2
    type(ESMF_FieldBundle)      :: fieldbundle
    character(ESMF_MAXSTR),dimension(2)   :: attrList

    rc = ESMF_SUCCESS

    call ESMF_GridCompGet(comp, vm=vm, rc=status)
    if (status .ne. ESMF_SUCCESS) return
    call ESMF_VMGet(vm, petCount=petCount, localPet=myPet, rc=status)
    if (status .ne. ESMF_SUCCESS) return

    call ESMF_ArraySpecSet(arrayspec, typekind=ESMF_TYPEKIND_R8, rank=2, rc=rc)
    if (rc/=ESMF_SUCCESS) return
    grid1 = ESMF_GridCreateNoPeriDim(minIndex=(/1,1/), maxIndex=(/100,150/), &
      regDecomp=(/1,petCount/), &
      gridEdgeLWidth=(/0,0/), gridEdgeUWidth=(/0,0/), &
      indexflag=ESMF_INDEX_GLOBAL, rc=rc)
    if (rc/=ESMF_SUCCESS) return
    grid2 = ESMF_GridCreateNoPeriDim(minIndex=(/1,1/), maxIndex=(/100,150/), &
      regDecomp=(/1,petCount/), &
      gridEdgeLWidth=(/0,0/), gridEdgeUWidth=(/0,0/), &
      indexflag=ESMF_INDEX_GLOBAL, rc=rc)
    if (rc/=ESMF_SUCCESS) return

    convCC = 'CustomConvention'
    convESMF = 'ESMF'
    purpGen = 'General'
    name1 = 'ShortName'
    name2 = 'StandardName'
    name3 = 'LongName'
    name4 = 'Units'

    value1 = 'field'
    value2 = 'tendency_of_air_pressure'
    value3 = 'Edge pressure tendency'
    value4 = 'Pa s-1'

    field1 = ESMF_FieldCreate(grid1, arrayspec=arrayspec, &
              staggerloc=ESMF_STAGGERLOC_CENTER, name="field1", rc=status)
    call ESMF_AttributeAdd(field1, convention=convESMF, purpose=purpGen, &
      rc=status)
    call ESMF_AttributeSet(field1, name1, value1, &
      convention=convESMF, purpose=purpGen, rc=status)
    call ESMF_AttributeSet(field1, name2, value2, &
      convention=convESMF, purpose=purpGen, rc=status)
    call ESMF_AttributeSet(field1, name3, value3, &
      convention=convESMF, purpose=purpGen, rc=status)
    call ESMF_AttributeSet(field1, name4, value4, &
      convention=convESMF, purpose=purpGen, rc=status)
    if (status .ne. ESMF_SUCCESS) return

    field12 = ESMF_FieldCreate(grid1, arrayspec=arrayspec, &
              staggerloc=ESMF_STAGGERLOC_CENTER, name="field12", rc=status)
    call ESMF_AttributeAdd(field12, convention=convESMF, purpose=purpGen, &
      rc=status)
    call ESMF_AttributeSet(field12, name1, value1, &
      convention=convESMF, purpose=purpGen, rc=status)
    call ESMF_AttributeSet(field12, name2, value2, &
      convention=convESMF, purpose=purpGen, rc=status)
    call ESMF_AttributeSet(field12, name3, value3, &
      convention=convESMF, purpose=purpGen, rc=status)
    call ESMF_AttributeSet(field12, name4, value4, &
      convention=convESMF, purpose=purpGen, rc=status)
    if (status .ne. ESMF_SUCCESS) return

    field2 = ESMF_FieldCreate(grid2, arrayspec=arrayspec, &
              staggerloc=ESMF_STAGGERLOC_CENTER, name="field2", rc=status)
    call ESMF_AttributeAdd(field2, convention=convESMF, purpose=purpGen, &
      rc=status)
    call ESMF_AttributeSet(field2, name1, value1, &
      convention=convESMF, purpose=purpGen, rc=status)
    call ESMF_AttributeSet(field2, name2, value2, &
      convention=convESMF, purpose=purpGen, rc=status)
    call ESMF_AttributeSet(field2, name3, value3, &
      convention=convESMF, purpose=purpGen, rc=status)
    call ESMF_AttributeSet(field2, name4, value4, &
      convention=convESMF, purpose=purpGen, rc=status)
    if (status .ne. ESMF_SUCCESS) return

    ! Create the Grid Attribute Package
    call ESMF_AttributeAdd(grid1,convention=convESMF, purpose=purpGen, rc=status)
    call ESMF_AttributeSet(grid1,'RegDecompX', 96, &
      convention=convESMF, purpose=purpGen, rc=status)
    call ESMF_AttributeSet(grid1,'RegDecompY', 84, &
      convention=convESMF, purpose=purpGen, rc=status)
    if (status .ne. ESMF_SUCCESS) return

    call ESMF_AttributeAdd(grid2,convention=convESMF, purpose=purpGen, rc=status)
    call ESMF_AttributeSet(grid2,'RegDecompX', 96, &
      convention=convESMF, purpose=purpGen, rc=status)
    call ESMF_AttributeSet(grid2,'RegDecompY', 84, &
      convention=convESMF, purpose=purpGen, rc=status)
    if (status .ne. ESMF_SUCCESS) return

    fieldbundle = ESMF_FieldBundleCreate(name="fieldbundle", rc=status)
    if (status .ne. ESMF_SUCCESS) return

    call ESMF_FieldBundleSet(fieldbundle, grid=grid1, rc=status)
    if (status .ne. ESMF_SUCCESS) return

    call ESMF_FieldBundleAdd(fieldbundle, (/ field1, field12 /), rc=status)
    if (status .ne. ESMF_SUCCESS) return

    call ESMF_StateAdd(exportState, fieldbundleList=(/fieldbundle/), rc=status)
    call ESMF_StateAdd(exportState, fieldList=(/field2/), rc=status)
    if (status .ne. ESMF_SUCCESS) return

  end subroutine userm1_init

!-------------------------------------------------------------------------
!   !  User Comp Component created by higher level calls, here is the
!   !   Initialization routine.


  subroutine userm2_init(comp, importState, exportState, clock, rc)
    type(ESMF_GridComp) :: comp
    type(ESMF_State) :: importState, exportState
    type(ESMF_Clock) :: clock
    integer, intent(out) :: rc

   ! Initialize return code
    rc = ESMF_SUCCESS

  end subroutine userm2_init

!-------------------------------------------------------------------------
!   !User Comp Component created by higher level calls, here is the
!   ! Initialization routine.

  subroutine usercpl_init(comp, importState, exportState, clock, rc)
    type(ESMF_CplComp) :: comp
    type(ESMF_State) :: importState, exportState
    type(ESMF_Clock) :: clock
    integer, intent(out) :: rc

    type(ESMF_VM)         :: vm

    rc = ESMF_SUCCESS

    call ESMF_CplCompGet(comp, vm=vm, rc=rc)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_StateReconcile(importState, vm=vm, attreconflag=ESMF_ATTRECONCILE_ON, rc=rc)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_StateReconcile(exportState, vm=vm, attreconflag=ESMF_ATTRECONCILE_ON, rc=rc)
    if (rc/=ESMF_SUCCESS) return

  end subroutine usercpl_init

!-------------------------------------------------------------------------
!   !  The Run routine where data is computed.
!   !

  subroutine userm1_run(comp, importState, exportState, clock, rc)
    type(ESMF_GridComp) :: comp
    type(ESMF_State) :: importState, exportState
    type(ESMF_Clock) :: clock
    integer, intent(out) :: rc

    type(ESMF_AttPack)        :: attpack, attpack_nested
    type(ESMF_VM)               :: vm
    integer                     :: petCount, status, myPet
    character(ESMF_MAXSTR)      :: name2,value2,convESMF,purpGen,purp2,name3
    character(ESMF_MAXSTR),dimension(2) :: attrList, valueList
    type(ESMF_Field)            :: field1, field12, field2
    type(ESMF_FieldBundle)      :: fieldbundle
    type(ESMF_Grid)             :: grid_from_field1, grid_from_field12, &
                                   grid_from_fb, grid_from_field2

    integer :: outInt(4)

    rc = ESMF_SUCCESS

    convESMF = 'ESMF'
    purpGen = 'General'
    name2 = 'StandardName'
    value2 = 'default_standard_name'
    name3 = 'LongName'

    purp2 = 'Extended'
    attrList(1) = 'Coordinates'
    attrList(2) = 'Mask'
    valueList(1) = "Latlon"
    valueList(2) = "Yes"

    call ESMF_GridCompGet(comp, vm=vm, rc=status)
    if (status .ne. ESMF_SUCCESS) return
    call ESMF_VMGet(vm, petCount=petCount, localPet=myPet, rc=status)
    if (status .ne. ESMF_SUCCESS) return

    call ESMF_StateGet(exportState, "fieldbundle", fieldbundle, rc=rc)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_FieldBundleGet(fieldbundle, grid=grid_from_fb, rc=rc)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_FieldBundleGet(fieldbundle, fieldname="field1", field=field1, rc=rc)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_FieldBundleGet(fieldbundle, fieldname="field12", field=field12, rc=rc)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_FieldGet(field1, grid=grid_from_field1, rc=rc)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_FieldGet(field12, grid=grid_from_field12, rc=rc)
    if (rc/=ESMF_SUCCESS) return

    ! Modify Attributes on one Field in the FieldBundle
    call ESMF_AttributeGetAttPack(field1, convESMF, purpGen, attpack=attpack, rc=status)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_AttributeSet(field1, name2, value2, attpack=attpack, rc=status)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_AttributeAdd(field1, convention=convESMF, purpose=purp2, &
      attrList=attrList, nestConvention=convESMF, nestPurpose=purpGen, rc=rc)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_AttributeSet(field1, attrList(1), valueList(1), &
      convention=convESMF, purpose=purp2, rc=rc)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_AttributeSet(field1, attrList(2), valueList(2), &
      convention=convESMF, purpose=purp2, rc=rc)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_AttributeRemove(field1, name=name3, convention=convESMF, &
      purpose=purpGen, rc=status)
    if (rc/=ESMF_SUCCESS) return

    ! Modify Attributes on grid_from_field1
    call ESMF_AttributeGetAttPack(grid_from_field1, convESMF, purpGen, attpack=attpack, rc=status)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_AttributeSet(grid_from_field1, 'RegDecompX', 106, &
      attpack=attpack, rc=status)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_AttributeGet(grid_from_field1, 'RegDecompX', attpack=attpack, &
        value=outInt(1), rc=status)
    if (rc/=ESMF_SUCCESS) return

    ! Modify Attributes on grid_from_field12
    call ESMF_AttributeGetAttPack(grid_from_field12, convESMF, purpGen, attpack=attpack, rc=status)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_AttributeSet(grid_from_field12, 'RegDecompX', 126, &
      attpack=attpack, rc=status)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_AttributeGet(grid_from_field1, 'RegDecompX', attpack=attpack, &
        value=outInt(2), rc=status)
    if (rc/=ESMF_SUCCESS) return

    ! Modify Attributes on grid_from_fb
    call ESMF_AttributeGetAttPack(grid_from_fb, convESMF, purpGen, attpack=attpack, rc=status)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_AttributeSet(grid_from_fb, 'RegDecompX', 306, attpack=attpack, &
      rc=status)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_AttributeGet(grid_from_field1, 'RegDecompX', attpack=attpack, &
        value=outInt(3), rc=status)
    if (rc/=ESMF_SUCCESS) return

    ! Modify Attribute on the Grid that is on the Field that is not part of the Fieldbundle
    call ESMF_StateGet(exportState, "field2", field2, rc=rc)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_FieldGet(field2, grid=grid_from_field2, rc=rc)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_AttributeGetAttPack(grid_from_field2, convESMF, purpGen, attpack=attpack, rc=status)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_AttributeSet(grid_from_field2, 'RegDecompX', 206, &
      attpack=attpack, rc=status)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_AttributeGet(grid_from_field1, 'RegDecompX', attpack=attpack, &
        value=outInt(4), rc=status)
    if (rc/=ESMF_SUCCESS) return


    print *, "RUN"
    if (outInt(1) /= 106) then
        print *, "grid_from_field1 reset to :", outInt(1)
    else if (outInt(2) /= 126) then
        print *, "grid_from_field1 reset to :", outInt(2)
    else if (outInt(3) /= 306) then
        print *, "grid_from_field1 reset to :", outInt(3)
    else if (outInt(4) /= 206) then
        print *, "grid_from_field1 reset to :", outInt(4)
    endif

    !RegDecompX' =
    ! 96 - original
    ! 106 - grid_from_field1
    ! 126 - grid_from_field12
    ! 306 - grid_from_fb
    ! 206 - grid_from_field2

  end subroutine userm1_run

!-------------------------------------------------------------------------
!   !  The Run routine where data is coupled.
!   !

  subroutine usercpl_run(comp, importState, exportState, clock, rc)
    type(ESMF_CplComp) :: comp
    type(ESMF_State) :: importState, exportState
    type(ESMF_Clock) :: clock
    integer, intent(out) :: rc

    type(ESMF_VM)               :: vm
    integer                     :: myPet

    integer, dimension(2)       :: rootList

    rc = ESMF_SUCCESS

    call ESMF_CplCompGet(comp, vm=vm, rc=rc)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_VMGet(vm, localPet=myPet, rc=rc)
    if (rc/=ESMF_SUCCESS) return

    call ESMF_StateGet(importState, rc=rc)
    if (rc/=ESMF_SUCCESS) return
    call ESMF_StateGet(exportState, rc=rc)
    if (rc/=ESMF_SUCCESS) return

    rootList = (/0,1/)
    call ESMF_AttributeUpdate(importState, vm, rootList=rootList, rc=rc)
    if (rc/=ESMF_SUCCESS) return

    !call ESMF_AttributeCopy(importState, exportState, &
    !  attcopy=ESMF_ATTCOPY_HYBRID, rc=rc)
    if (rc/=ESMF_SUCCESS) return

  end subroutine usercpl_run

!-------------------------------------------------------------------------
!   !  The Run routine where data is computed.
!   !

  subroutine userm2_run(comp, importState, exportState, clock, rc)
    type(ESMF_GridComp) :: comp
    type(ESMF_State) :: importState, exportState
    type(ESMF_Clock) :: clock
    integer, intent(out) :: rc

    type(ESMF_VM)               :: vm
    integer                     :: petCount, status, myPet
    character(ESMF_MAXSTR)      :: convESMF,purpGen

    rc = ESMF_SUCCESS

    call ESMF_GridCompGet(comp, vm=vm, rc=status)
    if (status .ne. ESMF_SUCCESS) return
    call ESMF_VMGet(vm, petCount=petCount, localPet=myPet, rc=status)
    if (status .ne. ESMF_SUCCESS) return

    convESMF = 'ESMF'
    purpGen = 'General'

#if 0
    if (myPet .eq. 2) then
      call ESMF_AttributeWrite(importState,convESMF,purpGen, &
        attwriteflag=ESMF_ATTWRITE_XML, rc=rc)
      call ESMF_AttributeWrite(importState,convESMF,purpGen,rc=rc)
      if (rc .ne. ESMF_SUCCESS) return
    endif
#endif

  end subroutine userm2_run

!-------------------------------------------------------------------------
!   !  The Finalization routine where things are deleted and cleaned up.
!   !

  subroutine userm1_final(comp, importState, exportState, clock, rc)
    type(ESMF_GridComp) :: comp
    type(ESMF_State) :: importState, exportState
    type(ESMF_Clock) :: clock
    integer, intent(out) :: rc

    type(ESMF_Field)            :: field1, field12, field2
    type(ESMF_FieldBundle)      :: fieldbundle
    type(ESMF_Grid)             :: grid_from_field1, grid_from_field12, &
                                   grid_from_fb, grid_from_field2
    integer                     :: k

    ! Initialize return code
    rc = ESMF_SUCCESS

    call ESMF_StateGet(exportState, "fieldbundle", fieldbundle, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_StateGet(exportState, "field2", field2, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_FieldBundleGet(fieldbundle, fieldname="field1", field=field1, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_FieldBundleGet(fieldbundle, fieldname="field12", field=field12, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_FieldBundleGet(fieldbundle, grid=grid_from_fb, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_FieldGet(field1, grid=grid_from_field1, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_FieldGet(field12, grid=grid_from_field12, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_FieldGet(field2, grid=grid_from_field2, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_FieldDestroy(field1, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_FieldDestroy(field12, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_FieldDestroy(field2, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_GridDestroy(grid_from_fb, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_GridDestroy(grid_from_field1, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_GridDestroy(grid_from_field12, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_GridDestroy(grid_from_field2, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out
    call ESMF_FieldBundleDestroy(fieldbundle, rc=rc)
    if (rc/=ESMF_SUCCESS) return ! bail out

  end subroutine userm1_final

!-------------------------------------------------------------------------
!   !  The Finalization routine where things are deleted and cleaned up.
!   !

  subroutine userm2_final(comp, importState, exportState, clock, rc)
    type(ESMF_GridComp) :: comp
    type(ESMF_State) :: importState, exportState
    type(ESMF_Clock) :: clock
    integer, intent(out) :: rc

    ! Initialize return code
    rc = ESMF_SUCCESS

  end subroutine userm2_final

!-------------------------------------------------------------------------
!   !  The Finalization routine where things are deleted and cleaned up.
!   !

  subroutine usercpl_final(comp, importState, exportState, clock, rc)
    type(ESMF_CplComp) :: comp
    type(ESMF_State) :: importState, exportState
    type(ESMF_Clock) :: clock
    integer, intent(out) :: rc

    ! Initialize return code
    rc = ESMF_SUCCESS

  end subroutine usercpl_final

end module

program ESMF_AttributeUpdateClosedLoopTreesUTest

#include "ESMF.h"

!==============================================================================
!BOP
! !PROGRAM: ESMF_AttributeUpdateClosedLoopTreesUTestMod - Attribute Update Unit Tests
!
! !DESCRIPTION:
!
! The code in this file drives F90 Attribute Update unit tests.
!
!-----------------------------------------------------------------------------
! !USES:
  use ESMF
  use ESMF_TestMod
  use ESMF_AttributeUpdateClosedLoopTreesUTestMod, only : userm1_setvm, userm1_register, &
    userm2_setvm, userm2_register, usercpl_setvm, usercpl_register


  implicit none

!------------------------------------------------------------------------------
! The following line turns the CVS identifier string into a printable variable.
    character(*), parameter :: version = &
    '$Id$'
!------------------------------------------------------------------------------


    ! individual test failure message
    character(ESMF_MAXSTR) :: failMsg
    character(ESMF_MAXSTR) :: name

    ! cumulative result: count failures; no failures equals "all pass"
    integer :: result = 0

    ! individual test result code
    integer :: rc = ESMF_SUCCESS

    ! local variables
      integer                 :: petCount, localPet
      type(ESMF_VM)           :: vm
      type(ESMF_State)        :: c1exp, c2imp
      type(ESMF_GridComp)     :: gridcomp1
      type(ESMF_GridComp)     :: gridcomp2
      type(ESMF_CplComp)      :: cplcomp
      character(ESMF_MAXSTR)  :: convESMF,purpGen

        type(ESMF_AttPack)        :: attpack
    type(ESMF_Field)          :: field1, field12, field2
    type(ESMF_FieldBundle)    :: fieldbundle
    type(ESMF_Grid)           :: grid_from_field1, grid_from_field12, &
                                 grid_from_fb, grid_from_field2

    integer                   :: k, outInt, expectedOut(5)

    character(ESMF_MAXSTR)    :: name2,value2,purp2,name3,outVal
    character(ESMF_MAXSTR),dimension(2) :: attrList, valueList

!-------------------------------------------------------------------------------
!  The unit tests are divided into Sanity and Exhaustive. The Sanity tests are
!  always run. When the environment variable, EXHAUSTIVE, is set to ON then
!  the EXHAUSTIVE and sanity tests both run. If the EXHAUSTIVE variable is set
!  to OFF, then only the sanity unit tests.
!  Special strings (Non-exhaustive and exhaustive) have been
!  added to allow a script to count the number and types of unit tests.
!-------------------------------------------------------------------------------

    !-----------------------------------------------------------------------------
    call ESMF_TestStart(ESMF_SRCLINE, rc=rc)
    if (rc /= ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    !-----------------------------------------------------------------------------

#ifdef ESMF_TESTEXHAUSTIVE
    call ESMF_VMGetCurrent(vm, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)

    call ESMF_VMGet(vm, petCount=petCount, localPet=localPet, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)

    gridcomp1 = ESMF_GridCompCreate(name="gridcomp1", &
      petList=(/0,1/), rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    gridcomp2 = ESMF_GridCompCreate(name="gridcomp2", &
      petList=(/2,3/), rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    cplcomp = ESMF_CplCompCreate(name="cplcomp", &
      petList=(/0,1,2,3/), rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)

    c1exp = ESMF_StateCreate(name="Comp1 exportState", &
                             stateintent=ESMF_STATEINTENT_EXPORT, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    c2imp = ESMF_StateCreate(name="Comp2 importState", &
                             stateintent=ESMF_STATEINTENT_IMPORT, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)

    call ESMF_GridCompSetVM(gridcomp1, userm1_setvm, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_GridCompSetVM(gridcomp2, userm2_setvm, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_CplCompSetVM(cplcomp, usercpl_setvm, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)

    call ESMF_GridCompSetServices(gridcomp1, userRoutine=userm1_register, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_GridCompSetServices(gridcomp2, userRoutine=userm2_register, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_CplCompSetServices(cplcomp, userRoutine=usercpl_register, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)

    call ESMF_GridCompInitialize(gridcomp1, exportState=c1exp, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_GridCompInitialize(gridcomp2, importState=c2imp, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_CplCompInitialize(cplcomp, importState=c1exp, &
      exportState=c2imp, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)

    call ESMF_GridCompRun(gridcomp1, exportState=c1exp, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_CplCompRun(cplcomp, importState=c1exp, &
      exportState=c2imp, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_GridCompRun(gridcomp2, importState=c2imp, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)

    ! Now we can start doing some testing
    convESMF = 'ESMF'
    purpGen = 'General'
    name2 = 'StandardName'
    value2 = 'default_standard_name'
    name3 = 'LongName'

    purp2 = 'Extended'
    attrList(1) = 'Coordinates'
    attrList(2) = 'Mask'
    valueList(1) = "Latlon"
    valueList(2) = "Yes"

    call ESMF_StateGet(c1exp, "fieldbundle", fieldbundle, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_StateGet(c1exp, "field2", field2, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_FieldBundleGet(fieldbundle, grid=grid_from_fb, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_FieldBundleGet(fieldbundle, fieldname="field1", field=field1, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_FieldBundleGet(fieldbundle, fieldname="field12", field=field12, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_FieldGet(field1, grid=grid_from_field1, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_FieldGet(field12, grid=grid_from_field12, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_FieldGet(field2, grid=grid_from_field2, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)

    !EX_UTest_Multi_Proc_Only
        call ESMF_AttributeGetAttPack(field1, convention=convESMF, purpose=purpGen, &
        attpack=attpack, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_AttributeGet(field1, name2, value=outVal, attpack=attpack, rc=rc)
    write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value", &
                      "PET: ", localPet, "outVal: ", trim(outVal), &
                      "expected: ", trim(value2)
    write(name, *) "Getting an updated Attribute value from a Field test"
    call ESMF_Test((rc==ESMF_SUCCESS).and.(value2==outVal), &
                    name, failMsg, result, ESMF_SRCLINE)

    !EX_UTest_Multi_Proc_Only
        call ESMF_AttributeGetAttPack(field1, convention=convESMF, purpose=purp2, &
        attpack=attpack, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_AttributeGet(field1, attrList(1), value=outVal, &
      convention=convESMF, purpose=purp2, rc=rc)
    write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value", &
                      "PET: ", localPet, "outVal: ", trim(outVal), &
                      "expected: ", trim(valueList(1))
    write(name, *) "Getting an updated Attribute package Attribute value from a Field test"
    call ESMF_Test((rc==ESMF_SUCCESS).and.(valueList(1)==outVal), &
                    name, failMsg, result, ESMF_SRCLINE)

    !EX_UTest_Multi_Proc_Only
    call ESMF_AttributeGet(field1, attrList(2), value=outVal, &
      convention=convESMF, purpose=purp2, rc=rc)
    write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value", &
                      "PET: ", localPet, "outVal: ", trim(outVal), &
                      "expected: ", trim(valueList(2))
    write(name, *) "Getting an updated Attribute package Attribute value from a Field test"
    call ESMF_Test((rc==ESMF_SUCCESS).and.(valueList(2)==outVal), &
                    name, failMsg, result, ESMF_SRCLINE)

    !EX_UTest_Multi_Proc_Only
    call ESMF_AttributeGet(field1, name3, value=outVal, &
      convention=convESMF, purpose=purpGen, rc=rc)
    write(failMsg, *) "Did not return ESMF_FAILURE or wrong value"
    write(name, *) "Getting an updated deleted Attribute value from a Field test"
    call ESMF_Test((rc/=ESMF_SUCCESS), &
                    name, failMsg, result, ESMF_SRCLINE)


    !RegDecompX' =
    ! 96 - original
    ! 106 - grid_from_field1
    ! 126 - grid_from_field12
    ! 306 - grid_from_fb
    ! 206 - grid_from_field2

    !  all of the grids above come from 2 original grids, grid1 and grid2,
    !  which were created in the userm1_init function.  field1 and field12 were
    !  created from grid1 and field2 was created from grid2.  grid1 was also
    !  added to the fieldbundle.  An Attribute package containing two
    !  Attributes, (one is called RegDecompX) was added to both Grids on PET 0
    !  and 1 and then ESMF_StateReconcile() was called in the coupler, which
    !  runs on PETs 0,1,2,3.

    !  After the ESMF_StateReconcile() call there should be 4 separate grids
    !  on PET 2,3, one for each Field and FieldBundle, and only the two
    !  original grids on PET 0,1.  In the userm1_run routine we then modify the
    !  RegDecompX Attribute of each Grid to a different value (this happens on
    !  PET 0 and 1).  Then ESMF_AttributeUpdate()/ESMF_AttributeCopy() is
    !  called in the coupler running on PET 0,1,2,3.  The first Grid receives
    !  the values from the last call to it (fieldbundle), so on PET 2,3 we
    !  expect to see those values on all 3 Grids related to the original.  The
    !  second Grid should have the value that was set in userm1_run.

    expectedOut(1) = 96
    expectedOut(2) = 106
    expectedOut(3) = 126
    expectedOut(4) = 306
    expectedOut(5) = 206


    !EX_UTest_Multi_Proc_Only
    call ESMF_AttributeGetAttPack(grid_from_field1, convESMF, purpGen, &
        attpack=attpack, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_AttributeGet(grid_from_field1, 'RegDecompX', attpack=attpack, &
        value=outInt, rc=rc)
    write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value", &
                      "PET: ", localPet, "outVal: ", outInt, &
                      "expected: ", expectedOut(3)
    write(name, *) "Getting a Grid Attribute from field1 test"
    call ESMF_Test((rc==ESMF_SUCCESS).and.(expectedOut(4)==outInt), &
                    name, failMsg, result, ESMF_SRCLINE)

    !EX_UTest_Multi_Proc_Only
    call ESMF_AttributeGetAttPack(grid_from_field12, convESMF, purpGen, &
        attpack=attpack, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_AttributeGet(grid_from_field12, 'RegDecompX', attpack=attpack, &
        value=outInt, rc=rc)
    write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value", &
                      "PET: ", localPet, "outVal: ", outInt, &
                      "expected: ", expectedOut(3)
    write(name, *) "Getting a Grid Attribute from field12 test"
    call ESMF_Test((rc==ESMF_SUCCESS).and.(expectedOut(4)==outInt), &
                    name, failMsg, result, ESMF_SRCLINE)

    !EX_UTest_Multi_Proc_Only
    call ESMF_AttributeGetAttPack(grid_from_fb, convESMF, purpGen, &
        attpack=attpack, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_AttributeGet(grid_from_fb, 'RegDecompX', attpack=attpack, &
        value=outInt, rc=rc)
    write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value", &
                      "PET: ", localPet, "outVal: ", outInt, &
                      "expected: ", expectedOut(4)
    write(name, *) "Getting a Grid Attribute from fieldbundle test"
    call ESMF_Test((rc==ESMF_SUCCESS).and.(expectedOut(4)==outInt), &
                    name, failMsg, result, ESMF_SRCLINE)

    !EX_UTest_Multi_Proc_Only
    call ESMF_AttributeGetAttPack(grid_from_field2, convESMF, purpGen, &
        attpack=attpack, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_AttributeGet(grid_from_field2, 'RegDecompX', attpack=attpack, &
        value=outInt, rc=rc)
    write(failMsg, *) "Did not return ESMF_SUCCESS or wrong value", &
                      "PET: ", localPet, "outVal: ", outInt, &
                      "expected: ", expectedOut(5)
    write(name, *) "Getting a Grid Attribute from field2 test"
    call ESMF_Test((rc==ESMF_SUCCESS).and.(expectedOut(5)==outInt), &
                    name, failMsg, result, ESMF_SRCLINE)

    ! Now back to finalizing the model run
    call ESMF_GridCompFinalize(gridcomp1, exportState=c1exp, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_GridCompFinalize(gridcomp2, importState=c2imp, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_CplCompFinalize(cplcomp, importState=c1exp, &
      exportState=c2imp, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)

    call ESMF_GridCompDestroy(gridcomp1, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_GridCompDestroy(gridcomp2, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_CplCompDestroy(cplcomp, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)

    call ESMF_StateDestroy(c1exp, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
    call ESMF_StateDestroy(c2imp, rc=rc)
    if (rc .ne. ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)

#endif
    !-----------------------------------------------------------------------------
    call ESMF_TestEnd(ESMF_SRCLINE)
    !-----------------------------------------------------------------------------

end program ESMF_AttributeUpdateClosedLoopTreesUTest
