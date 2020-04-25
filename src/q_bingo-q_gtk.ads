--*****************************************************************************
--*
--* PROJECT:            BINGADA
--*
--* FILE:               q_bingo-q_gtk.ads
--*
--* AUTHOR:             Javier Fuica Fernadez
--*
--*****************************************************************************

package Q_BINGO.Q_GTK is
  
  procedure P_CREATE_WIDGETS
     (V_INIT_BINGO           : access procedure;
      V_READ_CARDS_FROM_FILE : access procedure;
      V_CHECK_BINGO          : access procedure);
  
end Q_BINGO.Q_GTK;
