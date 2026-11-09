Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Program_Counter is
port(CLK : in std_logic;
     PC_IN : in std_logic_vector(4 downto 0);
     PC_OUT : out std_logic_vector(4 downto 0);
     PC_next : out std_logic_vector(4 downto 0));
end entity;

architecture behavioral of Program_Counter is
Signal One : unsigned(4 downto 0) := "00001";
Signal PC_reg : std_logic_vector(4 downto 0) := "00000";
begin
    
    PC_next <= std_logic_vector(unsigned(PC_REG) + One); --Always have incremented address
    
    write : process(clk) is
    begin
        if (rising_edge(clk)) then
            PC_reg <= PC_IN;
        end if;
    end process write;
    
    PC_OUT <= PC_Reg;
    
    
end architecture behavioral;