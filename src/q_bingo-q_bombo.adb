--*****************************************************************************
--*
--* PROJECT:            BINGADA
--*
--* FILE:               q_bingo.adb
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************

with Q_GEN_SHUFFLE;

-- Sound library
--
with CANBERRA;

with Ada.Directories;
with Ada.Strings.Fixed;

with GTKADA.Intl;

package body Q_BINGO.Q_BOMBO is

  --==================================================================

  V_INDEX : T_NUMBER;

  --==================================================================

  package Q_SHUFFLE is new Q_GEN_SHUFFLE
     (ELEMENT_TYPE => T_NUMBER,
      C_MAX_NUMBER => T_NUMBER'LAST);

  V_BINGO_ARRAY : Q_SHUFFLE.ARRAY_TYPE;

  V_CONTEXT : CANBERRA.CONTEXT := CANBERRA.CREATE
     (NAME => "BingAda",
      ID   => "bingada.lovelace",
      ICON => "applications-games");

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

  procedure P_Play_Number (V_NUMBER : Positive) is

    C_Number_Image : constant String := Ada.Strings.Fixed.Trim (V_Number'Image, Ada.Strings.Left);
    C_Path : constant String := "media/";
    C_Extension : constant String := ".ogg";
    C_Lang_Code_Last : constant := 2;
    C_locale : constant String := GTKADA.INTL.Getlocale;
    C_Default_Lang : constant String := "en";

    V_Lang : String (1 .. C_Lang_Code_Last) := C_Default_Lang;
    V_Sound : Canberra.Sound;
  begin


    if C_locale'Length >= C_Lang_Code_Last then

      V_Lang := C_Locale (C_Locale'First .. C_Locale'First + C_Lang_Code_Last - 1);
    end if;

    if not Ada.Directories.Exists (C_Path & V_Lang & '/' & C_Number_Image & C_Extension) then
      V_Lang := C_Default_Lang;
    end if;

    V_Context.Play_FILE (C_Path & V_Lang & '/' & C_Number_Image & C_Extension, V_SOUND, CANBERRA.Music, "Number");

  end P_Play_Number;

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

    P_PLAY_NUMBER (V_Bingo_Array(V_Current_Index));

  end P_SPIN;

  --==================================================================

  function F_GET_NUMBER (V_INDEX : T_NUMBER) return T_NUMBER is

  begin

    return V_BINGO_ARRAY (V_INDEX);

  end F_GET_NUMBER;

  --==================================================================

  function F_GET_CURRENT_INDEX return T_NUMBER is

  begin

    return V_INDEX;

  end F_GET_CURRENT_INDEX;

  --==================================================================

end Q_BINGO.Q_BOMBO;
