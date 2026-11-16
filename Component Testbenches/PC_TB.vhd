Library IEEE;
Use IEEE.Std_logic_1164.all;

entity PC_TB is

end entity;

architecture Test of PC_TB is
Signal CLK_Sig : std_logic := '0'; --Clock signal
Signal PC_IN_Sig : std_logic_vector(4 downto 0); --Next value for PC
Signal PC_Curr_Sig : std_logic_vector(4 downto 0); --Current Value in PC Reg out
Signal PC_Plus1_Sig : std_logic_vector(4 downto 0); --Included PC + 1 adder within PC structure

begin

--Clock signal Generation (Period 10 ns)
CLK_Sig <= NOT CLK_Sig after 5 ns;

--Instantiate DUT (PC)
DUT : entity work.Program_Counter(behavioral)
    port map(CLK => CLK_Sig, PC_In => PC_IN_Sig,
             PC_OUT => PC_Curr_Sig, PC_Next => PC_Plus1_Sig);
             
--Begin Stimulus Process
stimulus : Process(PC_Curr_Sig) is
    begin
    if (PC_Curr_Sig = "00101") then
        PC_IN_Sig <= "01010"; --Test non PC + 1
    else
        PC_IN_Sig <= PC_Plus1_Sig; --Test PC + 1
    end if;
end process stimulus;

end architecture;