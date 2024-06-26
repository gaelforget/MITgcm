#include "GRDCHK_OPTIONS.h"
#ifdef ALLOW_CTRL
# include "CTRL_OPTIONS.h"
#endif

      SUBROUTINE GRDCHK_CHECK( myThid )

C     ==================================================================
C     SUBROUTINE grdchk_check
C     ==================================================================
C
C     o check some gradient check parameter settings for consistency
C
C     ==================================================================
C     SUBROUTINE grdchk_check
C     ==================================================================

      IMPLICIT NONE

C     == global variables ==

#include "EEPARAMS.h"
#include "SIZE.h"
#include "CTRL_SIZE.h"
#include "CTRL.h"
#ifdef ALLOW_OBCS_CONTROL
C     CTRL_OBCS.h must be included before GRDCHK.h
# include "CTRL_OBCS.h"
#endif
#include "GRDCHK.h"

C     == routine arguments ==
      INTEGER myThid

#ifdef ALLOW_GRDCHK
C     == local variables ==
C     msgBuf      - Informational/error message buffer
      CHARACTER*(MAX_LEN_MBUF) msgBuf

C     == end of interface ==

      WRITE(msgBuf,'(A)') 'GRDCHK_CHECK: grdchk package'
      CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     &                    SQUEEZE_RIGHT, myThid )

C--   Set grdchkvarindex (if not already set from reading data.grdchk)
      _BEGIN_MASTER( myThid )
      CALL GRDCHK_CTRL_FNAME( grdchkvarname, grdchkvarindex, myThid )
      _END_MASTER( myThid )
      _BARRIER

C--   Summarize the gradient check setup.
      CALL GRDCHK_SUMMARY( myThid )

      IF ( ncvarindex(grdchkvarindex) .LT. 0 ) THEN
         WRITE(msgBuf,'(A,I4)')
     &        'Control variable not enabled for grdchkvarindex = ',
     &        grdchkvarindex
         CALL PRINT_ERROR( msgBuf, myThid )
         STOP 'ABNORMAL END: S/R GRDCHK_CHECK'
      ENDIF

#endif /* ALLOW_GRDCHK */

      RETURN
      END
