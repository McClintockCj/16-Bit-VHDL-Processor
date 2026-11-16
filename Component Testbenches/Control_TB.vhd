Library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity Control_TB is

end entity;

architecture TEST of Control_TB is
--Control signals
Signal OpCode_Sig : std_logic_vector(3 downto 0) := "0000"; --Create control signals out with opcode in
Signal WrSrc_Sig : std_logic;
Signal ALUCtr_Sig : std_logic;
Signal MemToReg_sig : std_logic;
Signal RegWr_sig : std_logic;
Signal MemRead_Sig : std_logic;
Signal MemWr_sig : std_logic;
Signal BZ_Sig : std_logic;
Signal BNZ_Sig : std_logic;
Signal LiSig_Sig : std_logic;
Signal Branch_Sig : std_logic;
Signal PCCtr_Sig : std_logic;
Signal ALUOp_Sig : std_logic_vector(3 downto 0);
begin

--Instantiate DUT
DUT : entity work.Control_Unit(Behavioral)
    port map(OpCode => OpCode_Sig, WrSrc => WrSrc_sig,
             ALUCtr => ALUCtr_Sig, MemToReg => MemToReg_Sig,
             RegWr => RegWr_Sig, MemRead => MemRead_Sig, 
             MemWr => MemWr_Sig, BZ => BZ_Sig, BNZ => BNZ_Sig,
             LiSig => LiSig_Sig, Branch => Branch_Sig, PCCtr => PCCtr_sig,
             ALUOp => ALUOp_Sig);

--Stimulus Process (Just increment opcode to see each instruction
Stimulus : Process is 
    Variable One : unsigned(3 downto 0) := "0001";
    begin
    while (OpCode_Sig < "1111") loop
        OpCode_Sig <= std_logic_vector(unsigned(OpCode_Sig) + One);
        wait for 5 ns;
    end loop;
    wait;
end process stimulus;

end architecture test;