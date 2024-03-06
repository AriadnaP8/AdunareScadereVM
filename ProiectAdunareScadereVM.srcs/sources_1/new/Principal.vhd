----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2023 11:43:58 PM
-- Design Name: 
-- Module Name: Principal - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity principal is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end entity;

architecture Behavioral of principal is

component MPG 
    Port ( en : out STD_LOGIC;
           input : in STD_LOGIC;
           clk : in STD_LOGIC);
end component;

component SSD 
Port(digit:in std_logic_vector(15 downto 0);
    clk:in std_logic;
    an: out std_logic_vector(3 downto 0);
    cat:out std_logic_vector(6 downto 0));
end component;

component main is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           A_S:in std_logic;
           Rst:in std_logic;
           clk:in std_logic;
           Start: in std_logic;
           dep:out std_logic_vector(1 downto 0);
           S : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal Rst,A_S,Start:std_logic;
signal dep:std_logic_vector(1 downto 0);
signal afis:std_logic_vector(15 downto 0);
signal iesire,A,B,Rez: std_logic_vector(31 downto 0);

begin
     Afisor:SSD port map(afis,clk,an,cat);
     WEN: MPG port map(Rst,btn(0),clk);
     P:main port map(A,B,A_S,Rst,clk,sw(15),dep,Rez);
       
     A <= x"40f00000"; -- +7.5
     -- A <= x"c0f00000"; -- -7.5
     B <= x"3fa66666"; -- +1.3
     -- B <= x"bfa66666"; -- -1.3
     A_S<=sw(3);
     
     MUX1:process(sw(1 downto 0))
          begin 
           case sw(1 downto 0) is
               when "00"=> iesire <= A;         --a
               when "01"=> iesire <= B;         --b
               when "10"=> iesire <= Rez;
               when others=> iesire <= "00000000000000000000000000000000";
           end case;
     end process;
     
     MUX2:process(sw(2))
          begin 
             case sw(2) is
                  when '0' => afis <= iesire(31 downto 16);
                  when others => afis <= iesire(15  downto 0);
             end case;
     end process;
     
     
end Behavioral;