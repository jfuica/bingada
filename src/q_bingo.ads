--*****************************************************************************
--*
--* PROJECT:            BingAda
--*
--* FILE:               q_bingo.ads
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************

package Q_Bingo with Pure is

  C_Last_Number : constant := 90;

  subtype T_Number is Positive range 1 .. C_Last_Number;

end Q_Bingo;
