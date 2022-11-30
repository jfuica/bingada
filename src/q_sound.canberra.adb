--*****************************************************************************
--*
--* PROJECT:            BINGADA
--*
--* FILE:               q_sound.adb
--*
--* AUTHOR:             Manuel <mgrojo at github>
--*
--*****************************************************************************

-- External sound library
--
with Canberra;

with Ada.Directories;
with Ada.Strings.Fixed;

with Gtkada.Intl;

package body Q_Sound is

  V_Context : Canberra.Context := Canberra.Create
    (Name => "BingAda",
     Id   => "bingada.lovelace",
     Icon => "applications-games");

  --==================================================================
  procedure P_Initialize is null;
  --==================================================================

  procedure P_Play_Number (V_Number : Positive) is

    C_Number_Image   : constant String := Ada.Strings.Fixed.Trim
      (V_Number'Image, Ada.Strings.Left);
    C_Path           : constant String := "media/";
    C_Extension      : constant String := ".ogg";
    C_Lang_Code_Last : constant        := 2;
    C_Locale         : constant String := Gtkada.Intl.Getlocale;
    C_Default_Lang   : constant String := "en";

    V_Lang : String (1 .. C_Lang_Code_Last) := C_Default_Lang;
    V_Sound : Canberra.Sound;
  begin

    if C_Locale'Length >= C_Lang_Code_Last then

      V_Lang := C_Locale (C_Locale'First ..
                            C_Locale'First + C_Lang_Code_Last - 1);
    end if;

    if not Ada.Directories.Exists
      (C_Path & V_Lang & '/' & C_Number_Image & C_Extension) then

      V_Lang := C_Default_Lang;
    end if;

    V_Context.Play_File
      (File_Name  => C_Path & V_Lang & '/' & C_Number_Image & C_Extension,
       File_Sound => V_Sound,
       Kind       => Canberra.Music,
       Name       => "Number");

  end P_Play_Number;

  --==================================================================

  -- Nothing to do in the canberra version
  --
  procedure P_Clean_Up is null;

end Q_Sound;
