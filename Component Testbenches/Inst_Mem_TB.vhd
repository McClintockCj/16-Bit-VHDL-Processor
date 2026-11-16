Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.Numeric_STD.all;

entity Inst_Mem_TB is 

end entity;

architecture TEST of Inst_Mem_TB is
Signal PC_Sig : std_logic_vector(4 downto 0) := "00000"; --Fake PC
Signal Inst_Out : std_logic_vector(15 downto 0); --Instruction out from Memory
Signal one : unsigned(4 downto 0) := "00001"; --Fake a one for easier increments
begin

--Instantiate DUT
DUT : entity work.Instruction_Memory(Behavioral)
    port map(PC => PC_Sig, Instruction => Inst_Out);
    
--Stimulus process (Just increment PC every 5 nanoseconds
PC_Sig <= std_logic_vector(unsigned(PC_Sig) + one) after 5 ns;

end architecture TEST;