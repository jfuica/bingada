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

package Q_CSV is

   type T_ROW (<>) is tagged private;

   function F_LINE (V_LINE      : STRING;
                    V_SEPARATOR : CHARACTER := ';') return T_ROW;

   function F_NEXT (V_ROW: in out T_ROW) return BOOLEAN;

     -- if there is still an item in R, Next advances to it and returns True
   function F_ITEM (V_ROW: T_ROW) return STRING;
     -- after calling R.Next i times, this returns the i'th item (if any)

private

  type T_ROW (V_LENGTH : NATURAL) is tagged record
    R_STR   : STRING (1 .. V_LENGTH);
    R_FIRST : POSITIVE;
    R_LAST  : NATURAL;
    R_NEXT  : POSITIVE;
    R_SEP  : CHARACTER;
  end record;

end Q_CSV;
