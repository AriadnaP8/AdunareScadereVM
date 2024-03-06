----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2023 11:38:31 PM
-- Design Name: 
-- Module Name: FractionAdd - Behavioral
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

entity FractionAdd is
    Port ( A : in STD_LOGIC_VECTOR (22 downto 0);
           B : in STD_LOGIC_VECTOR (22 downto 0);
           A_S : in STD_LOGIC;
           Comp: in std_logic_vector(1 downto 0);
           p:out std_logic;
           Cout : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (22 downto 0));
end FractionAdd;

architecture Behavioral of FractionAdd is
component SumatorElementar is
    Port ( Tin : in STD_LOGIC;
           Yi : in STD_LOGIC;
           Xi : in STD_LOGIC;
           tout : out STD_LOGIC;
           S : out STD_LOGIC);
end component;
signal B1,aux,S_aux: STD_LOGIC_VECTOR (22 downto 0);
signal n1,n2,depNorm,norm ,n1Aux:std_logic:='0';

begin
    n1aux<='1' when Comp/="01" else '0';
    n2<='1' when Comp/="00" else '0';

    comp1: for i in 0 to 22 generate 
        B1(i)<=B(i) xor A_S;
        n1<=n1Aux xor A_S;
        sumator_0: if i=0 generate
                  sumator_0comp: SumatorElementar port map(Tin=>A_S,Yi=>B1(i),Xi=>A(i),tout=>aux(i),S=>S_aux(i));
                  end generate;
        sumator_i: if (i>0 and i<23) generate
                  sumator_icomp: SumatorElementar port map(Tin=>aux(i-1),Yi=>B1(i),Xi=>A(i),tout=>aux(i),S=>S_aux(i));
                end generate;
    end generate;
    
    comp23:for i in 23 to 23 generate
        sumator_23comp: SumatorElementar port map(Tin=>aux(22),Yi=>n1,Xi=>n2,tout=>depNorm,S=>norm);
    end generate;
            
    p<=norm;   
    S<=S_aux;
    Cout<=depNorm;
    
end Behavioral;
