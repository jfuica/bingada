--*****************************************************************************
--*
--* PROJECT:            BINGADA
--*
--* FILE:               q_bingo-q_bombo.ads
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************

package Q_BINGO.Q_BOMBO is
  
  procedure P_INIT;
  
  procedure P_SPIN (V_NUMBER        : out POSITIVE;
                    V_CURRENT_INDEX : out T_NUMBER;
                    V_LAST_NUMBER   : out BOOLEAN);
  
  function F_GET_NUMBER (V_INDEX : T_NUMBER) return T_NUMBER;
  
  function F_GET_CURRENT_INDEX return T_NUMBER;
  
end Q_BINGO.Q_BOMBO;
