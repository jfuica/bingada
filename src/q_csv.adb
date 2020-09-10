package body Q_Csv is

  --==================================================================

  function F_Line (V_Line      : String;
                   V_Separator : Character := ';') return T_Row is

    (V_Length => V_Line'Length,
     R_Str    => V_Line,
     R_First  => V_Line'First,
     R_Last   => V_Line'Last,
     R_Next   => V_Line'First,
     R_Sep    => V_Separator);

  function F_Item (V_Row : T_Row) return String is
    (V_Row.R_Str (V_Row.R_First .. V_Row.R_Last));

  function F_Next (V_Row : in out T_Row) return Boolean is

    V_Last : Natural := V_Row.R_Next;

  begin

    V_Row.R_First := V_Row.R_Next;

    while V_Last <= V_Row.R_Str'Last and then
       V_Row.R_Str (V_Last) /= V_Row.R_Sep loop

      -- find Separator

      V_Last := V_Last + 1;

    end loop;

    V_Row.R_Last := V_Last - 1;

    V_Row.R_Next := V_Last + 1;

    return (V_Row.R_First <= V_Row.R_Str'Last);

  end F_Next;

  --==================================================================

end Q_Csv;
