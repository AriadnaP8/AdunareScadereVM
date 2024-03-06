----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2023 11:35:32 PM
-- Design Name: 
-- Module Name: BlockNorm - Behavioral
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

entity BlockNorm is
    Port ( MS : in STD_LOGIC_VECTOR (22 downto 0);
           ES : in STD_LOGIC_VECTOR (7 downto 0);
           normEnable:in std_logic;
           M : out STD_LOGIC_VECTOR (22 downto 0);
           E : out STD_LOGIC_VECTOR (7 downto 0);
           DepInf:out std_logic);
end BlockNorm;

architecture Behavioral of BlockNorm is 


signal Zcount_aux: std_logic_vector(4 downto 0);
signal shift1: std_logic_vector(4 downto 0);

begin
    comp1:entity Work.CountLeadingZeroes port map (M => MS, Zcount => Zcount_aux);
    
    shift1<=(Zcount_aux + '1') when Zcount_aux<"10111" else "00000";
    
    comp2:entity WORK.ShiftLeft port map(inp => MS, shift1=>shift1,normEnable=>(normEnable ) ,outp =>M);
    
    DepInf<='1' when ES<shift1 else '0';
    E<=ES-shift1 when normEnable='1' else ES;
    

end Behavioral;
