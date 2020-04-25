with Ada.Numerics.Discrete_Random;

package body Q_GEN_SHUFFLE is
  
  
  procedure P_Shuffle (List : in out Array_Type) is
    
    package Discrete_Random is new Ada.Numerics.DISCRETE_RANDOM
       (Result_Subtype => POSITIVE);
    
    use Discrete_Random;
    
    K : POSITIVE;
    G : Generator;
    T : Element_Type;
  begin
    Reset (G);
    for I in reverse List'Range loop
      K := (Random(G) mod I) + 1;
      T := List(I);
      List(I) := List(K);
      List(K) := T;
    end loop;
  end P_Shuffle;
  
end Q_GEN_SHUFFLE;

