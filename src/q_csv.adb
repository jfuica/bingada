package body Q_CSV is
  
  --==================================================================
  
  function F_LINE (V_LINE      : String; 
                   V_SEPARATOR : Character := ';') return T_ROW is
    
    (V_LENGTH => V_LINE'LENGTH,
     R_STR    => V_LINE,
     R_FIRST  => V_LINE'FIRST,
     R_LAST   => V_LINE'LAST, 
     R_NEXT   => V_LINE'FIRST, 
     R_SEP    => V_SEPARATOR);
 
  function F_ITEM (V_ROW : T_ROW) return STRING is 
    (V_ROW.R_STR (V_ROW.R_FIRST .. V_ROW.R_LAST));
 
  function F_NEXT (V_ROW : in out T_ROW) return BOOLEAN is
    
    V_LAST : NATURAL := V_ROW.R_NEXT;
    
  begin
    
    V_ROW.R_FIRST := V_ROW.R_NEXT;
    
    while V_LAST <= V_ROW.R_STR'LAST and then 
       V_ROW.R_STR (V_Last) /= V_ROW.R_SEP loop 
      
      -- find Separator
      
      V_LAST := V_LAST + 1;
      
    end loop;
    
    V_ROW.R_LAST := V_LAST - 1;
    
    V_ROW.R_NEXT := V_LAST + 1;
    
    return (V_ROW.R_FIRST <= V_ROW.R_STR'LAST);
    
  end F_NEXT;
   
  --==================================================================
   
end Q_CSV;
