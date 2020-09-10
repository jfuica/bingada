--*****************************************************************************
--*
--* PROJECT:            BingAda
--*
--* FILE:               q_csv-q_read_file.adb
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************

with ADA.EXCEPTIONS;

with TEXT_IO;

package body Q_CSV.Q_READ_FILE is

  --==================================================================

  V_FILE : TEXT_IO.FILE_TYPE;

  --==================================================================

  procedure P_READ_CARDS_IN_VECTOR (V_FILE  : TEXT_IO.FILE_TYPE;
                                    V_CARDS : in out Q_BINGO_CARDS.VECTOR) is

    V_ROW : T_ROW := F_LINE (TEXT_IO.GET_LINE (V_FILE));

    V_FIRST_COL : BOOLEAN;

    V_NUMBERS : T_NUMBERS;

    V_INDEX : POSITIVE := 1;

    V_CARD_NAME : T_NAME;

  begin

    V_FIRST_COL := V_ROW.F_NEXT;

    V_CARD_NAME := V_ROW.F_ITEM (T_NAME'RANGE);

    while V_ROW.F_NEXT loop

      V_NUMBERS (V_INDEX) := Q_BINGO.T_NUMBER'VALUE (V_ROW.F_ITEM);

      V_INDEX := V_INDEX + 1;

    end loop;

    V_CARDS.APPEND ((R_NAME    => V_CARD_NAME,
                     R_NUMBERS => V_NUMBERS));

  end P_READ_CARDS_IN_VECTOR;

  --==================================================================

  procedure P_READ_BINGO_CARDS
     (V_FILE_NAME : STRING;
      V_CARDS     : out Q_BINGO_CARDS.VECTOR) is

  begin

    TEXT_IO.OPEN (FILE => V_FILE,
                  MODE => TEXT_IO.IN_FILE,
                  NAME => V_FILE_NAME);

    if TEXT_IO.IS_OPEN (V_FILE) then

      -- skip header
      --
      TEXT_IO.SKIP_LINE (V_FILE);

      while not TEXT_IO.END_OF_FILE (V_FILE) loop

        P_READ_CARDS_IN_VECTOR (V_FILE  => V_FILE,
                                V_CARDS => V_CARDS);
      end loop;

    end if;

    TEXT_IO.CLOSE (V_FILE);

  exception

    when V_EXCEPTION : others =>

      -- No exception is raised because if the csv file is not correctly read
      -- the bingada can continue without cards to check.
      --
      TEXT_IO.CLOSE (V_FILE);

      TEXT_IO.PUT_LINE
         ("exception : " & ADA.EXCEPTIONS.EXCEPTION_INFORMATION (V_EXCEPTION));

  end P_READ_BINGO_CARDS;

  --==================================================================

end Q_CSV.Q_READ_FILE;
