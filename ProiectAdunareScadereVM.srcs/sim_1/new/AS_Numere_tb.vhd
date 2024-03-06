----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/19/2023 12:09:31 AM
-- Design Name: 
-- Module Name: AS_Numere_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AS_NumereVM_tb is
--  Port ( );
end AS_NumereVM_tb;

architecture Behavioral of AS_NumereVM_tb is
      signal Clk :  std_logic;
      signal Rst :  std_logic;
      signal Start :  std_logic;
      signal Term :std_logic:='0';
      signal A : STD_LOGIC_VECTOR (31 downto 0);
      signal B:  STD_LOGIC_VECTOR (31 downto 0);
      signal A_S: std_logic;
      signal dep: std_logic_vector(1 downto 0);
      signal S :  STD_LOGIC_VECTOR (31 downto 0);
      CONSTANT CLK_PERIOD : TIME := 10 ns;
      
      type vecType is array(0 to 16) of std_logic_vector(31 downto 0);
      signal vecT1: vecType:=(x"3F333333",x"3E4CCCCC",x"3D999999",x"3E4CCCCC",x"3FC00000",x"40980000",x"40980000",x"3F400000",
                                x"3F400000",x"43E16000",x"4480C666",x"C57C9800",x"BF400000",x"3FC00000",x"3D999999",x"7F800000",x"00400000");
      signal vecT2: vecType:=(x"3F000000",x"3F000000",x"3E000000",x"3D999999",x"40500000",x"40500000",x"3F400000",x"3F400000",
                                x"3F400000",x"43962000",x"457C9800",x"459E7D99",x"3FC00000",x"C0980000",x"BE000000",x"7F800000",x"00000000");
         
      signal RezCorect:vecType:=(x"3E4CCCCC",x"3F333333",x"3E4CCCCC",x"3E000000",x"40980000",x"3FC00000",x"40800000",x"3FC00000",
                                x"00000000",x"43168000",x"459E7D99",x"4480C666",x"3F400000",x"C0500000",x"3E4CCCCC","--------------------------------","--------------------------------");
      
      signal as_vec: std_logic_vector(0 to 16) :=('1','0','0','1','0','1','1','0',
                                                  '1','1','0','0','0','0','1','0','1');
                 
      
begin
  
    DUT : ENTITY WORK.main  port map (A=>A,B=>B,A_S=>A_S,Rst=>Rst,Start=>Start,Clk=>Clk,Dep=>dep,S=>S);
    generare_clk : PROCESS
     BEGIN
         Clk <= '0';
         WAIT FOR (CLK_PERIOD/2);
         Clk <= '1';
         WAIT FOR (CLK_PERIOD/2);
     END PROCESS generare_clk;
     
    generare_vect_test : PROCESS
        VARIABLE NrErori : INTEGER := 0;
       
        VARIABLE Rez : std_logic_vector(31 downto 0):=x"00000000";
        begin
            FOR i IN 0 TO 16 LOOP
                Rst<='0';
                Start<='1';
                A<= vecT1(i);
                B<= vecT2(i);
                A_S<=as_vec(i);
                       
                Rez:=RezCorect(i);
               
                WAIT FOR CLK_PERIOD;
                Start<='0';
         
                WAIT FOR 200 ns;           
                IF Rez/=S THEN
                    REPORT "Iesire corecta-> " & INTEGER'image(to_integer(unsigned(Rez))) &
                        " Iesire obtinuta-> " & INTEGER'image(to_integer(unsigned( S ))) &
                        " Timpul simularii->" & TIME'image(now);
                    NrErori := NrErori + 1;
                END IF;
              
               wait for CLK_PERIOD;               
                
            END LOOP;
        
            IF NrErori = 0 THEN
                REPORT "Simularea s-a terminat cu succes";
            ELSE
                REPORT "Simularea s-a terminat cu " & INTEGER'image(NrErori) & " erori";
            END IF;           
              
    end process;
end Behavioral;