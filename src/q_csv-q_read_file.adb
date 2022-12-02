--*****************************************************************************
--*
--* PROJECT:            BingAda
--*
--* FILE:               q_csv-q_read_file.adb
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************

with Ada.Exceptions;

with Text_Io;

package body Q_Csv.Q_Read_File is

  --==================================================================

  V_File : Text_Io.File_Type;

  --==================================================================

  procedure P_Read_Cards_In_Vector (V_File  : Text_Io.File_Type;
                                    V_Cards : in out Q_Bingo_Cards.Vector) is

    V_Row : T_Row := F_Line (Text_Io.Get_Line (V_File));

    V_Numbers : T_Numbers;

    V_Index : Positive := 1;

    V_Card_Name : T_Name;

  begin

    if not V_Row.F_Next then

      Text_Io.Put_Line
        ("Incorrect card format!");
    else

      V_Card_Name := V_Row.F_Item (T_Name'Range);

      while V_Row.F_Next loop

        V_Numbers (V_Index) := Q_Bingo.T_Number'Value (V_Row.F_Item);

        V_Index := V_Index + 1;

      end loop;

      V_Cards.Append ((R_Name    => V_Card_Name,
                       R_Numbers => V_Numbers));
    end if;

  end P_Read_Cards_In_Vector;

  --==================================================================

  procedure P_Read_Bingo_Cards
     (V_File_Name : String;
      V_Cards     : out Q_Bingo_Cards.Vector) is

  begin

    Text_Io.Open (File => V_File,
                  Mode => Text_Io.In_File,
                  Name => V_File_Name);

    if Text_Io.Is_Open (V_File) then

      -- skip header
      --
      Text_Io.Skip_Line (V_File);

      while not Text_Io.End_Of_File (V_File) loop

        P_Read_Cards_In_Vector (V_File  => V_File,
                                V_Cards => V_Cards);
      end loop;

    end if;

    Text_Io.Close (V_File);

  exception

    when V_Exception : others =>

      -- No exception is raised because if the csv file is not correctly read
      -- the bingada can continue without cards to check.
      --
      Text_Io.Close (V_File);

      Text_Io.Put_Line
         ("exception : " & Ada.Exceptions.Exception_Information (V_Exception));

  end P_Read_Bingo_Cards;

  --==================================================================

end Q_Csv.Q_Read_File;
