generic
  type Element_Type is private;
  C_Max_Number : Positive;

package Q_Gen_Shuffle is

  type Array_Type is array (Positive range 1 .. C_Max_Number) of Element_Type;

  procedure P_Shuffle (List : in out Array_Type);

end Q_Gen_Shuffle;
