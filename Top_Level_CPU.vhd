library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

Entity CPU is
--Empty Architecture?
    port(clk : std_logic);
end entity;

architecture structural of CPU is
--PC
Signal PCP1 : std_logic_vector(4 downto 0); --Program Counter Plus 1
Signal PC_Curr : std_logic_vector(4 downto 0); --Current PC value
Signal PC_In : std_logic_vector(4 downto 0); -- Bus into PC 

--Instruction Memory
Signal Inst_out : std_logic_vector(15 downto 0);

--Reg File
Signal WriteSource : std_logic_vector(3 downto 0);
Signal WriteData : std_logic_vector(15 downto 0);
Signal RegWr : std_logic;
Signal BusA : std_logic_vector(15 downto 0);
Signal BusB : std_logic_vector(15 downto 0);

--ALU
Signal ALUCtr : std_logic_vector(2 downto 0);
Signal Zero : std_logic;
Signal Result : std_logic_vector(15 downto 0);
Signal OpB : std_logic_vector(15 downto 0);
Signal ALUSel : std_logic;

--Data Memory
Signal Memread : std_logic;
Signal Memwr : std_logic;
Signal DataOut : std_logic_vector(15 downto 0);

--Multiplexers
Signal Immediate : std_logic_vector(15 downto 0);
Signal ImmediateBr : std_logic_vector(4 downto 0);
Signal PCCtr : std_logic;
Signal PC_INT : std_logic_vector(4 downto 0);
Signal bz_sel : std_logic;
Signal BZ, BNZ : std_logic;
Signal WrSrc : std_logic;
Signal Mem2Reg : std_logic;
Signal DataInter : std_logic_vector(15 downto 0);
Signal LiSig : std_logic;

begin

--Sign extend the immediate MAKE THIS A PROCESS
SignEx : process(Inst_Out(15 downto 12)) is
begin
    if (Inst_Out(15 downto 12) = "1101" or Inst_Out(15 downto 12) = "1101" or Inst_Out(15 downto 12) = "1110") then
        Immediate <= std_logic_vector(resize(unsigned(Inst_out(7 downto 0)), 16)); --LI or BZ/BNZ
        ImmediateBr <= std_logic_vector(resize(unsigned(Inst_out(7 downto 0)), 5)); --LI or BZ/BNZ
    elsif (Inst_Out(15 downto 12) = "1111") then
        Immediate <= std_logic_vector(resize(unsigned(Inst_out(11 downto 0)), 16)); --J
    else 
        Immediate <= std_logic_vector(resize(unsigned(Inst_out(3 downto 0)), 16)); --Any other I type instruction
    end if;
end process;


--Instantiate Program Counter
 PC : entity work.Program_Counter(behavioral)
    port map(CLK => clk, PC_Next => PCP1, PC => PC_Curr,
             Next_PC => PC_IN);

--Instantiate Instruction Memory
Inst_Memory : entity work.Instruction_Memory(behavioral)
    port map(PC => PC_Curr, instruction => Inst_out);
    
--Instantiate Register File
File_Registers : entity work.Register_File(Behavioral)
    port map(Read1 => Inst_out(11 downto 8), Read2 => Inst_out(7 downto 4), 
             WriteD => WriteSource, DataIn => WriteData, EN => RegWr,
             CLK => clk, Out1 => BusA, Out2 => BusB);
             
--Instantiate ALU
CPU_ALU : entity work.ALU_FUNCT(behavioral)
    port map(ALUCtr => ALUCtr, BusA => BusA, BusB => OpB, 
             Result => Result, Zero => Zero);
             
--Instantiate Data Memory
Data_Mem : entity work.Data_Memory(Behavioral)
    port map(addressin => Result, WriteData => BusB,
             CLK => CLK, MemRead => Memread,
             MemWrite => MemWr, DataOut => DataOut);
             
--Instantiate Control Unit
Control : entity work.Control_Unit(Behavioral)
    port map(OpCode => Inst_Out(15 downto 12), WrSrc => WrSrc,
             ALUCtr => ALUSel, MemToReg => Mem2Reg, 
             RegWr => RegWr, MemRead => MemRead,
             MemWr => MemWr, BZ => BZ, BNZ => BNZ,
             LiSig => LISIG, PCCtr => PCCtr, ALUOp => ALUCtr);

--PC Multiplexers
PC1 : entity work.mux5(Behavioral)
    port map(in1 => pcp1, in2 => ImmediateBr, sel => PCCtr,
             Out1 => PC_INT);

process(BNZ, BZ, ZERO) is
    begin
    BZ_Sel <= (BNZ AND NOT ZERO) or (BZ AND ZERO);
end process;

PC2 : entity work.mux5(Behavioral)
    port map(in1 => PC_INT, in2 => ImmediateBr, sel => BZ_Sel,
             Out1 => PC_IN);

--Reg File Multiplexer
Reg1 : entity work.mux4(Behavioral)
    port map(in1 => Inst_Out(3 downto 0), in2 => Inst_Out(7 downto 4),
             Sel => WrSrc, Out1 => WriteSource);

--ALU Source Multiplexer
Alu1 : entity work.mux16(Behavioral)
    port map(in1 => BusB, in2 => Immediate, 
             sel => ALUSel, Out1 => OpB);

--Data Mem Multiplexer
Data1 : entity work.mux16(Behavioral)
    port map(in1 => DataOut, in2 => Result, 
             sel => Mem2Reg, Out1=> DataInter);

Data2 : entity work.mux16(Behavioral)
    port map(in1 => DataInter, in2 => Immediate, 
             sel => LiSig, Out1 => WriteData);

end architecture structural;