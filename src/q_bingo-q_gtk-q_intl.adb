--*****************************************************************************
--*
--* PROJECT:            Bingada
--*
--* FILE:               q_bingo-q_gtk-q_intl.adb
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************

with GTKADA.INTL;

with TEXT_IO;

package body Q_BINGO.Q_GTK.Q_INTL is
  
  --==================================================================
  --C_PATH : CONSTANT STRING := "/usr/local/share/locale";
  
  procedure P_INITIALISE is
    
  begin
    
    if GTKADA.INTL.GETLOCALE = "C" then
      
      GTKADA.INTL.SETLOCALE 
         (CATEGORY => GTKADA.INTL.LC_MESSAGES,LOCALE => "en_GB");
      
      TEXT_IO.PUT_LINE ("DEFAULT LOCALE changed to : " & GTKADA.INTL.GETLOCALE);
      
    else
      
      GTKADA.INTL.SETLOCALE;

    end if;
    
    GTKADA.INTL.BIND_TEXT_DOMAIN 
       (DOMAIN  => "bingada",
        DIRNAME => "./messages");
    
    GTKADA.INTL.TEXT_DOMAIN ("bingada");
    
  end P_INITIALISE;
  
  --==================================================================
  

end Q_BINGO.Q_GTK.Q_INTL;
