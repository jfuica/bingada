--*****************************************************************************
--*
--* PROJECT:            BINGADA    
--*
--* FILE:               q_bingo.adb
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************

with Q_GEN_SHUFFLE;

-- Sound library
--
with CANBERRA;

package body Q_BINGO.Q_BOMBO is
  
  --==================================================================
  
  V_INDEX : T_NUMBER;
  
  --==================================================================
   
  package Q_SHUFFLE is new Q_GEN_SHUFFLE
     (ELEMENT_TYPE => T_NUMBER,
      C_MAX_NUMBER => T_NUMBER'LAST);
   
  V_BINGO_ARRAY : Q_SHUFFLE.ARRAY_TYPE;

  V_CONTEXT : CANBERRA.CONTEXT := CANBERRA.CREATE
     (NAME => "BingAda",
      ID   => "bingada.lovelace",
      ICON => "applications-games");

  --==================================================================
   
  procedure P_INIT is
    
  begin
    
    for I in 1 .. T_NUMBER'LAST loop
      
      V_BINGO_ARRAY (I) := I;
      
    end loop;
    
    Q_SHUFFLE.P_SHUFFLE (LIST => V_BINGO_ARRAY);
    
    V_INDEX := 1;

  end P_INIT;
  
  --==================================================================

  procedure P_SPIN (V_NUMBER        : out POSITIVE;
                    V_CURRENT_INDEX : out T_NUMBER;
                    V_LAST_NUMBER   : out BOOLEAN) is
     
    V_SOUND : CANBERRA.SOUND;
    
  begin
    
    if V_INDEX = T_NUMBER'LAST then
      
      V_NUMBER := V_BINGO_ARRAY (T_NUMBER'LAST);
      
      V_LAST_NUMBER := TRUE;
      
      V_CURRENT_INDEX := V_INDEX;
      
    else
    
      V_NUMBER := V_BINGO_ARRAY (V_INDEX);
      
      V_INDEX := V_INDEX + 1;
      
      V_LAST_NUMBER := FALSE;
      
      V_CURRENT_INDEX := V_INDEX;
      
    end if;
    
    V_CONTEXT.PLAY ("bell-window-system", V_SOUND, CANBERRA.MUSIC, "Spin");
   
  end P_SPIN;
  
  --==================================================================
  
  function F_GET_NUMBER (V_INDEX : T_NUMBER) return T_NUMBER is
    
  begin
    
    return V_BINGO_ARRAY (V_INDEX);
    
  end F_GET_NUMBER;
  
  --==================================================================
  
  function F_GET_CURRENT_INDEX return T_NUMBER is
    
  begin
    
    return V_INDEX;
    
  end F_GET_CURRENT_INDEX;
  
  --==================================================================

end Q_BINGO.Q_BOMBO;
