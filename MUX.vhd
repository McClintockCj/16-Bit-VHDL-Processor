Library IEEE;
use IEEE.std_logic_1164.all;

entity MUX is
port(in1 : in std_logic;
     in2 : in std_logic;
     Sel : in std_logic;
     Out1 : out std_logic);
end entity;

architecture behavioral of MUX is
begin

    Multiplex : process(Sel, in1, in2) is 
    begin
        if (sel = '0') then
            Out1 <= in1;
        elsif (sel = '1') then
            Out1 <= in2;
        else
            Out1 <= '-';
        end if;
    end process Multiplex;

end architecture behavioral;