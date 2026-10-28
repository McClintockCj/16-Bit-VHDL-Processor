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
Type storage is array (0 to 32) of std_logic_vector(15 downto 0); --Create memory type
Signal Memory : storage := (others => x"0000");
begin

    Write : process(clk) is
    begin
        if (rising_edge(clk) AND MemWrite = '1') then --Write enable high and rising edge
            Memory(to_integer(unsigned(addressIn))) <= WriteData; --Write to memory
        end if;
    end process write;
    
    Read : process(addressIn, Memory) is
    begin
        if (MemRead = '1') then --If memread high
            DataOut <= Memory(to_integer(unsigned(AddressIn))); --Read out data
        end if;
    end process read;
end architecture behavioral;