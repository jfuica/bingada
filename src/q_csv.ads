--*****************************************************************************
--*
--* PROJECT:            BingAda
--*
--* FILE:               q_csv.ads
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--* NOTES: This code was taken from Rosetta Code and modifyied to fix
--  BingAda needs and Style Guide.
--*
--*****************************************************************************

package Q_Csv is

   type T_Row (<>) is tagged private;

   function F_Line (V_Line      : String;
                    V_Separator : Character := ';') return T_Row;

   function F_Next (V_Row: in out T_Row) return Boolean;

     -- if there is still an item in R, Next advances to it and returns True
   function F_Item (V_Row: T_Row) return String;
     -- after calling R.Next i times, this returns the i'th item (if any)

private

  type T_Row (V_Length : Natural) is tagged record
    R_Str   : String (1 .. V_Length);
    R_First : Positive;
    R_Last  : Natural;
    R_Next  : Positive;
    R_Sep  : Character;
  end record;

end Q_Csv;
