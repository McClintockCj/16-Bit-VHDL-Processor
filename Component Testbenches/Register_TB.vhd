library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity Register_TB is

end entity;

architecture test of Register_TB is
--Clock sig
Signal clk_Sig : std_logic := '0';

--Read signals
Signal Read1_Sig : std_logic_vector(3 downto 0) := "0000"; --Rs
Signal Read2_Sig : std_logic_vector(3 downto 0) := "0001"; --Rt

--Write Destination
Signal WriteD_Sig : std_logic_vector(3 downto 0) := "0000"; --Rd
Signal Data_In_Sig : std_logic_vector(15 downto 0) := x"0F0F"; --Data to be written

--Read data
Signal Out1_sig : std_logic_vector(15 downto 0); --Data to be written
Signal Out2_Sig : std_logic_vector(15 downto 0); --Data to be written

--Control
Signal WriteReg : std_logic := '0';
begin

--Clock Generation
clk_sig <= NOT clk_sig after 5 ns;

--Instantiate DUT
DUT : entity work.Register_File(Behavioral)
    port map(Read1 => Read1_sig, read2 => read2_sig,
             WriteD => WriteD_Sig, DataIn => Data_In_Sig,
             EN => WriteReg, CLK => Clk_Sig, Out1 => Out1_Sig,
             Out2 => Out2_Sig);

Stimulus : Process is
    begin
    wait for 10 ns; --read empty registers
    
    WriteReg <= '1', '0' after 20 ns; --Write to registers
    WriteD_Sig <= "0001" after 10 ns;
    
    wait for 10 ns; --Read written registers;
    wait;
end process stimulus;


end architecture;