----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2023 11:41:17 PM
-- Design Name: 
-- Module Name: SignOut - Behavioral
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

entity SignOut is
    Port ( SemnA : in STD_LOGIC;
           SemnB : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (22 downto 0);
           B : in STD_LOGIC_VECTOR (22 downto 0);
           A_S : in STD_LOGIC;
           Comp : in STD_LOGIC_VECTOR(1 downto 0);
           AS : out STD_LOGIC;
           SO : out STD_LOGIC);
end SignOut;

architecture Behavioral of SignOut is
    signal SB_aux :std_logic;
    signal Aaux,Baux : std_logic_vector(22 downto 0);
begin
    SB_aux <= SemnB xor A_S;
    
    SO <=SemnA when Comp="00" else 
           SB_aux when Comp="01" else
           SemnA when (A<B) else
           SB_aux;
    AS<='1' when SemnA /=SB_aux else 
         '0';
    

end Behavioral;