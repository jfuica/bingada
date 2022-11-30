--*****************************************************************************
--*
--* PROJECT:            BingAda
--*
--* FILE:               q_sound.sfml.adb
--*
--* AUTHOR:             Manuel <mgrojo at github>
--*
--*****************************************************************************

-- External sound library
--
with Snd4ada_Hpp;

with Ada.Directories;
with Ada.Strings.Fixed;

with Interfaces.C.Strings;

with Gtkada.Intl;

with Q_Bingo;

package body Q_Sound is

  use type Interfaces.C.int;

  type T_Sound_Array is array (Q_Bingo.T_Number) of Interfaces.C.Int;

  V_Sounds : T_Sound_Array := (others => -1);

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

    snd4ada_hpp.initSnds;

    for V_Number in V_Sounds'Range loop

      V_Sounds (V_Number) := snd4ada_hpp.initSnd
        (Pc  => Interfaces.C.Strings.New_String (F_Filename (V_Number)),
         Vol => 99);
    end loop;

  end P_Initialize;

  --==================================================================

  procedure P_Play_Number (V_Number : Positive) is
  begin

    snd4ada_hpp.playSnd (V_Sounds (V_number));

  end P_Play_Number;

  --==================================================================

  procedure P_Clean_Up is
  begin
     snd4ada_hpp.termSnds;
  end P_Clean_Up;

end Q_Sound;
