--*****************************************************************************
--*
--* PROJECT:            BingAda
--*
--* FILE:               q_sound.asfml.adb
--*
--* AUTHOR:             Manuel <mgrojo at github>
--*
--*****************************************************************************

-- External sound library
--
with Sf.Audio.Music;

with Ada.Directories;
with Ada.Strings.Fixed;

with Gtkada.Intl;

with Q_Bingo;

package body Q_Sound is

  use type Sf.Audio.sfMusic_Ptr;

  type T_Sound_Array is array (Q_Bingo.T_Number) of Sf.Audio.sfMusic_Ptr;

  V_Sounds : T_Sound_Array;

  --==================================================================

  function F_Filename (V_Number : Positive) return String is

    C_Number_Image   : constant String := Ada.Strings.Fixed.Trim
      (V_Number'Image, Ada.Strings.Left);
    C_Path           : constant String := "media/";
    C_Extension      : constant String := ".ogg";
    C_Lang_Code_Last : constant        := 2;
    C_Locale         : constant String := Gtkada.Intl.Getlocale;
    C_Default_Lang   : constant String := "en";

    V_Lang : String (1 .. C_Lang_Code_Last) := C_Default_Lang;
  begin

    if C_Locale'Length >= C_Lang_Code_Last then

      V_Lang := C_Locale (C_Locale'First ..
                            C_Locale'First + C_Lang_Code_Last - 1);
    end if;

    if not Ada.Directories.Exists
      (C_Path & V_Lang & '/' & C_Number_Image & C_Extension) then

      V_Lang := C_Default_Lang;
    end if;

    return C_Path & V_Lang & '/' & C_Number_Image & C_Extension;

  end F_Filename;

  --==================================================================

  procedure P_Initialize is
  begin

    for V_Number in V_Sounds'Range loop

      V_Sounds (V_Number) := Sf.Audio.Music.createFromFile
        (F_Filename (V_Number));

    end loop;

  end P_Initialize;

  --==================================================================

  procedure P_Play_Number (V_Number : Positive) is
  begin

    -- Stop and rewind (if already played)
    Sf.Audio.Music.stop (V_Sounds (V_number));

    Sf.Audio.Music.play (V_Sounds (V_number));

  end P_Play_Number;

  --==================================================================

  procedure P_Clean_Up is
  begin

    for V_Sound of V_Sounds loop

      if V_Sound /= null then
        Sf.Audio.Music.destroy (V_Sound);
      end if;

    end loop;

  end P_Clean_Up;

end Q_Sound;
