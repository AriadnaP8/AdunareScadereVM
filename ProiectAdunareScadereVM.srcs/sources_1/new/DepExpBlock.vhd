----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2023 11:37:49 PM
-- Design Name: 
-- Module Name: DepExpBlock - Behavioral
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

entity DepExpBlock is
    Port ( Exp : in STD_LOGIC_VECTOR (7 downto 0);
           Enable : in STD_LOGIC;
           M : in STD_LOGIC_VECTOR (22 downto 0);
           DepSup: out std_logic;
           p:in std_logic;
           ExpOut : out STD_LOGIC_VECTOR (7 downto 0);
           MOut : out STD_LOGIC_VECTOR (22 downto 0));
end DepExpBlock;

architecture Behavioral of DepExpBlock is
signal Mout_aux:STD_LOGIC_VECTOR (22 downto 0):=M;
signal ExpOut_aux:STD_LOGIC_VECTOR (7 downto 0):=Exp;

begin
    
    process(Enable,M,Exp)
    begin
        if Enable='1' then
            if Exp="11111111" then 
                DepSup<='1';
            else
                DepSup<='0';
                ExpOut_aux<=Exp+'1';
                Mout_aux<= p & M(22 downto 1);
            end if;
        else DepSup<='0';MOut_aux<=M;ExpOut_aux<=Exp;
        end if;
    end process;
    
   Mout<=MOut_aux;
   ExpOut<=ExpOut_aux;

end Behavioral;

