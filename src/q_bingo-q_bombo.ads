--*****************************************************************************
--*
--* PROJECT:            BINGADA
--*
--* FILE:               q_bingo-q_bombo.ads
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************

package Q_Bingo.Q_Bombo is

  procedure P_Init;

  procedure P_Spin (V_Number        : out Positive;
                    V_Current_Index : out T_Number;
                    V_Last_Number   : out Boolean);

  function F_Get_Number (V_Index : T_Number) return T_Number;

  function F_Get_Current_Index return T_Number;

end Q_Bingo.Q_Bombo;
