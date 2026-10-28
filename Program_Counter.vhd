Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Program_Counter is
port(CLK : in std_logic;
     Next_PC : in std_logic_vector(4 downto 0);
     PC : inout std_logic_vector(4 downto 0);
     PC_next : out std_logic_vector(4 downto 0));
end entity;

architecture behavioral of Program_Counter is
Signal One : unsigned := b"00001";
begin
    write : process(clk) is
    begin
        if (rising_edge(clk)) then
            PC <= Next_PC;
        end if;
    end process write;
    
    increment : process(PC) is
    begin
        PC_next <= std_logic_vector(unsigned(PC) + One);
    end process increment;
    
end architecture behavioral;