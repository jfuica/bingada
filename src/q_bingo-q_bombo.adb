--*****************************************************************************
--*
--* PROJECT:            BINGADA
--*
--* FILE:               q_bingo-q_bombo.adb
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************

with Q_GEN_SHUFFLE;

with Q_Sound;

package body Q_BINGO.Q_BOMBO is

  --==================================================================

  V_INDEX : T_NUMBER;

  --==================================================================

  package Q_SHUFFLE is new Q_GEN_SHUFFLE
     (ELEMENT_TYPE => T_NUMBER,
      C_MAX_NUMBER => T_NUMBER'LAST);

  V_BINGO_ARRAY : Q_SHUFFLE.ARRAY_TYPE;

  --==================================================================

  procedure P_INIT is

  begin

    for I in 1 .. T_NUMBER'LAST loop

      V_BINGO_ARRAY (I) := I;

    end loop;

    Q_SHUFFLE.P_SHUFFLE (LIST => V_BINGO_ARRAY);

    V_INDEX := 1;

  end P_INIT;

  --==================================================================

  procedure P_SPIN (V_NUMBER        : out POSITIVE;
                    V_CURRENT_INDEX : out T_NUMBER;
                    V_LAST_NUMBER   : out BOOLEAN) is
  begin

    if V_INDEX = T_NUMBER'LAST then

      V_NUMBER := V_BINGO_ARRAY (T_NUMBER'LAST);

      V_LAST_NUMBER := TRUE;

      V_CURRENT_INDEX := V_INDEX;

    else

      V_NUMBER := V_BINGO_ARRAY (V_INDEX);

      V_CURRENT_INDEX := V_INDEX;

      V_INDEX := V_INDEX + 1;

      V_LAST_NUMBER := FALSE;

    end if;

    Q_Sound.P_PLAY_NUMBER (V_Bingo_Array (V_Current_Index));

  end P_SPIN;

  --==================================================================

  function F_GET_NUMBER (V_INDEX : T_NUMBER) return T_NUMBER is
     (V_BINGO_ARRAY (V_INDEX));

  --==================================================================

  function F_GET_CURRENT_INDEX return T_NUMBER is (V_Index);

  --==================================================================

end Q_BINGO.Q_BOMBO;
