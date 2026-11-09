library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_Memory is
    port(PC : in std_logic_vector(4 downto 0); --Address in
         instruction : out std_logic_vector(15 downto 0)); --Instruction out
end entity;

architecture behavioral of Instruction_Memory is
type IM is array (0 to 31) of std_logic_vector(15 downto 0);
Signal Memory : IM := (b"0000000000010010", --ADD $r2, $r0, $r1
                       b"1100000000100000", --SW $r2, 0($r0)
                       b"1011000001000000", --LI $r0, 0x40
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