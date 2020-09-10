with Ada.Numerics.Discrete_Random;

package body Q_Gen_Shuffle is


  procedure P_Shuffle (List : in out Array_Type) is

    package Discrete_Random is new Ada.Numerics.Discrete_Random
       (Result_Subtype => Positive);

    use Discrete_Random;

    K : Positive;
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

end Q_Gen_Shuffle;
