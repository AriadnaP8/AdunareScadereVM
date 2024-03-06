----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2023 11:37:05 PM
-- Design Name: 
-- Module Name: CountLeadingZero - Behavioral
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

entity CountLeadingZeroes is
   Port (M:in std_logic_vector(22 downto 0);
         ZCount:out std_logic_vector(4 downto 0) );
end CountLeadingZeroes;

architecture Behavioral of CountLeadingZeroes is
    signal ZeroVector:std_logic_vector(22 downto 0);
    signal aux:std_logic_vector(7 downto 0);
begin
    ZeroVector<="00000000000000000000000";
    
    aux <= X"17" when M(22 downto 0)=ZeroVector(22 downto 0) else
        X"16" when M(22 downto 1)=ZeroVector(22 downto 1) else
        X"15" when M(22 downto 2)=ZeroVector(22 downto 2) else
        X"14" when M(22 downto 3)=ZeroVector(22 downto 3) else
        X"13" when M(22 downto 4)=ZeroVector(22 downto 4) else
        X"12" when M(22 downto 5)=ZeroVector(22 downto 5) else
        X"11" when M(22 downto 6)=ZeroVector(22 downto 6) else
        X"10" when M(22 downto 7)=ZeroVector(22 downto 7) else
        X"0F" when M(22 downto 8)=ZeroVector(22 downto 8) else
        X"0E" when M(22 downto 9)=ZeroVector(22 downto 9) else
        X"0D" when M(22 downto 10)=ZeroVector(22 downto 10) else
        X"0C" when M(22 downto 11)=ZeroVector(22 downto 11) else
        X"0B" when M(22 downto 12)=ZeroVector(22 downto 12) else
        X"0A" when M(22 downto 13)=ZeroVector(22 downto 13) else
        X"09" when M(22 downto 14)=ZeroVector(22 downto 14) else
        X"08" when M(22 downto 15)=ZeroVector(22 downto 15) else
        X"07" when M(22 downto 16)=ZeroVector(22 downto 16) else
        X"06" when M(22 downto 17)=ZeroVector(22 downto 17) else
        X"05" when M(22 downto 18)=ZeroVector(22 downto 18) else
        X"04" when M(22 downto 19)=ZeroVector(22 downto 19) else
        X"03" when M(22 downto 20)=ZeroVector(22 downto 20) else
        X"02" when M(22 downto 21)=ZeroVector(22 downto 21) else
        X"01" when M(22 downto 22)=ZeroVector(22 downto 22) else
        X"00";
        
        ZCount<=aux(4 downto 0);
        
end Behavioral;
