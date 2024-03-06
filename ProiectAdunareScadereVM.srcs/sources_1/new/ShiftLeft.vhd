----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2023 11:39:54 PM
-- Design Name: 
-- Module Name: ShiftLeft - Behavioral
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

entity ShiftLeft is
    Port ( inp : in STD_LOGIC_VECTOR (22 downto 0);
           shift1 : in STD_LOGIC_VECTOR (4 downto 0);
           normEnable:in std_logic;
           outp : out STD_LOGIC_VECTOR (22 downto 0));
end ShiftLeft;

architecture Behavioral of ShiftLeft is
signal outp_aux:std_logic_vector(22 downto 0):="00000000000000000000000";

begin
    process(normEnable,inp)
    begin
        if normEnable='1' then
            case shift1 is
                  when "00000" => outp_aux<= inp(22 downto 0);
                  when "00001" => outp_aux<= inp(21 downto 0) & '0';
                  when "00010" => outp_aux<= inp(20 downto 0) & "00";
                  when "00011" => outp_aux<= inp(19 downto 0) & "000";
                  when "00100" => outp_aux<= inp(18 downto 0) & "0000"; 
                  when "00101" => outp_aux<= inp(17 downto 0) & "00000";
                  when "00110" => outp_aux<= inp(16 downto 0) & "000000";
                  when "00111" => outp_aux<= inp(15 downto 0) & "0000000";
                  when "01000" => outp_aux<= inp(14 downto 0) & "00000000";
                  when "01001" => outp_aux<= inp(13 downto 0) & "000000000";
                  when "01010" => outp_aux<= inp(12 downto 0) & "0000000000";
                  when "01011" => outp_aux<= inp(11 downto 0) & "00000000000";
                  when "01100" => outp_aux<= inp(10 downto 0) & "000000000000";
                  when "01101" => outp_aux<= inp(9 downto 0) & "0000000000000"; 
                  when "01110" => outp_aux<= inp(8 downto 0) & "00000000000000";
                  when "01111" => outp_aux<= inp(7 downto 0) & "000000000000000";
                  when "10000" => outp_aux<= inp(6 downto 0) & "0000000000000000";
                  when "10001" => outp_aux<=inp(5 downto 0) & "00000000000000000";
                  when "10010" => outp_aux<=inp(4 downto 0) & "000000000000000000";
                  when "10011" => outp_aux<=inp(3 downto 0) & "0000000000000000000";
                  when "10100" => outp_aux<=inp(2 downto 0) & "00000000000000000000";
                  when "10101" => outp_aux<=inp(1 downto 0) & "000000000000000000000";
                  when "10110" => outp_aux<=inp(0) & "0000000000000000000000";
                  when others =>  outp_aux<="00000000000000000000000";
                  end case;
        else 
            outp_aux<=inp;
        end if;
    end process;
 
    outp <= outp_aux;
        
    
end Behavioral;

