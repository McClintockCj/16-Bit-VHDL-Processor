library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_Memory is
    port(PC : in std_logic_vector(4 downto 0); --Address in
         instruction : out std_logic_vector(15 downto 0)); --Instruction out
end entity;

architecture behavioral of Instruction_Memory is
type IM is array (0 to 31) of std_logic_vector(15 downto 0);
Signal Memory : IM := (others => x"0000");
begin

    Instruction_read : process(PC) is
    begin
        instruction <= Memory(to_integer(unsigned(PC))); --When PC changes, Write out correct instruction to output
    end process instruction_read;
end architecture behavioral;
