--*****************************************************************************
--*
--* PROJECT:            BingAda
--*
--* FILE:               q_csv-q_read_file.ads
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************

with Ada.Containers.Vectors;

with Q_Bingo;

package Q_Csv.Q_Read_File is

  C_Max_Card_Name : constant := 5;

  subtype T_Name is String (1 .. C_Max_Card_Name);

  C_Numbers_In_A_Card : constant := 15;

  type T_Numbers is array (1 .. C_Numbers_In_A_Card) of Q_Bingo.T_Number;

  type T_Card is
    record
      R_Name    : T_Name;
      R_Numbers : T_Numbers;
    end record;

  package Q_Bingo_Cards is new Ada.Containers.Vectors
     (Index_Type   => Natural,
      Element_Type => T_Card);

  procedure P_Read_Bingo_Cards
     (V_File_Name : String;
      V_Cards     : out Q_Bingo_Cards.Vector);

end Q_Csv.Q_Read_File;
