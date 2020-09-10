--*****************************************************************************
--*
--* PROJECT:            BingAda
--*
--* FILE:               q_bingo.ads
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************

package Q_BINGO with Pure is

  C_LAST_NUMBER : constant := 90;

  subtype T_NUMBER is POSITIVE range 1 .. C_LAST_NUMBER;

end Q_BINGO;
