library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_Memory is
    port(PC : in std_logic_vector(4 downto 0); --Address in
         instruction : out std_logic_vector(15 downto 0)); --Instruction out
end entity;

architecture behavioral of Instruction_Memory is
type IM is array (0 to 31) of std_logic_vector(15 downto 0);
Signal Memory : IM := (b"1011000001000000",     --li $r0, 0x40; $r0 = 0x40
                       b"1011000100010000",     --li $r1, 0x10; $r1 = 0x0010
                       b"1000000100011000",     --Slli $r1, $r1, 8; $r1 = 0x1000
                       b"1011001000010000",     --li $r2 0x10; $r2 = 0x0010
                       b"0011000100100001",     --or $r1, $r1, $r2; $r1 = 0x1010
                       b"1011001000001111",     --li $r2, 0xF $r2 = 0x000F
                       b"1011001111110000",     --li $r3, 0xF0; $r3 = 0x00F0
                       b"0100010001000000",     --Addi $r4, $r4, 0; $r4 = 0x0000
                       b"1011010100010000",     --Li $r5, 0x10; $r5 = 0x0010
                       b"0100011001100101",     --Addi $r6, $r6, 5; $r6 = 0x0005
                       b"1101011000011110",     --Loop: BZ $r6, done; if $r6 = 0 branch else continue
                       b"1011011100000001",     --Li $r7, 1; $r7 = 1
                       b"0001011001110110",     --Sub $r6, $r6, $r7; $r6 = $r6 - 1
                       b"1010010101000000",     --Lw $r4, 0($r5); $r4 = mem[$r5]
                       b"1011100000010000",     --Li $r8, 0x10
                       b"1000100010000100",     --Slli $r8, $r8, 4; $r8 = 0x100
                       b"0110100001000111",     --If: slt $r7, $r8 $r4; $r7 = $r4 > 0x100
                       b"1110011100010111",     --BNZ $r7,  true;  if $r4 > 0x100 branch true
                       b"1000001000100010",     --Slli $r2, $r2, 2; $r2 = $r2 * 4
                       b"0101001100100011",     --Xor $r3, $r3, $r2; $r3 = $r3 XOR $r2
                       b"1011011111111111",     --Li $r7, 0xFF; $r7 = 0xff
                       b"1100010101110000",     --Sw $r7, ($r5); mem[$r5] = $r7
                       b"1111000000011100",     --J endif
                       b"1001000000000011",     --True: slri $r0, $r0, 3; $r0 = $r0 / 8
                       b"0011000100000001",     --Or $r1, $r1, $r0; $r1 = $r1 | $r0
                       b"1011011111111111",     --Li $r7, 0xFF; 
                       b"1000011101111000",     --Slli $r7, $r7, 8; $r7 = 0xFF00
                       b"1100010101110000",     --Sw $r7, 0($r5); mem[$r5] = $r7
                       b"0100010101010010",     --endif: addi $r5, $r5, 2; $r5 = $r5 + 2
                       b"1111000000001010",     --J loop
                       b"0000000000000000",     --Done: 
                       others => x"0000");
begin

    Instruction_read : process(PC) is
    begin
    if (unsigned(PC) >= 0 AND unsigned(PC) <= 31) then
        instruction <= Memory(to_integer(unsigned(PC))); --When PC changes, Write out correct instruction to output
    else
        instruction <= x"0000";
    end if;
    end process instruction_read;
end architecture behavioral;