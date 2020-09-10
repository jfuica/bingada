--*****************************************************************************
--*
--* PROJECT:            BINGADA
--*
--* FILE:               q_bingo-q_bombo.adb
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************

with Q_Gen_Shuffle;

with Q_Sound;

package body Q_Bingo.Q_Bombo is

  --==================================================================

  V_Index : T_Number;

  --==================================================================

  package Q_Shuffle is new Q_Gen_Shuffle
     (Element_Type => T_Number,
      C_Max_Number => T_Number'Last);

  V_Bingo_Array : Q_Shuffle.Array_Type;

  --==================================================================

  procedure P_Init is

  begin

    for I in 1 .. T_Number'Last loop

      V_Bingo_Array (I) := I;

    end loop;

    Q_Shuffle.P_Shuffle (List => V_Bingo_Array);

    V_Index := 1;

  end P_Init;

  --==================================================================

  procedure P_Spin (V_Number        : out Positive;
                    V_Current_Index : out T_Number;
                    V_Last_Number   : out Boolean) is
  begin

    if V_Index = T_Number'Last then

      V_Number := V_Bingo_Array (T_Number'Last);

      V_Last_Number := True;

      V_Current_Index := V_Index;

    else

      V_Number := V_Bingo_Array (V_Index);

      V_Current_Index := V_Index;

      V_Index := V_Index + 1;

      V_Last_Number := False;

    end if;

    Q_Sound.P_Play_Number (V_Bingo_Array (V_Current_Index));

  end P_Spin;

  --==================================================================

  function F_Get_Number (V_Index : T_Number) return T_Number is
     (V_Bingo_Array (V_Index));

  --==================================================================

  function F_Get_Current_Index return T_Number is (V_Index);

  --==================================================================

end Q_Bingo.Q_Bombo;
