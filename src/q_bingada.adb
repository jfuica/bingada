--*****************************************************************************
--*
--* PROJECT:            BINGADA
--*
--* FILE:               q_bingada.adb
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************


with Text_Io;

with Ada.Strings.Fixed;


with Glib.Main;
with Glib.Error;
with Glib.Properties;

with Gtk.Box;
with Gtk.Main;
with Gtk.Window;
with Gtk.Enums;
with Gtk.Widget;
with Gtk.Image;
with Gtk.Button;
with Gtk.Menu;
with Gtk.Menu_Bar;
with Gtk.Menu_Item;
with Gtk.Handlers;
with Gtk.Settings;
with Gtk.Style_Provider;

with Gdk.Event;
with Gdk.Types.Keysyms;
with Gdk.Pixbuf;

with Gtkada.Style;
with Gtkada.Intl; use Gtkada.Intl;

with Q_Bingo.Q_Bombo;
with Q_Bingo_Help;
with Q_Csv.Q_Read_File;
with Q_Bingo.Q_Gtk.Q_Intl;
with Q_Sound;

package body Q_Bingada is

  use type Glib.Main.G_Source_Id;
  use type Glib.Guint;

  --==================================================================

  C_Null_Number_Image : constant String := " ";

  C_Bombo_File : constant String := "bombo.png";

  C_Drum_Spin_File : constant String := "drum_spin.png";

  V_Drum_Is_Spun : Boolean := True;

  V_Dark_Style : Boolean := False;

  V_Is_In_Fullscreen : Boolean := False;

  V_Bombo_Button : Gtk.Button.Gtk_Button;

  --==================================================================

  procedure P_Load_Css (V_Filename : String) is

  begin

    -- Use this if you want to use Aero themes from Gnome
    -- This is not recommended but can help if animation is requested.
    -- In this case the .themes directory must exists in the home directory.
    --      Glib.Properties.Set_Property
    --             (Object    => Gtk.Settings.Get_Default,
    --              Name      => Gtk.Settings.Gtk_Theme_Name,
    --              Value     => "Aero");

    Glib.Properties.Set_Property
       (Object => Gtk.Settings.Get_Default,
        Name   => Gtk.Settings.Gtk_Cursor_Blink_Property,
        Value  => True);

    Gtkada.Style.Load_Css_File
       (Path     => V_Filename,
        Error    => Text_Io.Put_Line'Access,
        Priority => Gtk.Style_Provider.Priority_Application);

  end P_Load_Css;

  --=========================================================================

  function F_Swap_Bombo_Image return String is

  begin

    V_Drum_Is_Spun := not V_Drum_Is_Spun;

    return (if V_Drum_Is_Spun then C_Bombo_File else C_Drum_Spin_File);

  end F_Swap_Bombo_Image;

  --==================================================================

  procedure P_Main_Quit (Self : access Gtk.Widget.Gtk_Widget_Record'Class) is

    pragma Unreferenced (Self);

  begin

    Q_Sound.P_Clean_Up;

    Text_Io.Put_Line (-"exit_message");

    Gtk.Main.Main_Quit;

  end P_Main_Quit;

  --==================================================================

  V_Current_Number : Gtk.Button.Gtk_Button;

  V_Previous_Number_1 : Gtk.Button.Gtk_Button;

  V_Previous_Number_2 : Gtk.Button.Gtk_Button;

  V_Previous_Number_3 : Gtk.Button.Gtk_Button;

  C_Max_Buttons : constant := Q_Bingo.C_Last_Number;

  type T_Buttons_Array is array (1 .. C_Max_Buttons) of Gtk.Button.Gtk_Button;

  V_Button_Array : T_Buttons_Array;

  --==================================================================

  function F_Get_Number (V_Index : Positive) return String is

    V_Image : String := "  ";
  begin

    Ada.Strings.Fixed.Move
      (Source => V_Index'Image,
       Target => V_Image,
       Drop   => Ada.Strings.Left);

    return V_Image;

  end F_Get_Number;

  --==================================================================

  procedure P_Set_Current_And_Previous_Numbers
     (V_Current_Index : Q_Bingo.T_Number) is

    C_Number : constant Positive :=
       Q_Bingo.Q_Bombo.F_Get_Number (V_Current_Index);

  begin

    V_Button_Array (C_Number).Set_Name ("myButton_blue");

    V_Current_Number.Set_Name ("myButton_blue");

    V_Current_Number.Set_Label (F_Get_Number (C_Number));

    if V_Current_Index > 1 then

      V_Previous_Number_1.Set_Label
         (F_Get_Number
             (Q_Bingo.Q_Bombo.F_Get_Number (V_Current_Index - 1)));

      V_Previous_Number_1.Set_Name ("myButton_previous_1");

    end if;

    if V_Current_Index > 2 then

      V_Previous_Number_2.Set_Label
         (F_Get_Number
             (Q_Bingo.Q_Bombo.F_Get_Number (V_Current_Index - 2)));

      V_Previous_Number_2.Set_Name ("myButton_previous_2");

    end if;

    if V_Current_Index > 3 then

      V_Previous_Number_3.Set_Label
         (F_Get_Number
             (Q_Bingo.Q_Bombo.F_Get_Number (V_Current_Index - 3)));

      V_Previous_Number_3.Set_Name ("myButton_previous_3");


    end if;

  end P_Set_Current_And_Previous_Numbers;

  --==================================================================

  procedure P_Get_Number is

    V_Last_Number : Boolean;

    V_Current_Index : Q_Bingo.T_Number;

    V_Number : Positive;

  begin

    Q_Bingo.Q_Bombo.P_Spin (V_Number        => V_Number,
                            V_Current_Index => V_Current_Index,
                            V_Last_Number   => V_Last_Number);

    P_Set_Current_And_Previous_Numbers (V_Current_Index => V_Current_Index);

  end P_Get_Number;

  --==================================================================

  procedure P_Button_Clicked
     (Self : access Gtk.Button.Gtk_Button_Record'Class) is

    pragma Unreferenced (Self);

  begin

    P_Get_Number;

  end P_Button_Clicked;

  --==================================================================

  procedure P_Button_Pressed
     (Self : access Gtk.Button.Gtk_Button_Record'Class) is

    V_Drum_Spin_Image : Gtk.Image.Gtk_Image;

  begin

    V_Drum_Spin_Image := Gtk.Image.Gtk_Image_New_From_File (F_Swap_Bombo_Image);

    Self.Set_Image (V_Drum_Spin_Image);

  end P_Button_Pressed;

  --==================================================================

  procedure P_Button_Released
     (Self : access Gtk.Button.Gtk_Button_Record'Class) is

    V_Bombo_Image : Gtk.Image.Gtk_Image;

  begin

    V_Bombo_Image := Gtk.Image.Gtk_Image_New_From_File (F_Swap_Bombo_Image);

    Self.Set_Image (V_Bombo_Image);

  end P_Button_Released;

  --==================================================================

  procedure P_Create_Numbers (V_Numbers_Box : out Gtk.Box.Gtk_Box) is

    V_Horizontal : Gtk.Box.Gtk_Box;

    V_Index : Positive := 1;

  begin

    Gtk.Box.Gtk_New_Vbox
       (Box         => V_Numbers_Box,
        Homogeneous => True);

    for I in 1 .. 9 loop

      Gtk.Box.Gtk_New_Hbox (Box         => V_Horizontal,
                            Homogeneous => True);

      Gtk.Box.Pack_Start
         (In_Box => V_Numbers_Box,
          Child  => V_Horizontal,
          Expand => True,
          Fill   => True);

      for J in 1 .. 10 loop

        Gtk.Button.Gtk_New
           (V_Button_Array (V_Index), Label => F_Get_Number (V_Index));

        V_Button_Array (V_Index).Set_Sensitive (False);

        Gtk.Box.Pack_Start
           (In_Box => V_Horizontal,
            Child  => V_Button_Array (V_Index),
            Expand => True,
            Fill   => True);

        V_Index := V_Index + 1;

      end loop;

    end loop;

  end P_Create_Numbers;

  --==================================================================

  type T_Widgets_To_Update is null record;

  V_Null_Record : T_Widgets_To_Update;

  package Q_Timeout is new Glib.Main.Generic_Sources (T_Widgets_To_Update);

  V_Timeout : Glib.Main.G_Source_Id;

  V_Spin_Timeout : Glib.Main.G_Source_Id;

  --==================================================================

  function F_Swap_Bombo_Image (V_User : T_Widgets_To_Update) return Boolean is

    pragma Unreferenced (V_User);

  begin

    V_Bombo_Button.Set_Image
       (Gtk.Image.Gtk_Image_New_From_File (F_Swap_Bombo_Image));

    return True;

  end F_Swap_Bombo_Image;

  --==================================================================

  function F_Spin_Timeout (V_User : T_Widgets_To_Update) return Boolean is

    pragma Unreferenced (V_User);

  begin

    P_Get_Number;

    return True;

  end F_Spin_Timeout;

  --==================================================================

  procedure P_Start_Timer is

  begin

    V_Spin_Timeout := Q_Timeout.Timeout_Add
       (--  This timeout will refresh every 5sec
        500,
        --  This is the function to call in the timeout
        F_Swap_Bombo_Image'Access,
        --  This is the part of the GUI to refresh
        V_Null_Record);

    V_Timeout := Q_Timeout.Timeout_Add
       (--  This timeout will refresh every 5sec
        6000,
        --  This is the function to call in the timeout
        F_Spin_Timeout'Access,
        --  This is the part of the GUI to refresh
        V_Null_Record);

  end P_Start_Timer;

  --==================================================================

  procedure P_Stop_Timer is

  begin

    if V_Timeout /= 0 then

      Glib.Main.Remove (V_Timeout);

      Glib.Main.Remove (V_Spin_Timeout);

      V_Timeout := 0;

      V_Spin_Timeout := 0;

    end if;

  end P_Stop_Timer;

  --==================================================================

  procedure P_Start_Pause_Bingo is

  begin

    if V_Timeout /= 0 then

      P_Stop_Timer;

    else

      P_Start_Timer;

    end if;

  end P_Start_Pause_Bingo;

  --==================================================================

  package Q_Main_Window_Handler is new Gtk.Handlers.Return_Callback
     (Gtk.Widget.Gtk_Widget_Record, Boolean);

  function F_Main_Window_Button_Press
     (V_Object : access Gtk.Widget.Gtk_Widget_Record'Class;
      V_Event  : Gdk.Event.Gdk_Event) return Boolean is

    C_Key_Val : constant Gdk.Types.Gdk_Key_Type :=
       Gdk.Event.Get_Key_Val (V_Event);

  begin

    case C_Key_Val is
       when Gdk.Types.Keysyms.Gdk_Lc_S |
         Gdk.Types.Keysyms.Gdk_S |
         Gdk.Types.Keysyms.Gdk_Space =>

         P_Start_Pause_Bingo;

       when Gdk.Types.Keysyms.Gdk_F11 =>

         if V_Is_In_Fullscreen then

           Gtk.Window.Gtk_Window(V_Object).Unfullscreen;
           V_Is_In_Fullscreen := False;

         else

           Gtk.Window.Gtk_Window(V_Object).Fullscreen;
           V_Is_In_Fullscreen := True;
         end if;

       when Gdk.Types.Keysyms.Gdk_Escape =>

         Gtk.Window.Gtk_Window(V_Object).Unfullscreen;
         V_Is_In_Fullscreen := False;

       when others =>

         null;
    end case;

    return True;

  end F_Main_Window_Button_Press;

  --==================================================================

  procedure P_Create_Upper_Area (V_Upper_Area : out Gtk.Box.Gtk_Box) is

    V_Bombo_Image : Gtk.Image.Gtk_Image;

    V_Numbers_Box : Gtk.Box.Gtk_Box;

    V_Numbers_Box_Upper : Gtk.Box.Gtk_Box;

    V_Numbers_Box_Lower : Gtk.Box.Gtk_Box;

  begin

    Gtk.Box.Gtk_New_Hbox
       (Box         => V_Upper_Area,
        Homogeneous => True);

    Gtk.Button.Gtk_New (V_Bombo_Button);

    Gtk.Button.Gtk_New (V_Current_Number, Label => C_Null_Number_Image);

    V_Current_Number.Set_Sensitive (False);

    Gtk.Button.Gtk_New (V_Previous_Number_1, Label => C_Null_Number_Image);

    V_Previous_Number_1.Set_Sensitive (False);

    Gtk.Button.Gtk_New (V_Previous_Number_2, Label => C_Null_Number_Image);

    V_Previous_Number_2.Set_Sensitive (False);

    Gtk.Button.Gtk_New (V_Previous_Number_3, Label => C_Null_Number_Image);

    V_Previous_Number_3.Set_Sensitive (False);

    Q_Main_Window_Handler.Connect
       (V_Bombo_Button,
        "key_press_event",
        Q_Main_Window_Handler.To_Marshaller
           (F_Main_Window_Button_Press'Access));

    V_Bombo_Button.On_Pressed (P_Button_Pressed'Access);

    V_Bombo_Button.On_Released (P_Button_Released'Access);

    V_Bombo_Button.On_Clicked (P_Button_Clicked'Access);

    V_Bombo_Image := Gtk.Image.Gtk_Image_New_From_File (C_Bombo_File);

    V_Bombo_Button.Set_Image (Image => V_Bombo_Image);

    V_Bombo_Button.Set_Name ("drum_button");

    Gtk.Box.Pack_Start
       (In_Box => V_Upper_Area,
        Child  => V_Bombo_Button);

    Gtk.Box.Gtk_New_Vbox
       (Box         => V_Numbers_Box,
        Homogeneous => True);

    Gtk.Box.Pack_Start
       (In_Box => V_Upper_Area,
        Child  => V_Numbers_Box);

    Gtk.Box.Gtk_New_Hbox
       (Box         => V_Numbers_Box_Upper,
        Homogeneous => True);

    Gtk.Box.Gtk_New_Hbox
       (Box         => V_Numbers_Box_Lower,
        Homogeneous => True);

    Gtk.Box.Pack_Start
       (In_Box => V_Numbers_Box,
        Child  => V_Numbers_Box_Upper);

    Gtk.Box.Pack_Start
       (In_Box => V_Numbers_Box,
        Child  => V_Numbers_Box_Lower);

    Gtk.Box.Pack_Start
       (In_Box => V_Numbers_Box_Upper,
        Child  => V_Current_Number);

    Gtk.Box.Pack_Start
       (In_Box => V_Numbers_Box_Lower,
        Child  => V_Previous_Number_1);

    Gtk.Box.Pack_Start
       (In_Box => V_Numbers_Box_Lower,
        Child  => V_Previous_Number_2);

    Gtk.Box.Pack_Start
       (In_Box => V_Numbers_Box_Lower,
        Child  => V_Previous_Number_3);

  end P_Create_Upper_Area;

  --==================================================================

  procedure P_Create_Main_Window
     (V_Menu_Bar    : Gtk.Menu_Bar.Gtk_Menu_Bar;
      V_Upper_Area  : Gtk.Box.Gtk_Box;
      V_Numbers_Box : Gtk.Box.Gtk_Box;
      V_Main_Window : out Gtk.Window.Gtk_Window) is

    V_Vertical_Box : Gtk.Box.Gtk_Box;

    C_Icon : constant String := "bingada.png";
    V_Icon : Gdk.Pixbuf.Gdk_Pixbuf;

    V_Icon_Error : Glib.Error.Gerror;

  begin

    -- Create main window box
    --
    Gtk.Window.Gtk_New (V_Main_Window, Gtk.Enums.Window_Toplevel);

    Gtk.Window.Set_Modal (Window => V_Main_Window,
                          Modal  => False);

    Gtk.Window.Set_Title (V_Main_Window, "BingAda");

    Gdk.Pixbuf.Gdk_New_From_File
      (Pixbuf   => V_Icon,
       Filename => C_Icon,
       Error    => V_Icon_Error);

    Gtk.Window.Set_Default_Icon
      (Icon   => V_Icon);

    -- |--- Vertical BOX |
    -- |                 |
    -- |                 |
    -- |                 |
    --
    Gtk.Box.Gtk_New_Vbox
       (Box         => V_Vertical_Box,
        Homogeneous => False);

    Gtk.Window.Add
       (V_Main_Window,
        V_Vertical_Box);

    Gtk.Box.Pack_Start
       (In_Box => V_Vertical_Box,
        Child  => V_Menu_Bar,
        Expand => False,
        Fill   => True);

    --
    -- | ---- Vertical Box --- |
    -- | ------ Upper Area---- |
    -- | -                   - |
    -- | -                   - |
    -- | ------Numbers_box-----|
    -- | -                   - |
    -- | -                   - |
    -- | ----------------------|
    --
    Gtk.Box.Pack_Start
       (In_Box => V_Vertical_Box,
        Child  => V_Upper_Area);

    Gtk.Box.Pack_Start
       (In_Box => V_Vertical_Box,
        Child  => V_Numbers_Box);

  end P_Create_Main_Window;

  --==================================================================

  procedure P_Start_Bingo
     (V_Object : access Gtk.Menu_Item.Gtk_Menu_Item_Record'Class) is

    pragma Unreferenced (V_Object);

  begin

    --  If there is no timeout registered to monitor the tasks,
    --  start one now!
    --
    if V_Timeout = 0 then

      P_Start_Timer;

    end if;

  end P_Start_Bingo;

  --==================================================================

  procedure P_Pause_Bingo
     (V_Object : access Gtk.Menu_Item.Gtk_Menu_Item_Record'Class) is

    pragma Unreferenced (V_Object);

  begin

    P_Stop_Timer;

  end P_Pause_Bingo;

  --==================================================================

  V_Cards : Q_Csv.Q_Read_File.Q_Bingo_Cards.Vector;

  function F_Is_Number_Marked_Off
     (V_Number : Q_Bingo.T_Number) return Boolean is

    V_Found : Boolean := False;

  begin

    for I in 1 .. Q_Bingo.Q_Bombo.F_Get_Current_Index loop

      V_Found := Q_Bingo.Q_Bombo.F_Get_Number (I) = V_Number;

      exit when V_Found;

    end loop;

    return V_Found;

  end F_Is_Number_Marked_Off;

  --==================================================================

  function F_All_Numbers_Marked_Off
     (V_Card : Q_Csv.Q_Read_File.T_Card) return Boolean is

    V_All_Marked_Off : Boolean := True;

  begin

    for V_Number of V_Card.R_Numbers loop

      V_All_Marked_Off := F_Is_Number_Marked_Off (V_Number);

      exit when not V_All_Marked_Off;

    end loop;

    return V_All_Marked_Off;

  end F_All_Numbers_Marked_Off;

  --==================================================================

  procedure P_Check_Bingo (V_Cards : Q_Csv.Q_Read_File.Q_Bingo_Cards.Vector) is

  begin

    Text_Io.Put_Line ("-------------------------------------------");

    for V_Card of V_Cards loop

      Text_Io.Put_Line
         (V_Card.R_Name & " : " &
             Boolean'Image (F_All_Numbers_Marked_Off (V_Card)));

    end loop;

  end P_Check_Bingo;

  --==================================================================

  procedure P_Read_Cards_From_File is

  begin

    V_Cards.Set_Length (0);

    Q_Csv.Q_Read_File.P_Read_Bingo_Cards
       (V_File_Name => "bingo_cards.csv",
        V_Cards     => V_Cards);

    P_Check_Bingo (V_Cards);

  end P_Read_Cards_From_File;

  --==================================================================

  procedure P_Check_Cards
     (V_Object : access Gtk.Menu_Item.Gtk_Menu_Item_Record'Class) is

    pragma Unreferenced (V_Object);

  begin

    P_Read_Cards_From_File;

  end P_Check_Cards;

  --==================================================================

  procedure P_Load_Style is

    C_Default_Css_File : constant String := "bingada.css";
    C_Dark_Css_File : constant String := "bingada-dark.css";

  begin

    P_Load_Css (V_Filename => (if V_Dark_Style then C_Dark_Css_File
                               else C_Default_Css_File));

    V_Dark_Style := not V_Dark_Style;

  end P_Load_Style;

  --==================================================================

  procedure P_Toggle_Style
     (V_Object : access Gtk.Menu_Item.Gtk_Menu_Item_Record'Class) is

    pragma Unreferenced (V_Object);

  begin

    P_Load_Style;

  end p_toggle_style;

  --==================================================================

  procedure P_Init_Bingo is

  begin

    Q_Bingo.Q_Bombo.P_Init;

    for V_Button of V_Button_Array loop

      V_Button.Set_Name ("myButton_white");

    end loop;

    V_Current_Number.Set_Name ("current");

    V_Current_Number.Set_Label (C_Null_Number_Image);

    V_Previous_Number_1.Set_Label (C_Null_Number_Image);

    V_Previous_Number_2.Set_Label (C_Null_Number_Image);

    V_Previous_Number_3.Set_Label (C_Null_Number_Image);

    P_Stop_Timer;

  end P_Init_Bingo;

  --==================================================================

  package P_Menu_Item_Handler is new Gtk.Handlers.Callback
     (Gtk.Menu_Item.Gtk_Menu_Item_Record);

  procedure P_New_Game
     (V_Emitter : access Gtk.Menu_Item.Gtk_Menu_Item_Record'Class) is

    pragma Unreferenced (V_Emitter);

  begin

    P_Init_Bingo;

  end P_New_Game;

  --==================================================================

  procedure P_Exit_Bingo
     (Self : access Gtk.Menu_Item.Gtk_Menu_Item_Record'Class) is

  begin

    P_Main_Quit (Self);

  end P_Exit_Bingo;

  --==================================================================

  procedure P_Help_Bingo
     (V_Widget : access Gtk.Menu_Item.Gtk_Menu_Item_Record'Class) is

  begin

    Q_Bingo_Help.P_Show_Window
       (V_Parent_Window =>
           Gtk.Window.Gtk_Window (Gtk.Menu_Item.Get_Toplevel (V_Widget)));

  end P_Help_Bingo;

  --==================================================================

  procedure P_Create_Game_Menu
     (V_Game_Menu_Item : out Gtk.Menu_Item.Gtk_Menu_Item) is

    V_New_Game, V_Auto_Start, V_Pause, V_Check_Cards, V_Toggle_Style, V_Exit,
       V_Help : Gtk.Menu_Item.Gtk_Menu_Item;

    V_Game_Menu : Gtk.Menu.Gtk_Menu;

  begin

    --  Creates GAME menu submenus
    --
    Gtk.Menu_Item.Gtk_New_With_Mnemonic
       (V_New_Game, -"menu_new_game");

    Gtk.Menu_Item.Gtk_New_With_Mnemonic
       (V_Auto_Start, -"menu_auto_spin");

    Gtk.Menu_Item.Gtk_New_With_Mnemonic
       (V_Pause, -"menu_pause");

    Gtk.Menu_Item.Gtk_New_With_Mnemonic
       (V_Check_Cards, -"menu_check_cards");

    Gtk.Menu_Item.Gtk_New_With_Mnemonic
       (V_Toggle_Style, -"menu_toggle_style");

    Gtk.Menu_Item.Gtk_New_With_Mnemonic
       (V_Exit, -"menu_exit");

    Gtk.Menu_Item.Gtk_New_With_Mnemonic
       (V_Help, -"menu_help");

    Gtk.Menu_Item.Gtk_New_With_Mnemonic
       (V_Game_Menu_Item, -"main_menu");

    -- Creates the menu called game
    --
    Gtk.Menu.Gtk_New (V_Game_Menu);

    -- Append all menu items to the game menu.
    --
    Gtk.Menu.Append (Menu_Shell => V_Game_Menu,
                     Child      => V_New_Game);

    Gtk.Menu.Append (Menu_Shell => V_Game_Menu,
                     Child      => V_Auto_Start);

    Gtk.Menu.Append (Menu_Shell => V_Game_Menu,
                     Child      => V_Pause);

    Gtk.Menu.Append (Menu_Shell => V_Game_Menu,
                     Child      => V_Check_Cards);

    Gtk.Menu.Append (Menu_Shell => V_Game_Menu,
                     Child      => V_Toggle_Style);

    Gtk.Menu.Append (Menu_Shell => V_Game_Menu,
                     Child      => V_Help);

    Gtk.Menu.Append (Menu_Shell => V_Game_Menu,
                     Child      => V_Exit);

    -- Sets the submenu
    --
    Gtk.Menu_Item.Set_Submenu (V_Game_Menu_Item, V_Game_Menu);

    P_Menu_Item_Handler.Connect
       (V_New_Game,
        "activate",
        P_New_Game'Access);

    P_Menu_Item_Handler.Connect
       (V_Auto_Start,
        "activate",
        P_Start_Bingo'Access);

    P_Menu_Item_Handler.Connect
       (V_Pause,
        "activate",
        P_Pause_Bingo'Access);

     P_Menu_Item_Handler.Connect
       (V_Check_Cards,
        "activate",
        P_Check_Cards'Access);

     P_Menu_Item_Handler.Connect
       (V_Toggle_Style,
        "activate",
        P_Toggle_Style'Access);

    P_Menu_Item_Handler.Connect
       (V_Exit,
        "activate",
        P_Exit_Bingo'Access);

     P_Menu_Item_Handler.Connect
       (V_Help,
        "activate",
        P_Help_Bingo'Access);

  end P_Create_Game_Menu;

  --==================================================================

  procedure P_Create_Menu_Bar
     (V_Menu_Bar : out Gtk.Menu_Bar.Gtk_Menu_Bar) is

    V_Game_Menu_Item : Gtk.Menu_Item.Gtk_Menu_Item;

  begin

    P_Create_Game_Menu (V_Game_Menu_Item => V_Game_Menu_Item);

    -- It creates the menu bar which contains all the menus.
    --
    Gtk.Menu_Bar.Gtk_New (V_Menu_Bar);

    Gtk.Menu_Bar.Add (V_Menu_Bar, V_Game_Menu_Item);

  end P_Create_Menu_Bar;

  --==================================================================

  --[
  -- This is the main gtkada procedure.
  -- It initialises the bingo's bombo and the GTKAda HMI.
  --]
  procedure P_Create_Widgets is

    V_Upper_Area : Gtk.Box.Gtk_Box;

    V_Numbers_Box : Gtk.Box.Gtk_Box;

    V_Main_Window : Gtk.Window.Gtk_Window;

    V_Menu_Bar : Gtk.Menu_Bar.Gtk_Menu_Bar;

  begin

    Q_Bingo.Q_Gtk.Q_Intl.P_Initialise;

    P_Load_Style;

    P_Create_Upper_Area (V_Upper_Area => V_Upper_Area);

    P_Create_Numbers (V_Numbers_Box => V_Numbers_Box);

    P_Create_Menu_Bar (V_Menu_Bar => V_Menu_Bar);

    P_Create_Main_Window (V_Menu_Bar    => V_Menu_Bar,
                          V_Upper_Area  => V_Upper_Area,
                          V_Numbers_Box => V_Numbers_Box,
                          V_Main_Window => V_Main_Window);

    Q_Main_Window_Handler.Connect
       (V_Main_Window,
        "key_press_event",
        Q_Main_Window_Handler.To_Marshaller
           (F_Main_Window_Button_Press'Access));

    -- Initialise bombo numbers.
    --
    P_Init_Bingo;

    Q_Sound.P_Initialize;

    V_Main_Window.On_Destroy (P_Main_Quit'Access);

    V_Main_Window.Maximize;

    V_Main_Window.Show_All;

  end P_Create_Widgets;

  --==================================================================

end Q_Bingada;
