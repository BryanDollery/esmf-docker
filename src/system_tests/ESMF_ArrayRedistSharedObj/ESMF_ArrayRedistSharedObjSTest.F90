! $Id$
!
!-------------------------------------------------------------------------
!ESMF_SHAREDOBJ_SYSTEM_TEST    String used by test script to count system tests.
!=========================================================================

!-------------------------------------------------------------------------
!
! !DESCRIPTION:
! System test ArrayRedistSharedObj.
!
!   Two Gridded Components and one Coupler Component, one-way coupling.
!
!   The first Gridded Component and the Coupler Component are compiled into 
!   shared objects. These shared objects are then loaded dynamically by the 
!   driver application during runtime. The second Gridded Component is
!   statically linked into the executable.
!
!   The first Gridded Component runs on 4 PETs and defines a 2D source Array
!   of 100x150. The second Gridded Component defines a destination Array also
!   of 100x150, but runs on only 2 PETs. Both Gridded Components use DELayouts
!   with 1 DE per PET. The decomposition of the source Array is defined as
!   (petCount x 1), i.e. (4 x 1) while the destination Array is decomposed as
!   (1 x petCount), i.e. (1 x 2).
!
!   The first Gridded Component initializes the source Array to a geometric
!   function:
!
!     10.0 + 5.0*sin((I/Imax)*pi) + 2.0*sin((J/Jmax)*pi)
!
!   The Coupler Component runs on all 6 PETs and reconciles import and export
!   States, which contain the source and destination Arrays, respectively. The
!   Coupler Component then calls ArrayRedist() to redistribute the source
!   Array data onto the destination Array.
!
!   Finally the second Gridded Component compares the data stored in the
!   destination Array to the analytic solution of the above function as a
!   measure of the accuracy of the ArrayRedist() method.
!
!-------------------------------------------------------------------------
!\begin{verbatim}

program ESMF_ArrayRedistSharedObjSTest
#define ESMF_METHOD "program ESMF_ArrayRedistSharedObjSTest"

#include "ESMF.h"

  ! ESMF Framework module
  use ESMF
  use ESMF_TestMod

  use user_model2, only : userm2_setvm, userm2_register

  implicit none

  ! Local variables
  integer :: localPet, petCount, userrc, localrc, rc=ESMF_SUCCESS
  character(len=ESMF_MAXSTR) :: cname1, cname2, cplname
  type(ESMF_VM):: vm
  type(ESMF_State) :: c1exp, c2imp
  type(ESMF_GridComp) :: comp1, comp2
  type(ESMF_CplComp) :: cpl

  ! cumulative result: count failures; no failures equals "all pass"
  integer :: result = 0

  ! individual test name
  character(ESMF_MAXSTR) :: testname

  ! individual test failure message, and final status msg
  character(ESMF_MAXSTR) :: failMsg, finalMsg

!-------------------------------------------------------------------------
!-------------------------------------------------------------------------

  write(failMsg, *) "System Test failure"
  write(testname, *) "System Test ESMF_ArrayRedistSharedObjSTest"

!-------------------------------------------------------------------------
!-------------------------------------------------------------------------

  print *, "--------------------------------------- "
  print *, "Start of ", trim(testname)
  print *, "--------------------------------------- "

!-------------------------------------------------------------------------
!-------------------------------------------------------------------------
! Create section
!-------------------------------------------------------------------------
!-------------------------------------------------------------------------
!
  ! Initialize framework and get back default global VM
  call ESMF_Initialize(vm=vm, &
    defaultlogfilename="ArrayRedistSharedObjSTest.Log", &
    logkindflag=ESMF_LOGKIND_MULTI, rc=localrc)
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  ! Get number of PETs we are running with
  call ESMF_VMGet(vm, petCount=petCount, localPet=localPet, rc=localrc)
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

   ! Check for correct number of PETs
  if ( petCount < 6 ) then
     call ESMF_LogSetError(ESMF_RC_ARG_BAD,&
         msg="This system test does not run on fewer than 6 PETs.",&
         ESMF_CONTEXT, rcToReturn=rc)
     call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
   endif

  ! Create the 2 model components and coupler
  cname1 = "user model 1"
  ! use petList to define comp1 on PET 0,1,2,3
  comp1 = ESMF_GridCompCreate(name=cname1, petList=(/0,1,2,3/), rc=localrc)
  print *, "Created component ", trim(cname1), "rc =", localrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  cname2 = "user model 2"
  ! use petList to define comp2 on PET 4,5
  comp2 = ESMF_GridCompCreate(name=cname2, petList=(/4,5/), rc=localrc)
  print *, "Created component ", trim(cname2), "rc =", localrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  cplname = "user one-way coupler"
  ! no petList means that coupler component runs on all PETs
  cpl = ESMF_CplCompCreate(name=cplname, rc=localrc)
  print *, "Created component ", trim(cplname), ", rc =", localrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  print *, "Comp Creates finished"

!-------------------------------------------------------------------------
!-------------------------------------------------------------------------
! Register section
!-------------------------------------------------------------------------
!-------------------------------------------------------------------------

  call ESMF_GridCompSetVM(comp1, userRoutine="userm1_setvm_", &
    sharedObj="./user_model1.so", userRC=userrc, rc=localrc)
  print *, "Comp SetVM finished, rc= ", localrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  if (ESMF_LogFoundError(userrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  call ESMF_GridCompSetServices(comp1, userRoutine="userm1_reg_", &
    sharedObj="./user_model1.so", userRC=userrc, rc=localrc)
  print *, "Comp SetServices finished, rc= ", localrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  if (ESMF_LogFoundError(userrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  call ESMF_GridCompSetVM(comp2, userRoutine=userm2_setvm, &
     userRC=userrc, rc=localrc)
  print *, "Comp2 SetVM finished, rc= ", localrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  if (ESMF_LogFoundError(userrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  call ESMF_GridCompSetServices(comp2, userRoutine="userm2_reg_", &
     userRC=userrc, rc=localrc)
  print *, "Comp2 SetServices finished, rc= ", localrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  if (ESMF_LogFoundError(userrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  call ESMF_CplCompSetVM(cpl, userRoutine="usercpl_setvm_", &
    sharedObj="./user_coupler.so", userRC=userrc, rc=localrc)
  print *, "Comp SetVM finished, rc= ", localrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  if (ESMF_LogFoundError(userrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  call ESMF_CplCompSetServices(cpl, userRoutine="usercpl_reg_", &
    sharedObj="./user_coupler.so", userRC=userrc, rc=localrc)
  print *, "Comp SetServices finished, rc= ", localrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  if (ESMF_LogFoundError(userrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

!-------------------------------------------------------------------------
!-------------------------------------------------------------------------
! Init section
!-------------------------------------------------------------------------
!-------------------------------------------------------------------------

  c1exp = ESMF_StateCreate(name="comp1 export",  &
                           stateintent=ESMF_STATEINTENT_EXPORT, rc=localrc)
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  call ESMF_GridCompInitialize(comp1, exportState=c1exp, &
    userRc=userrc, rc=localrc)
  print *, "Comp 1 Initialize finished, rc =", localrc, userrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  if (ESMF_LogFoundError(userrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  c2imp = ESMF_StateCreate(name="comp2 import",  &
                           stateintent=ESMF_STATEINTENT_IMPORT, rc=localrc)
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  call ESMF_GridCompInitialize(comp2, importState=c2imp, &
    userRc=userrc, rc=localrc)
  print *, "Comp 2 Initialize finished, rc =", localrc, userrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  if (ESMF_LogFoundError(userrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  ! note that the coupler's import is comp1's export state
  ! and coupler's export is comp2's import state
  call ESMF_CplCompInitialize(cpl, importState=c1exp, &
    exportState=c2imp, userRc=userrc, rc=localrc)
  print *, "Coupler Initialize finished, rc =", localrc, userrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  if (ESMF_LogFoundError(userrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

!-------------------------------------------------------------------------
!-------------------------------------------------------------------------
! Run section
!-------------------------------------------------------------------------
!-------------------------------------------------------------------------

  call ESMF_GridCompRun(comp1, exportState=c1exp, &
    userRc=userrc, rc=localrc)
  print *, "Comp 1 Run returned, rc =", localrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  if (ESMF_LogFoundError(userrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  call ESMF_CplCompRun(cpl, importState=c1exp, &
    exportState=c2imp, userRc=userrc, rc=localrc)
  print *, "Coupler Run returned, rc =", localrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  if (ESMF_LogFoundError(userrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  call ESMF_GridCompRun(comp2, importState=c2imp, &
    userRc=userrc, rc=localrc)
  print *, "Comp 2 Run returned, rc =", localrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  if (ESMF_LogFoundError(userrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

!-------------------------------------------------------------------------
!-------------------------------------------------------------------------
! Finalize section
!-------------------------------------------------------------------------
!-------------------------------------------------------------------------

  call ESMF_CplCompFinalize(cpl, importState=c1exp, &
    exportState=c2imp, userRc=userrc, rc=localrc)
  print *, "Coupler Finalize finished, rc =", localrc, userrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  if (ESMF_LogFoundError(userrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  call ESMF_GridCompFinalize(comp1, exportState=c1exp, &
    userRc=userrc, rc=localrc)
  print *, "Comp 1 Finalize finished, rc =", localrc, userrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  if (ESMF_LogFoundError(userrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  call ESMF_GridCompFinalize(comp2, importState=c2imp, &
    userRc=userrc, rc=localrc)
  print *, "Comp 2 Finalize finished, rc =", localrc, userrc
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  if (ESMF_LogFoundError(userrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

!-------------------------------------------------------------------------
!-------------------------------------------------------------------------
! Destroy section
!-------------------------------------------------------------------------
!-------------------------------------------------------------------------

  call ESMF_GridCompDestroy(comp1, rc=localrc)
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  call ESMF_GridCompDestroy(comp2, rc=localrc)
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  call ESMF_CplCompDestroy(cpl, rc=localrc)
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  call ESMF_StateDestroy(c1exp, rc=localrc)
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)
  call ESMF_StateDestroy(c2imp, rc=localrc)
  if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
    ESMF_CONTEXT, rcToReturn=rc)) &
    call ESMF_Finalize(rc=rc, endflag=ESMF_END_ABORT)

  print *, "All Destroy routines done"

!-------------------------------------------------------------------------
!-------------------------------------------------------------------------

10 continue

  ! Normal ESMF Test output
  print *, testname, " complete."

  if (rc .eq. ESMF_SUCCESS) then
    ! Separate message to console, for quick confirmation of success/failure
    write(finalMsg, *) "SUCCESS: ",trim(testname)," finished correctly."
    write(0, *) ""
    write(0, *) trim(testname)
    write(0, *) trim(finalMsg)
    write(0, *) ""
  endif

  print *, "------------------------------------------------------------"
  print *, "------------------------------------------------------------"
  print *, "Test finished, localPet = ", localPet
  print *, "------------------------------------------------------------"
  print *, "------------------------------------------------------------"

  ! IMPORTANT: ESMF_STest() prints the PASS string and the # of processors 
  ! in the log file that the scripts grep for.
  call ESMF_STest((rc.eq.ESMF_SUCCESS), testname, failMsg, result, ESMF_SRCLINE)

  call ESMF_Finalize()

end program ESMF_ArrayRedistSharedObjSTest

!\end{verbatim}
