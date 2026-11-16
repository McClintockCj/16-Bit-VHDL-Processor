Library IEEE;
Use IEEE.std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Data_Mem_TB is

end entity;

architecture Test of Data_Mem_TB is
--I/O signals
Signal Address_Sig : std_logic_vector(15 downto 0) := x"0000";
Signal Data_In_Sig : std_logic_vector(15 downto 0);
Signal Data_Out_Sig : std_logic_vector(15 downto 0);

--Control Signals
Signal MemRead_Sig : std_logic; 
Signal MemWrite_Sig : std_logic;

--Clock
Signal clk_sig : std_logic := '0';
begin

--Clock generator
clk_sig <= NOT clk_sig after 5 ns;

--Instantiate DUT
DUT : entity work.Data_Memory(Behavioral)
    port map(AddressIn => Address_Sig, WriteData => Data_In_Sig,
             CLK => clk_Sig, MemRead => MemRead_Sig, 
             MemWrite => MemWrite_sig, DataOut => Data_Out_Sig);

Stimulus : process is
    begin
    --Test read
    MemRead_Sig <= '1';
    MemWrite_Sig <= '0';
    Address_Sig <= x"0010";
    wait for 10 ns;
    Address_Sig <= x"0012";
    wait for 10 ns;
    
    --Test Write
    MemRead_sig <= '0';
    MemWrite_Sig <= '1';
    Address_Sig <= x"0000";
    Data_In_Sig <= x"F0F0";
    wait for 10 ns;
    Address_Sig <= x"0001";
    Data_In_Sig <= x"0F0F";
    wait for 10 ns;
    
    --Test read
    MemRead_Sig <= '1';
    MemWrite_Sig <= '0';
    Address_Sig <= x"0000";
    wait for 10 ns;
    Address_Sig <= x"0001";
    wait for 10 ns;
    
    wait;
end process Stimulus;

end architecture test;