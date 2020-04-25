--*****************************************************************************
--*
--* PROJECT:            BINGADA
--*
--* FILE:               q_bingo-q_gtk.adb
--*
--* AUTHOR:             Javier Fuica Fernadez
--*
--*****************************************************************************

with TEXT_IO;

with ADA.STRINGS.FIXED;
with ADA.CONTAINERS;


with GLIB.MAIN;

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
with Q_BINGO_HELP;

package body Q_BINGO.Q_GTK is
  
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
    
    --GTK.MENU_ITEM.GTK_NEW_WITH_MNEMONIC (V_GAME_MENU, "_Game");
    
    -- Creates the menu called game
    --
    GTK.MENU.GTK_NEW (V_GAME_MENU);
    
    --V_GAME_MENU.SET_TITLE ("Game");
    
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
  
  procedure P_CREATE_WIDGETS
     (V_INIT_BINGO           : access procedure;
      V_READ_CARDS_FROM_FILE : access procedure;
      V_CHECK_BINGO          : access procedure) is
    
    V_UPPER_AREA : GTK.BOX.GTK_BOX;
    
    V_NUMBERS_BOX : GTK.BOX.GTK_BOX;
    
    V_MAIN_WINDOW : GTK.WINDOW.GTK_WINDOW;
  
    V_MENU_BAR : GTK.MENU_BAR.GTK_MENU_BAR;
       
  begin
    
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
  
end Q_BINGO.Q_GTK;
