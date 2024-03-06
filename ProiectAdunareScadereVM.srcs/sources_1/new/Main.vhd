----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2023 11:42:40 PM
-- Design Name: 
-- Module Name: Main - Behavioral
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

entity main is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           A_S:in std_logic;
           Rst:in std_logic;
           clk:in std_logic;
           Start: in std_logic;
           dep:out std_logic_vector(1 downto 0);
           S : out STD_LOGIC_VECTOR (31 downto 0));
end main;

architecture Behavioral of main is

signal M1,M2,MoutAdder:std_logic_vector(22 downto 0):="00000000000000000000000";
signal DifExp:std_logic_vector(4 downto 0):="00000";
signal Comp:std_logic_vector(1 downto 0):="00";
signal MoutShift,MoutShift_aux, Mout,MoutNorm,MinNorm:std_logic_vector(22 downto 0):="00000000000000000000000";
signal term,Co,So,Enable,DepSup,DepInf,SelMantisa,SelExp,enableLoad:std_logic:='0';
signal SelS:std_logic_vector(2 downto 0):="000";
signal GExp,expOut,expOutNorm,expInNorm:std_logic_vector(7 downto 0):="00000000";
signal S_aux:std_logic_vector(31 downto 0):=x"00000000";
signal shiftEnable,normEnable,normEnableAux,EnableMoutShift,semn,p:std_logic:='0';


begin
    comp1: entity WORK.CompExp port map (ExpA => A(30 downto 23),ExpB => B(30 downto 23),Dexp => DifExp, Comp => Comp);
    
    comp2: entity WORK.ShiftRight port map (inp=>M1,Shift1=>DifExp,shiftEnable=>shiftEnable,outp=>MoutShift);
    
    comp3: entity WORK.Adder port map(SemnA =>A(31) ,SemnB =>B(31) , MA=>MoutShift ,MB=>M2, A_S=> A_S,
                                      comp => Comp, S=>MoutAdder ,Co=>Co,p=>p,So=>So);
    comp4: entity WORK.DepExpBlock port map(Exp=>Gexp,Enable=>Enable,M=>MoutAdder,DepSup=>DepSup,p=>p,ExpOut=>ExpOut,Mout=>Mout);

    comp5: entity WORK.BlockNorm port map(MS=>MinNorm,ES=>expInNorm,normEnable=>(normEnableAux),M=>MoutNorm,E=>expOutNorm,DepInf=>DepInf);
    
    comp6: entity WORK.UC port map(comp=>comp,MinNorm=>MoutAdder,MoutShift=>MoutShift_aux,Co=>Co,p=>p,Start=>Start,Clk=>Clk,DepSup=>DepSup,
                                  DepInf=>DepInf,SelExp=>SelExp,SelMantisa=>SelMAntisa,SelS=>SelS,Enable=>Enable,Rst=>Rst,
                                  enableLoad=>enableLoad,term=>term,shiftEnable=>shiftEnable,normEnable=>normEnable,EnableMoutShift=>EnableMoutShift);
   
   
    normEnableAux<=normEnable and (not(Co or p));
  
    c:process(EnableMoutShift)
    begin
        if EnableMoutShift='1' then 
            MoutShift_aux<=MoutShift;
        end if;
    end process;
    
    mux1: process(SelExp,enableLoad)
    begin
        if enableLoad='1' then 
            if SelExp='0' then Gexp<=A(30 downto 23); semn<=A(31);
            else Gexp<=B(30 downto 23);semn<=B(31);
            end if;
        end if;
    end process;
    MinNorm<=MoutAdder when Enable='0' else Mout;
    expInNorm<=Gexp when Enable='0' else ExpOut;
    
    mux2_3:process(SelMantisa,enableLoad)
    begin
        if enableLoad='1' then 
            if SelMantisa='0' then M1<=A(22 downto 0);M2<=B(22 downto 0);        
            else M1<=B(22 downto 0);M2<=A(22 downto 0);   
            end if;
        end if;
    end process;
    
    S_aux(31)<=So;
    S_aux(30 downto 23)<=expOutNorm;
    S_aux(22 downto 0)<=MoutNorm;
    
    mux4:process(SelS,term)
    begin
        if term='1' then
            if Sels="000" then S<=x"00000000";
            elsif Sels="001" then
                s<=semn & Gexp & M2 ;
            elsif Sels="100" then S<=S_aux;
            else S<="--------------------------------";
                if Sels="011" then dep<="01";
                elsif Sels="010" then dep<="10";
                else dep<="00";
                end if;
            end if;
        else 
            S<="--------------------------------";dep<="00";
        end if;
    end process;
    
end Behavioral;
