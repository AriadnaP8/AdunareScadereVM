----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2023 11:41:51 PM
-- Design Name: 
-- Module Name: UC - Behavioral
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

entity UC is
    Port ( comp : in STD_LOGIC_VECTOR (1 downto 0);
           MinNorm : in STD_LOGIC_VECTOR (22 downto 0);
           MoutShift : in STD_LOGIC_VECTOR (22 downto 0);
           Co : in STD_LOGIC;
	       Clk : in STD_LOGIC;
           depSup : in STD_LOGIC;
           depInf : in STD_LOGIC;
           Start :in Std_logic;
           p:in std_logic;
           SelExp : out STD_LOGIC;
           Rst:in std_logic;
           enableLoad:out std_logic;
           SelMantisa : out STD_LOGIC;
           Enable : out STD_LOGIC;
           Term:out std_logic;
           shiftEnable:out std_logic;
           normEnable:out std_logic;
           EnableMoutShift:out std_logic;
           SelS : out STD_LOGIC_VECTOR (2 downto 0));
end UC;

architecture Behavioral of UC is
TYPE TIP_STARE IS ( S1, S2, S3,S4,S5,SProc,S6,S7,S8,S9,S10,S11,S12,Stop);
SIGNAL StareCur : TIP_STARE;
signal term_aux,enable_aux,shiftEnable_aux,SelM,gexp: std_logic :='0';
signal SelS_aux:std_logic_vector(2 downto 0) := "000";

begin
    process(Clk,Rst)
	begin
		if (Clk'event and Clk='1') then
			if (Rst = '1') then
				stareCur <= S1;
		    elsif (Start = '1') then
                stareCur <= S1;
			else
			    case StareCur is
			    when S1 => 
			          term_aux<='0'; enable_aux<='0';shiftEnable_aux<='0';SelM<='0';gexp<='0';
			          if comp="00" then StareCur<=S2;
			          elsif comp="01" then StareCur<=S3;
			          else StareCur<=S4;
			          end if;
			    when S2 => StareCur<=S5;shiftEnable_aux<='1';SelM<='1';
			    when S3 => StareCur<=S5;shiftEnable_aux<='1';SelM<='0';gexp<='1';
			    when S4 => StareCur<=S5;SelM<='1';
			    when S5 => StareCur<=SProc;
			    when SProc => StareCur<=S6;
			    when S6 => 
                    if (MoutShift="0000000000000000000000" and Comp/="10") then SelS_aux<="001";StareCur<=Stop;
                    else StareCur<=S7;
                    end if;
                when S7 => StareCur<=S8;
                when S8 => 
                    if Co='1' then StareCur<=S9;enable_aux<='1';
                    elsif p='1' then StareCur<=S9;enable_aux<='0';
                    elsif MinNorm="0000000000000000000000" then SelS_aux<="000";StareCur<=Stop;
                    else StareCur<=S9;enable_aux<='0';
                    end if;
                when S9 => 
                    if depSup='1' then SelS_aux<="010";StareCur<=Stop;
                    else StareCur<=S10;
                    end if;
                when S10 => StareCur<=S11;
                when S11 => 
                     if depInf='1' then SelS_aux<="011";StareCur<=Stop;
                     else StareCur<=S12;
                     end if;
                when S12 => SelS_aux<="100";StareCur<=Stop; 
                when Stop => term_aux<='1'; 
			    end case;
	         end if;
	     end if;
	 end process;
	 
	 SelExp<=gexp;
	 SelMantisa<=SelM;
	 enableLoad<='1' when (StareCur=S2 or StareCur=S3 or StareCur=S4 or StareCur=S5 or StareCur=SProc) else '0';
	 enable<=enable_aux;
	 SelS<=SelS_aux when StareCur=Stop else "110";
	 Term<=term_aux;
	 shiftEnable<=shiftEnable_aux;
	 normEnable<='1' when (StareCur=S10 or StareCur=S12 or StareCur=S11 or StareCur=Stop) else '0';
	 EnableMoutShift<='1' when StareCur=SProc else '0';
end Behavioral;
