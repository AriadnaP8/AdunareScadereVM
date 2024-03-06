----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2023 11:39:12 PM
-- Design Name: 
-- Module Name: SE - Behavioral
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

entity SumatorElementar is
    Port ( Tin : in STD_LOGIC;
           Yi : in STD_LOGIC;
           Xi : in STD_LOGIC;
           tout : out STD_LOGIC;
           S : out STD_LOGIC);
end SumatorElementar;

architecture Behavioral of SumatorElementar is
signal c_g,c_p :std_logic;

begin
    c_g<= Xi and Yi;
    c_p<= Xi xor Yi;
    S<= c_p xor Tin;
    Tout<= c_g or (c_p and Tin);
    
    
end Behavioral;
