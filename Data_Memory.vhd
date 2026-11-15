--Data_Memory

Library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Data_Memory is 
    port(addressIn : in std_logic_vector(15 downto 0); --Address
         WriteData : in std_logic_vector(15 downto 0); --Data to be written
         CLK : in std_logic;
         MemRead : in std_logic; --Read enable
         MemWrite : in std_logic; --Write enable
         DataOut : out std_logic_vector(15 downto 0)); --Data read from memory
end entity;

architecture behavioral of Data_Memory is
Type storage is array (0 to 31) of std_logic_vector(15 downto 0); --Create memory type
signal Data_Memory : storage := (
        16     => x"0200", -- Iteration 1
        18     => x"0050", -- Iteration 2
        20     => x"0150", -- Iteration 3
        22     => x"0100", -- Iteration 4
        24     => x"0300", -- Iteration 5
        others => x"0000"
       );
begin

    Write : process(clk) is
    begin
        if (rising_edge(clk) AND MemWrite = '1') then --Write enable high and rising edge
            if (to_integer(unsigned(addressIn)) <= 31) then
                Data_Memory(to_integer(unsigned(addressIn))) <= WriteData; --Write to memory
            end if;
        end if;
    end process write;
    
    Read : process(addressIn, Data_Memory, MemRead) is
    begin
        if (MemRead = '1' and to_integer(unsigned(addressIn)) <= 31) then --If memread high
            DataOut <= Data_Memory(to_integer(unsigned(AddressIn))); --Read out data
        else
            DataOut <= x"0000";
        end if;
    end process read;
end architecture behavioral;