--*****************************************************************************
--*
--* PROJECT:            BingAda
--*
--* FILE:               q_csv-q_read_file.ads
--*
--* AUTHOR:             Javier Fuica Fernandez
--*
--*****************************************************************************

with ADA.CONTAINERS.VECTORS;

with Q_BINGO;

package Q_CSV.Q_READ_FILE is
  
  C_MAX_CARD_NAME : constant := 5;
  
  subtype T_NAME is STRING (1 .. C_MAX_CARD_NAME);
  
  C_NUMBERS_IN_A_CARD : constant := 15;
  
  type T_NUMBERS is array (1 .. C_NUMBERS_IN_A_CARD) of Q_BINGO.T_NUMBER;
  
  type T_CARD is
    record
      R_NAME    : T_NAME;
      R_NUMBERS : T_NUMBERS;
    end record;
  
  package Q_BINGO_CARDS is new ADA.CONTAINERS.VECTORS
     (Index_Type   => NATURAL, 
      Element_Type => T_CARD);
  
  procedure P_READ_BINGO_CARDS
     (V_FILE_NAME : STRING;
      V_CARDS     : out Q_BINGO_CARDS.VECTOR);
  
end Q_CSV.Q_READ_FILE;
