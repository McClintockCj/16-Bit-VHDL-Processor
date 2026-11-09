Library IEEE;
use IEEE.std_logic_1164.all;

entity MUX16 is
port(in1 : in std_logic_vector(15 downto 0);
     in2 : in std_logic_vector(15 downto 0);
     Sel : in std_logic;
     Out1 : out std_logic_vector(15 downto 0));
end entity;

architecture behavioral of MUX16 is
begin

    Multiplex : process(Sel, in1, in2) is 
    begin
        if (sel = '0') then
            Out1 <= in1;
        elsif (sel = '1') then
            Out1 <= in2;
        else
            Out1 <= x"0000";
        end if;
    end process Multiplex;

end architecture behavioral;