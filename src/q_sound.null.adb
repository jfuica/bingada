--*****************************************************************************
--*
--* PROJECT:            BINGADA
--*
--* FILE:               q_sound.null.adb
--*
--* AUTHOR:             Manuel <mgrojo at github>
--*
--*****************************************************************************

package body Q_Sound is

  --==================================================================

  -- Implementation for systems where sound is not currently supported.

  procedure P_Initialize is null;

  procedure P_Play_Number (V_Number : Positive) is null;

  procedure P_Clean_Up is null;

end Q_Sound;
