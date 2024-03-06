----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2023 11:40:46 PM
-- Design Name: 
-- Module Name: ShiftRight - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ShiftRight is
    Port ( inp : in STD_LOGIC_VECTOR (22 downto 0);
           shift1 : in STD_LOGIC_VECTOR (4 downto 0);
           shiftEnable:in std_logic;
           outp : out STD_LOGIC_VECTOR (22 downto 0));
end ShiftRight;

architecture Behavioral of ShiftRight is

signal s5:std_logic_vector(22 downto 0):=inp;
signal shift:STD_LOGIC_VECTOR (4 downto 0):="00000";
begin
    process(shiftEnable,shift1)
    begin
    if shiftEnable='1' then
        shift<=shift1;
    else
        shift<="00000";
    end if;
    end process;
   
   process(shift,inp)
   begin
       case shift is
       when "00000" => s5<= inp(22 downto 0);
       when "00001" => s5<='1' & inp(22 downto 1);
       when "00010" => s5<="01" & inp(22 downto 2);
       when "00011" => s5<="001" & inp(22 downto 3); 
       when "00100" => s5<="0001" & inp(22 downto 4);
       when "00101" => s5<="00001" & inp(22 downto 5);
       when "00110" => s5<="000001" & inp(22 downto 6);
       when "00111" => s5<="0000001" & inp(22 downto 7);
       when "01000" => s5<="00000001" & inp(22 downto 8); 
       when "01001" => s5<="000000001" & inp(22 downto 9);
       when "01010" => s5<="0000000001" & inp(22 downto 10);
       when "01011" => s5<="00000000001" & inp(22 downto 11);
       when "01100" => s5<="000000000001" & inp(22 downto 12);
       when "01101" => s5<="0000000000001" & inp(22 downto 13); 
       when "01110" => s5<="00000000000001" & inp(22 downto 14);
       when "01111" => s5<="000000000000001" & inp(22 downto 15);
       when "10000" => s5<="0000000000000001" & inp(22 downto 16);
       when "10001" => s5<="00000000000000001" & inp(22 downto 17);
       when "10010" => s5<="000000000000000001" & inp(22 downto 18); 
       when "10011" => s5<="0000000000000000001" & inp(22 downto 19);
       when "10100" => s5<="00000000000000000001" & inp(22 downto 20);
       when "10101" => s5<="000000000000000000001" & inp(22 downto 21);
       when "10110" => s5<="0000000000000000000001" & inp(22);
       when others =>  s5<="00000000000000000000001";
       end case;
   end process;
    
   outp <= s5;
        
    
end Behavioral;