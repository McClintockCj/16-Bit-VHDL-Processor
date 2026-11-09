Library IEEE;
use IEEE.std_logic_1164.all;

entity MUX5 is
port(in1 : in std_logic_vector(4 downto 0);
     in2 : in std_logic_vector(4 downto 0);
     Sel : in std_logic;
     Out1 : out std_logic_vector(4 downto 0));
end entity;

architecture behavioral of MUX5 is
begin

    Multiplex : process(Sel, in1, in2) is 
    begin
        if (sel = '0') then
            Out1 <= in1;
        elsif (sel = '1') then
            Out1 <= in2;
        else
            Out1 <= "00000";
        end if;
    end process Multiplex;

end architecture behavioral;