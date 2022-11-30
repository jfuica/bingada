--*****************************************************************************
--*
--* PROJECT:            BINGADA
--*
--* FILE:               q_sound.ads
--*
--* AUTHOR:             Manuel <mgrojo at github>
--*
--*****************************************************************************

package Q_Sound is

  procedure P_Initialize;

  -- Play the Number according to the current language.
  --
  procedure P_Play_Number (V_Number : Positive);

  procedure P_Clean_Up;

end Q_Sound;
