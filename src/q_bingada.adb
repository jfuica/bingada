--*****************************************************************************
--*
--* PROJECT:            BINGADA
--*
--* FILE:               q_bingada.adb
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************


with TEXT_IO;

with ADA.STRINGS.FIXED;
with ADA.CONTAINERS;


with GLIB.MAIN;
with GLIB.ERROR;

with GTK.BOX;
with GTK.MAIN;
with GTK.WINDOW;
with GTK.ENUMS;
with GTK.WIDGET;
with GTK.IMAGE;
with GTK.BUTTON;
with GTK.LABEL;
with GTK.MENU;
with GTK.MENU_BAR;
with GTK.MENU_ITEM;
with GTK.HANDLERS;

with GDK.EVENT;
with GDK.TYPES.KEYSYMS;
with GDK.PIXBUF;

with Q_BINGO.Q_BOMBO;
with Q_BINGO_HELP;
with Q_CSV.Q_READ_FILE;

package body Q_BINGADA is
  
  use type GLIB.MAIN.G_SOURCE_ID;
  use type GLIB.GUINT;
  use type GDK.TYPES.GDK_KEY_TYPE;
  
  --==================================================================
  
  C_NULL_NUMBER_IMAGE : constant STRING := " ";
  
  C_EXIT_MESSAGE : constant STRING := "Hasta la vista!";
  
  C_BOMBO_FILE : constant STRING := "bombo.png";
  
  C_DRUM_SPIN_FILE : constant STRING := "drum_spin.png";
    
  --==================================================================
  
  procedure P_MAIN_QUIT (SELF : access GTK.WIDGET.GTK_WIDGET_RECORD'Class) is
    
    pragma UNREFERENCED (SELF);
    
  begin
    
    TEXT_IO.PUT_LINE (C_EXIT_MESSAGE);
    
    GTK.MAIN.MAIN_QUIT;
    
  end P_MAIN_QUIT;
  
  --==================================================================
  
  V_CURRENT_NUMBER : GTK.BUTTON.GTK_BUTTON;
  
  V_PREVIOUS_NUMBER_1 : GTK.BUTTON.GTK_BUTTON;
  
  V_PREVIOUS_NUMBER_2 : GTK.BUTTON.GTK_BUTTON;
  
  V_PREVIOUS_NUMBER_3 : GTK.BUTTON.GTK_BUTTON;

  C_MAX_BUTTONS : constant := Q_BINGO.C_LAST_NUMBER;
  
  type T_BUTTONS_ARRAY is array (1 .. C_MAX_BUTTONS) of GTK.BUTTON.GTK_BUTTON;
  
  V_BUTTON_ARRAY : T_BUTTONS_ARRAY;
  
  --==================================================================
  
  function F_GET_NUMBER (V_INDEX : POSITIVE) return STRING is
    
  begin
    
    if V_INDEX < 10 then
      
      return " " & ADA.STRINGS.FIXED.TRIM (SOURCE => V_INDEX'IMAGE,
                                           SIDE   => ADA.STRINGS.BOTH);
      
    else
      
      return ADA.STRINGS.FIXED.TRIM (SOURCE => V_INDEX'IMAGE,
                                     SIDE   => ADA.STRINGS.BOTH);

    end if;
      
  end F_GET_NUMBER;
  
  --==================================================================
  
  procedure P_SET_CURRENT_AND_PREVIOUS_NUMBERS 
     (V_CURRENT_INDEX : Q_BINGO.T_NUMBER) is
    
    C_NUMBER : constant POSITIVE := 
       Q_BINGO.Q_BOMBO.F_GET_NUMBER (V_CURRENT_INDEX);
 
  begin
    
    GTK.LABEL.SET_MARKUP 
       (GTK.LABEL.GTK_LABEL
           (GTK.BUTTON.GET_CHILD (V_BUTTON_ARRAY (C_NUMBER))), 
        "<span face=""Sans Italic"" weight=""bold"" color=""blue"" " &
           "size=""xx-large"" >" &  F_GET_NUMBER (C_NUMBER) & "</span>");
      
    V_BUTTON_ARRAY (C_NUMBER).SET_SENSITIVE (TRUE);
    
    GTK.LABEL.SET_MARKUP 
       (GTK.LABEL.GTK_LABEL (GTK.BUTTON.GET_CHILD (V_CURRENT_NUMBER)), 
        "<span face=""Sans Italic"" weight=""bold"" color=""blue"" " &
           "size=""xx-large"" >" & 
           F_GET_NUMBER (Q_BINGO.Q_BOMBO.F_GET_NUMBER (V_CURRENT_INDEX)) & 
           "</span>");
      
    if V_CURRENT_INDEX > 2 then
      
      GTK.LABEL.SET_MARKUP 
         (GTK.LABEL.GTK_LABEL (GTK.BUTTON.GET_CHILD (V_PREVIOUS_NUMBER_1)), 
          "<span face=""Sans Italic"" color=""red"" size=""large"" >" & 
             F_GET_NUMBER 
             (Q_BINGO.Q_BOMBO.F_GET_NUMBER (V_CURRENT_INDEX - 1)) & "</span>");
      
    end if;
    
    if V_CURRENT_INDEX > 3 then
      
      GTK.LABEL.SET_MARKUP 
         (GTK.LABEL.GTK_LABEL (GTK.BUTTON.GET_CHILD (V_PREVIOUS_NUMBER_2)), 
          "<span face=""Sans Italic""color=""red"" size=""large"" >" & 
             F_GET_NUMBER (Q_BINGO.Q_BOMBO.F_GET_NUMBER 
                              (V_CURRENT_INDEX - 2)) & "</span>");
      
    end if;
    
    if V_CURRENT_INDEX > 4 then
      
      GTK.LABEL.SET_MARKUP 
         (GTK.LABEL.GTK_LABEL (GTK.BUTTON.GET_CHILD (V_PREVIOUS_NUMBER_3)), 
          "<span face=""Sans Italic"" color=""red"" size=""large"" >" & 
             F_GET_NUMBER (Q_BINGO.Q_BOMBO.F_GET_NUMBER 
                              (V_CURRENT_INDEX - 3)) & "</span>");
      
    end if;
    
  end P_SET_CURRENT_AND_PREVIOUS_NUMBERS;
  
  --==================================================================
  
  procedure P_GET_NUMBER is
    
    V_LAST_NUMBER : BOOLEAN;
    
    V_CURRENT_INDEX : Q_BINGO.T_NUMBER;
    
    V_NUMBER : POSITIVE;
  
  begin
    
    Q_BINGO.Q_BOMBO.P_SPIN (V_NUMBER        => V_NUMBER,
                            V_CURRENT_INDEX => V_CURRENT_INDEX,
                            V_LAST_NUMBER   => V_LAST_NUMBER);
    
    P_SET_CURRENT_AND_PREVIOUS_NUMBERS (V_CURRENT_INDEX => V_CURRENT_INDEX);
                               
  end P_GET_NUMBER;
  
  --==================================================================
  
  procedure P_BUTTON_CLICKED
     (SELF : access GTK.BUTTON.GTK_BUTTON_RECORD'CLASS) is
    
    pragma UNREFERENCED (SELF);
    
  begin
    
    P_GET_NUMBER;
    
  end P_BUTTON_CLICKED;
  
  --==================================================================
  
  procedure P_BUTTON_PRESSED
     (SELF : access GTK.BUTTON.GTK_BUTTON_RECORD'CLASS) is
    
    V_DRUM_SPIN_IMAGE : GTK.IMAGE.GTK_IMAGE;
  
  begin
    
    V_DRUM_SPIN_IMAGE := GTK.IMAGE.GTK_IMAGE_NEW_FROM_FILE (C_DRUM_SPIN_FILE);
     
    SELF.SET_IMAGE (V_DRUM_SPIN_IMAGE);
     
  end P_BUTTON_PRESSED;
  
  --==================================================================
  
  procedure P_BUTTON_RELEASED
     (SELF : access GTK.BUTTON.GTK_BUTTON_RECORD'CLASS) is
    
    V_BOMBO_IMAGE : GTK.IMAGE.GTK_IMAGE;
    
  begin
     
    V_BOMBO_IMAGE := GTK.IMAGE.GTK_IMAGE_NEW_FROM_FILE (C_BOMBO_FILE);
    
    SELF.SET_IMAGE (V_BOMBO_IMAGE);
     
  end P_BUTTON_RELEASED;
  
  --==================================================================
  
  procedure P_CREATE_NUMBERS (V_NUMBERS_BOX : out GTK.BOX.GTK_BOX) is
    
    V_HORIZONTAL : GTK.BOX.GTK_BOX;
    
    V_INDEX : POSITIVE := 1;
    
  begin
    
    GTK.BOX.GTK_NEW_VBOX
       (BOX         => V_NUMBERS_BOX,
        HOMOGENEOUS => TRUE);
    
    for I in 1 .. 9 loop
      
      GTK.BOX.GTK_NEW_HBOX (BOX         => V_HORIZONTAL,
                            HOMOGENEOUS => TRUE);
      
      GTK.BOX.PACK_START
         (IN_BOX => V_NUMBERS_BOX,
          CHILD  => V_HORIZONTAL,
          EXPAND => TRUE,
          FILL   => TRUE);
      
      for J in 1 .. 10 loop
      
        GTK.BUTTON.GTK_NEW 
           (V_BUTTON_ARRAY (V_INDEX), LABEL => F_GET_NUMBER (V_INDEX));
        
        GTK.LABEL.SET_MARKUP 
           (GTK.LABEL.GTK_LABEL 
               (GTK.BUTTON.GET_CHILD (V_BUTTON_ARRAY (V_INDEX))), 
            "<span face=""Sans"" weight=""bold"" color=""red"" size=""xx-large"" >" & 
               F_GET_NUMBER (V_INDEX) & "</span>");
        
        V_BUTTON_ARRAY (V_INDEX).SET_SENSITIVE (FALSE);
        
        GTK.BOX.PACK_START
           (IN_BOX => V_HORIZONTAL,
            CHILD  => V_BUTTON_ARRAY (V_INDEX),
            EXPAND => TRUE,
            FILL   => TRUE);
        
        V_INDEX := V_INDEX + 1;
        
      end loop;
      
    end loop;
    
  end P_CREATE_NUMBERS;
  
  --==================================================================
  
  type T_WIDGETS_TO_UPDATE is null record;
  
  V_NULL_RECORD : T_WIDGETS_TO_UPDATE;
  
  package Q_TIMEOUT is new GLIB.MAIN.GENERIC_SOURCES (T_WIDGETS_TO_UPDATE);
  
  V_TIMEOUT : GLIB.MAIN.G_SOURCE_ID;
  
  --==================================================================
  
  function F_TIMEOUT_TEST (V_USER : T_WIDGETS_TO_UPDATE) return BOOLEAN is
    
    pragma UNREFERENCED (V_USER);
    
  begin
    
    P_GET_NUMBER;
    
    return TRUE;
    
  end F_TIMEOUT_TEST;
  
  --==================================================================
  
  procedure P_START_TIMER is
    
  begin
    
    V_TIMEOUT := Q_TIMEOUT.TIMEOUT_ADD
       (--  This timeout will refresh every 5sec
        5000,
        --  This is the function to call in the timeout
        F_TIMEOUT_TEST'ACCESS,
        --  This is the part of the GUI to refresh
        V_NULL_RECORD);
      
  end P_START_TIMER;
  
  --==================================================================

  procedure P_STOP_TIMER is
    
  begin
    
    if V_TIMEOUT /= 0 then
      
      GLIB.MAIN.REMOVE (V_TIMEOUT);
      
      V_TIMEOUT := 0;
      
    end if;
    
  end P_STOP_TIMER;
  
  --==================================================================
  
  procedure P_START_PAUSE_BINGO is
    
  begin
    
    if V_TIMEOUT /= 0 then
      
      P_STOP_TIMER;
      
    else
      
      P_START_TIMER;
      
    end if;
    
  end P_START_PAUSE_BINGO;
  
  --==================================================================
  
  package Q_MAIN_WINDOW_HANDLER is new GTK.HANDLERS.RETURN_CALLBACK
     (GTK.WIDGET.GTK_WIDGET_RECORD, BOOLEAN);
  
  function F_MAIN_WINDOW_BUTTON_PRESS
     (V_OBJECT : access GTK.WIDGET.GTK_WIDGET_RECORD'CLASS;
      V_EVENT  : GDK.EVENT.GDK_EVENT) return BOOLEAN is
    
    pragma UNREFERENCED (V_OBJECT);
    
    C_KEY_VAL : constant GDK.TYPES.GDK_KEY_TYPE := 
       GDK.EVENT.GET_KEY_VAL (V_EVENT);
    
  begin
    
    --TEXT_IO.PUT_LINE 
    --   ("button pressed : " & GLIB.GUINT'IMAGE
    --       (GDK.EVENT.GET_BUTTON (V_EVENT)) & " key val " &
    --       GDK.TYPES.GDK_KEY_TYPE'IMAGE (GDK.EVENT.GET_KEY_VAL (V_EVENT)));
        
    if C_KEY_VAL = GDK.TYPES.KEYSYMS.GDK_LC_s or else
       C_KEY_VAL = GDK.TYPES.KEYSYMS.GDK_S then
      
      P_START_PAUSE_BINGO;
          
    end if;
        
    return TRUE;
        
  end F_MAIN_WINDOW_BUTTON_PRESS;
  
  --==================================================================
  
  procedure P_CREATE_UPPER_AREA (V_UPPER_AREA : out GTK.BOX.GTK_BOX) is
    
    V_BOMBO_BUTTON : GTK.BUTTON.GTK_BUTTON;
    
    V_BOMBO_IMAGE : GTK.IMAGE.GTK_IMAGE;
    
    V_NUMBERS_BOX : GTK.BOX.GTK_BOX;
    
    V_NUMBERS_BOX_UPPER : GTK.BOX.GTK_BOX;
    
    V_NUMBERS_BOX_LOWER : GTK.BOX.GTK_BOX;
    
  begin
    
    GTK.BOX.GTK_NEW_HBOX
       (BOX         => V_UPPER_AREA,
        HOMOGENEOUS => TRUE);
    
    GTK.BUTTON.GTK_NEW (V_BOMBO_BUTTON);
    
    GTK.BUTTON.GTK_NEW (V_CURRENT_NUMBER, LABEL => C_NULL_NUMBER_IMAGE);
    
    GTK.BUTTON.GTK_NEW (V_PREVIOUS_NUMBER_1, LABEL => C_NULL_NUMBER_IMAGE);
    
    GTK.BUTTON.GTK_NEW (V_PREVIOUS_NUMBER_2, LABEL => C_NULL_NUMBER_IMAGE);
    
    GTK.BUTTON.GTK_NEW (V_PREVIOUS_NUMBER_3, LABEL => C_NULL_NUMBER_IMAGE);
    
    Q_MAIN_WINDOW_HANDLER.CONNECT
       (V_BOMBO_BUTTON,
        "key_press_event",
        Q_MAIN_WINDOW_HANDLER.TO_MARSHALLER 
           (F_MAIN_WINDOW_BUTTON_PRESS'ACCESS));

    V_BOMBO_BUTTON.ON_PRESSED (P_BUTTON_PRESSED'ACCESS);
    
    V_BOMBO_BUTTON.ON_RELEASED (P_BUTTON_RELEASED'ACCESS);
     
    V_BOMBO_BUTTON.ON_CLICKED (P_BUTTON_CLICKED'ACCESS);
    
    V_BOMBO_IMAGE := GTK.IMAGE.GTK_IMAGE_NEW_FROM_FILE (C_BOMBO_FILE);
    
    V_BOMBO_BUTTON.SET_IMAGE (IMAGE => V_BOMBO_IMAGE);

    GTK.BOX.PACK_START
       (IN_BOX => V_UPPER_AREA,
        CHILD  => V_BOMBO_BUTTON);
    
    GTK.BOX.GTK_NEW_VBOX
       (BOX         => V_NUMBERS_BOX,
        HOMOGENEOUS => TRUE);
    
    GTK.BOX.PACK_START
       (IN_BOX => V_UPPER_AREA,
        CHILD  => V_NUMBERS_BOX);
    
    GTK.BOX.GTK_NEW_HBOX
       (BOX         => V_NUMBERS_BOX_UPPER,
        HOMOGENEOUS => TRUE);
    
    GTK.BOX.GTK_NEW_HBOX
       (BOX         => V_NUMBERS_BOX_LOWER,
        HOMOGENEOUS => TRUE);
    
    GTK.BOX.PACK_START
       (IN_BOX => V_NUMBERS_BOX,
        CHILD  => V_NUMBERS_BOX_UPPER);
    
    GTK.BOX.PACK_START
       (IN_BOX => V_NUMBERS_BOX,
        CHILD  => V_NUMBERS_BOX_LOWER);
    
    GTK.BOX.PACK_START
       (IN_BOX => V_NUMBERS_BOX_UPPER,
        CHILD  => V_CURRENT_NUMBER);
    
    GTK.BOX.PACK_START
       (IN_BOX => V_NUMBERS_BOX_LOWER,
        CHILD  => V_PREVIOUS_NUMBER_1);
    
    GTK.BOX.PACK_START
       (IN_BOX => V_NUMBERS_BOX_LOWER,
        CHILD  => V_PREVIOUS_NUMBER_2);
    
    GTK.BOX.PACK_START
       (IN_BOX => V_NUMBERS_BOX_LOWER,
        CHILD  => V_PREVIOUS_NUMBER_3);
    
  end P_CREATE_UPPER_AREA;
  
  --==================================================================
  
  procedure P_CREATE_MAIN_WINDOW 
     (V_MENU_BAR    : GTK.MENU_BAR.GTK_MENU_BAR;
      V_UPPER_AREA  : GTK.BOX.GTK_BOX;
      V_NUMBERS_BOX : GTK.BOX.GTK_BOX;
      V_MAIN_WINDOW : out GTK.WINDOW.GTK_WINDOW) is
    
    V_VERTICAL_BOX : GTK.BOX.GTK_BOX;
    
    V_BOMBO_ICON : GDK.PIXBUF.GDK_PIXBUF;

    V_ICON_ERROR : GLIB.ERROR.GERROR;

    --V_HORIZONTAL_BOX_1 : GTK.BOX.GTK_BOX;
    
  begin
    
    -- Main_Window.Vbox.PACK_START
    --    (CHILD  =>Menu_Bar,
    --     EXPAND =>false,
    --     FILL   =>false);
 
    -- Create main window box
    --
    GTK.WINDOW.GTK_NEW (V_MAIN_WINDOW, GTK.ENUMS.WINDOW_TOPLEVEL);
    
    GTK.WINDOW.SET_MODAL (WINDOW => V_MAIN_WINDOW, 
                          MODAL  => FALSE);

    GTK.WINDOW.SET_TITLE (V_MAIN_WINDOW, "BingAda");
    
    GDK.PIXBUF.GDK_NEW_FROM_FILE
      (PIXBUF   => V_BOMBO_ICON,
       FILENAME => C_BOMBO_FILE,
       ERROR    => V_ICON_ERROR);

    GTK.WINDOW.SET_ICON
      (WINDOW => V_MAIN_WINDOW,
       ICON   => V_BOMBO_ICON);

    -- |--- Vertical BOX |
    -- |                 |
    -- |                 |
    -- |                 |
    --
    GTK.BOX.GTK_NEW_VBOX
       (BOX         => V_VERTICAL_BOX,
        HOMOGENEOUS => FALSE);
    
    --GTK.BOX.GTK_NEW_HBOX
    --   (BOX         => V_HORIZONTAL_BOX_1,
    --    HOMOGENEOUS => TRUE);
    
    GTK.WINDOW.ADD
       (V_MAIN_WINDOW,
        V_VERTICAL_BOX);
    
    GTK.BOX.PACK_START
       (IN_BOX => V_VERTICAL_BOX,
        CHILD  => V_MENU_BAR,
        EXPAND => FALSE,
        FILL   => TRUE);
    
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
    GTK.BOX.PACK_START
       (IN_BOX => V_VERTICAL_BOX,
        CHILD  => V_UPPER_AREA);
    
    GTK.BOX.PACK_START
       (IN_BOX => V_VERTICAL_BOX,
        CHILD  => V_NUMBERS_BOX);
    
  end P_CREATE_MAIN_WINDOW;
  
  --==================================================================
  
  procedure P_START_BINGO
     (V_OBJECT : access GTK.MENU_ITEM.GTK_MENU_ITEM_RECORD'CLASS) is
    
    pragma UNREFERENCED (V_OBJECT);
    
  begin
    
    --  If there is no timeout registered to monitor the tasks,
    --  start one now!
    if V_Timeout = 0 then
      
      P_START_TIMER;
      
    end if;
    
  end P_START_BINGO;
  
  --==================================================================
  
  procedure P_PAUSE_BINGO 
     (V_Object : access GTK.MENU_ITEM.GTK_MENU_ITEM_RECORD'Class) is
    
    pragma UNREFERENCED (V_Object);
    
  begin
    
    P_STOP_TIMER;
    
  end P_PAUSE_BINGO;
  
  --==================================================================
  
  V_CARDS : Q_CSV.Q_READ_FILE.Q_BINGO_CARDS.VECTOR;
  
  function F_IS_NUMBER_MARKED_OFF
     (V_NUMBER : Q_BINGO.T_NUMBER) return BOOLEAN is
    
    V_FOUND : BOOLEAN := FALSE;
    
  begin
    
    for I in 1 .. Q_BINGO.Q_BOMBO.F_GET_CURRENT_INDEX loop
      
      V_FOUND := Q_BINGO.Q_BOMBO.F_GET_NUMBER (I) = V_NUMBER;
         
      exit when V_FOUND;
         
    end loop;
    
    return V_FOUND;
    
  end F_IS_NUMBER_MARKED_OFF;
  
  --==================================================================
  
  function F_ALL_NUMBERS_MARKED_OFF
     (V_CARD : Q_CSV.Q_READ_FILE.T_CARD) return BOOLEAN is
    
    V_ALL_MARKED_OFF : BOOLEAN := TRUE;
    
  begin
    
    for I in V_CARD.R_NUMBERS'RANGE loop
      
      V_ALL_MARKED_OFF := F_IS_NUMBER_MARKED_OFF (V_CARD.R_NUMBERS (I));
      
      exit when not V_ALL_MARKED_OFF;
      
    end loop;
    
    return V_ALL_MARKED_OFF;
    
  end F_ALL_NUMBERS_MARKED_OFF;
  
  --==================================================================
  
  procedure P_CHECK_BINGO (V_CARDS : Q_CSV.Q_READ_FILE.Q_BINGO_CARDS.VECTOR) is
    
  begin
    
    TEXT_IO.PUT_LINE ("-------------------------------------------");
    
    for V_CARD of V_CARDS loop
      
      TEXT_IO.PUT_LINE 
         (V_CARD.R_NAME & " : " & 
             BOOLEAN'IMAGE (F_ALL_NUMBERS_MARKED_OFF (V_CARD)));
      
    end loop;
       
  end P_CHECK_BINGO;
  
  --==================================================================
  
  procedure P_SHOW_CARDS (V_CARDS : Q_CSV.Q_READ_FILE.Q_BINGO_CARDS.VECTOR) is
    
  begin
    
    TEXT_IO.PUT_LINE ("Number of Elements : " & 
                         ADA.CONTAINERS.COUNT_TYPE'IMAGE (V_CARDS.LENGTH));
    
    for E of V_CARDS loop
      
      TEXT_IO.PUT_LINE ("- " & E.R_NAME);
      
    end loop;
    
  end P_SHOW_CARDS;
  
  --==================================================================
  
  procedure P_READ_CARDS_FROM_FILE is
    
  begin
    
    V_CARDS.SET_LENGTH (0);
    
    Q_CSV.Q_READ_FILE.P_READ_BINGO_CARDS
       (V_FILE_NAME => "bingo_cards.csv",
        V_CARDS     => V_CARDS);
    
    P_CHECK_BINGO (V_CARDS);
    
    --P_SHOW_CARDS (V_CARDS);
    
  end P_READ_CARDS_FROM_FILE;
  
  --==================================================================
  
  procedure P_CHECK_CARDS 
     (V_Object : access GTK.MENU_ITEM.GTK_MENU_ITEM_RECORD'Class) is
    
    pragma UNREFERENCED (V_Object);
    
  begin
    
    P_READ_CARDS_FROM_FILE;
    
  end P_CHECK_CARDS;
  
  --==================================================================
  
  procedure P_INIT_BINGO is
    
  begin
    
    Q_BINGO.Q_BOMBO.P_INIT;
    
    for I in 1 .. C_MAX_BUTTONS loop
      
      GTK.LABEL.SET_MARKUP 
         (GTK.LABEL.GTK_LABEL 
             (GTK.BUTTON.GET_CHILD (V_BUTTON_ARRAY (I))), 
          "<span face=""Sans"" weight=""bold"" color=""red"" size=""xx-large"" >" & 
             F_GET_NUMBER (I) & "</span>");
     
    end loop;
    
    V_CURRENT_NUMBER.SET_LABEL (C_NULL_NUMBER_IMAGE);
    
    V_PREVIOUS_NUMBER_1.SET_LABEL (C_NULL_NUMBER_IMAGE);
    
    V_PREVIOUS_NUMBER_2.SET_LABEL (C_NULL_NUMBER_IMAGE);
    
    V_PREVIOUS_NUMBER_3.SET_LABEL (C_NULL_NUMBER_IMAGE);
    
    P_STOP_TIMER;
    
  end P_INIT_BINGO;
  
  --==================================================================
  
  package P_MENU_ITEM_HANDLER is new GTK.HANDLERS.CALLBACK
     (GTK.MENU_ITEM.GTK_MENU_ITEM_RECORD);
  
  procedure P_NEW_GAME 
     (V_EMITTER : access GTK.MENU_ITEM.GTK_MENU_ITEM_RECORD'CLASS) is
    
    pragma UNREFERENCED (V_EMITTER);
    
  begin
    
    P_INIT_BINGO;
    
  end P_NEW_GAME;
  
  --==================================================================
  
  procedure P_EXIT_BINGO
     (SELF : access GTK.MENU_ITEM.GTK_MENU_ITEM_RECORD'CLASS) is
    
  begin
    
    P_MAIN_QUIT (SELF);
    
  end P_EXIT_BINGO;
  
  --==================================================================
  
  procedure P_HELP_BINGO
     (V_WIDGET : access GTK.MENU_ITEM.GTK_MENU_ITEM_RECORD'CLASS) is
    
  begin
    
    Q_BINGO_HELP.P_SHOW_WINDOW 
       (V_PARENT_WINDOW => 
           GTK.WINDOW.GTK_WINDOW (GTK.MENU_ITEM.GET_TOPLEVEL (V_WIDGET)));
    
  end P_HELP_BINGO;
  
  --==================================================================
  
  procedure P_CREATE_GAME_MENU 
     (V_GAME_MENU_ITEM : out GTK.MENU_ITEM.GTK_MENU_ITEM) is
    
    V_NEW_GAME, V_AUTO_START, V_PAUSE, V_CHECK_CARDS, V_EXIT, 
       V_HELP : GTK.MENU_ITEM.GTK_MENU_ITEM;
    
    V_GAME_MENU : GTK.MENU.GTK_MENU;
    
  begin
    
    --  Creates GAME menu submenus
    --
    GTK.MENU_ITEM.GTK_NEW_WITH_MNEMONIC (V_NEW_GAME, "_NewGame");
    
    GTK.MENU_ITEM.GTK_NEW_WITH_MNEMONIC (V_AUTO_START, "_Auto_spin");
    
    GTK.MENU_ITEM.GTK_NEW_WITH_MNEMONIC (V_PAUSE, "_Pause");
    
    GTK.MENU_ITEM.GTK_NEW_WITH_MNEMONIC (V_CHECK_CARDS, "_Check Cards");

    GTK.MENU_ITEM.GTK_NEW_WITH_MNEMONIC (V_EXIT, "_Exit");
    
    GTK.MENU_ITEM.GTK_NEW_WITH_MNEMONIC (V_HELP, "_Help");
    
    GTK.MENU_ITEM.GTK_NEW_WITH_MNEMONIC (V_GAME_MENU_ITEM, "_Game");
    
    -- Creates the menu called game
    --
    GTK.MENU.GTK_NEW (V_GAME_MENU);
    
    -- Append all menu items to the game menu.
    --
    GTK.MENU.APPEND (MENU_SHELL => V_GAME_MENU,
                     CHILD      => V_NEW_GAME);
    
    GTK.MENU.APPEND (MENU_SHELL => V_GAME_MENU,
                     CHILD      => V_AUTO_START);
    
    GTK.MENU.APPEND (MENU_SHELL => V_GAME_MENU,
                     CHILD      => V_PAUSE);
    
    GTK.MENU.APPEND (MENU_SHELL => V_GAME_MENU,
                     CHILD      => V_CHECK_CARDS);
    
    GTK.MENU.APPEND (MENU_SHELL => V_GAME_MENU,
                     CHILD      => V_HELP);
    
    GTK.MENU.APPEND (MENU_SHELL => V_GAME_MENU,
                     CHILD      => V_EXIT);
    
    -- Sets the submenu
    --
    GTK.MENU_ITEM.SET_SUBMENU (V_GAME_MENU_ITEM, V_GAME_MENU);
    
    P_MENU_ITEM_HANDLER.CONNECT
       (V_NEW_GAME,
        "activate",
        P_NEW_GAME'ACCESS);

    P_MENU_ITEM_HANDLER.CONNECT
       (V_AUTO_START,
        "activate",
        P_START_BINGO'ACCESS);

    P_MENU_ITEM_HANDLER.CONNECT
       (V_PAUSE,
        "activate",
        P_PAUSE_BINGO'ACCESS);

     P_MENU_ITEM_HANDLER.CONNECT
       (V_CHECK_CARDS,
        "activate",
        P_CHECK_CARDS'ACCESS);
     
     P_MENU_ITEM_HANDLER.CONNECT
       (V_EXIT,
        "activate",
        P_EXIT_BINGO'ACCESS);

     P_MENU_ITEM_HANDLER.CONNECT
       (V_HELP,
        "activate",
        P_HELP_BINGO'ACCESS);

  end P_CREATE_GAME_MENU;
  
  --==================================================================
  
  procedure P_CREATE_MENU_BAR
     (V_MENU_BAR : out GTK.MENU_BAR.GTK_MENU_BAR) is
    
    V_GAME_MENU_ITEM : GTK.MENU_ITEM.GTK_MENU_ITEM;
    
  begin
    
    P_CREATE_GAME_MENU (V_GAME_MENU_ITEM => V_GAME_MENU_ITEM);
    
    -- It creates the menu bar which contains all the menus.
    --
    GTK.MENU_BAR.GTK_NEW (V_MENU_BAR);
    
    GTK.MENU_BAR.ADD (V_MENU_BAR, V_GAME_MENU_ITEM);
    
  end P_CREATE_MENU_BAR;
  
  --==================================================================
  
  --[
  -- This is the main gtkada procedure.
  -- It initialise the bingo's bombo and the GTKAda HMI.
  --]
  procedure P_CREATE_WIDGETS is
    
    V_UPPER_AREA : GTK.BOX.GTK_BOX;
    
    V_NUMBERS_BOX : GTK.BOX.GTK_BOX;
    
    V_MAIN_WINDOW : GTK.WINDOW.GTK_WINDOW;
  
    V_MENU_BAR : GTK.MENU_BAR.GTK_MENU_BAR;
       
  begin
    
    -- Initialise bombo numbers.
    --
    Q_BINGO.Q_BOMBO.P_INIT;
    
    P_CREATE_UPPER_AREA (V_UPPER_AREA => V_UPPER_AREA);
    
    P_CREATE_NUMBERS (V_NUMBERS_BOX => V_NUMBERS_BOX);
    
    P_CREATE_MENU_BAR (V_MENU_BAR => V_MENU_BAR);
    
    P_CREATE_MAIN_WINDOW (V_MENU_BAR    => V_MENU_BAR,      
                          V_UPPER_AREA  => V_UPPER_AREA,
                          V_NUMBERS_BOX => V_NUMBERS_BOX,
                          V_MAIN_WINDOW => V_MAIN_WINDOW);
    
    Q_MAIN_WINDOW_HANDLER.CONNECT
       (V_MAIN_WINDOW,
        "key_press_event",
        Q_MAIN_WINDOW_HANDLER.TO_MARSHALLER 
           (F_MAIN_WINDOW_BUTTON_PRESS'ACCESS));
    
    V_MAIN_WINDOW.ON_DESTROY (P_MAIN_QUIT'ACCESS);
    
    V_MAIN_WINDOW.MAXIMIZE;
    
    V_MAIN_WINDOW.SHOW_ALL;

  end P_CREATE_WIDGETS;
  
  --==================================================================
  
end Q_BINGADA;
