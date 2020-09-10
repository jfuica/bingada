--*****************************************************************************
--*
--* PROJECT:            BINGADA
--*
--* FILE:               q_sound.adb
--*
--* AUTHOR:             Manuel <mgrojo at github>
--*
--*****************************************************************************

package body Q_Sound is

  --==================================================================

  -- For systems where sound is not currently supported.
  --
  procedure P_Play_Number (V_Number : Positive) is null;

end Q_Sound;
