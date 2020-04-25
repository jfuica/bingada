generic
  type Element_Type is private;
  C_MAX_NUMBER : POSITIVE;
   
package Q_GEN_SHUFFLE is
  
  type Array_Type is array (Positive range 1 .. C_MAX_NUMBER) of Element_Type;
  
  procedure P_Shuffle (List : in out Array_Type);
  
end Q_GEN_SHUFFLE;
