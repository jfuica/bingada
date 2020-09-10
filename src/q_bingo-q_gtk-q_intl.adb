--*****************************************************************************
--*
--* PROJECT:            Bingada
--*
--* FILE:               q_bingo-q_gtk-q_intl.adb
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************

with Gtkada.Intl;

with Text_Io;

package body Q_Bingo.Q_Gtk.Q_Intl is

  --==================================================================
  --C_PATH : CONSTANT STRING := "/usr/local/share/locale";

  procedure P_Initialise is

  begin

    if Gtkada.Intl.Getlocale = "C" then

      Gtkada.Intl.Setlocale
         (Category => Gtkada.Intl.Lc_Messages,Locale => "en_GB");

      Text_Io.Put_Line ("DEFAULT LOCALE changed to : " & Gtkada.Intl.Getlocale);

    else

      Gtkada.Intl.Setlocale;

    end if;

    Gtkada.Intl.Bind_Text_Domain
       (Domain  => "bingada",
        Dirname => "./messages");

    Gtkada.Intl.Text_Domain ("bingada");

  end P_Initialise;

  --==================================================================


end Q_Bingo.Q_Gtk.Q_Intl;
