Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU_TB is 

end entity;

architecture Test of ALU_TB is
--Type definitions
Type stim_array is array (0 to 23) of std_logic_vector(15 downto 0);
Type Op_Array is array (0 to 23) of std_logic_vector(3 downto 0);

--Current signals
Signal A_Curr : std_logic_vector(15 downto 0);
Signal B_Curr : std_logic_vector(15 downto 0);
Signal Op_Curr : std_logic_vector(3 downto 0);
Signal Zero_Sig : std_logic;
Signal Result_Sig : std_logic_vector(15 downto 0);

--Test Values
constant Op_Arr : Op_Array := (
        -- 0000: ADD
        "0000", "0000", "0000",
        -- 0001: SUB
        "0001", "0001", "0001",
        -- 0010: AND
        "0010", "0010",
        -- 0011: OR
        "0011", "0011",
        -- 0100: XOR
        "0100", "0100",
        -- 0101: SLL (Shift Left Logical)
        "0101", "0101", "0101",
        -- 0110: SRL (Shift Right Logical)
        "0110", "0110", "0110",
        -- 0111: SLT (Set Less Than)
        "0111", "0111", "0111",
        -- 1000: Pass-through (Branch check)
        "1000", "1000",
        -- others: Default case
        "1111"
    );

    constant A_Arr : stim_array := (
        -- ADD: normal, zero+zero, unsigned overflow
        x"0005", x"0000", x"FFFF",
        -- SUB: normal, equal (zero result), unsigned underflow
        x"000A", x"1234", x"0000",
        -- AND: alternating bits, mask test
        x"AAAA", x"FF00",
        -- OR: alternating bits, zero test
        x"AAAA", x"0000",
        -- XOR: alternating bits, identical (zero result)
        x"AAAA", x"5A5A",
        -- SLL: shift by 0, shift by 4, shift out all bits (16)
        x"0001", x"000F", x"FFFF",
        -- SRL: shift by 0, shift by 4, shift out all bits (16)
        x"8000", x"F000", x"FFFF",
        -- SLT: A < B, A > B, A = B
        x"0005", x"0010", x"0007",
        -- Pass-through: non-zero, zero
        x"ABCD", x"0000",
        -- Default: non-zero inputs should still output 0
        x"FFFF"
    );

    constant B_Arr : stim_array := (
        -- ADD
        x"0003", x"0000", x"0001",
        -- SUB
        x"0004", x"1234", x"0001",
        -- AND
        x"5555", x"0FF0",
        -- OR
        x"5555", x"0000",
        -- XOR
        x"5555", x"5A5A",
        -- SLL (shift amounts)
        x"0000", x"0004", x"0010",
        -- SRL (shift amounts)
        x"0000", x"0004", x"0010",
        -- SLT
        x"0010", x"0005", x"0007",
        -- Pass-through (in2 ignored)
        x"FFFF", x"FFFF",
        -- Default
        x"FFFF"
    );
begin

--Instantiate DUT
DUT : entity work.alu_funct(Behavioral)
    port map(ALUCtr => Op_Curr, in1 => A_Curr, 
             in2 => B_Curr, Zero => Zero_Sig,
             Result => Result_Sig);

--Stimulus process
stimulus : Process is
    begin
    
    for i in 0 to 5 loop
        A_Curr <= A_Arr(i);
        B_Curr <= B_Arr(i);
        Op_Curr <= Op_Arr(i);
        wait for 10 ns;
    end loop;
    
    wait;
end process stimulus;

end architecture test;