library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity register_file is
    port(Read1 : in std_logic_vector(3 downto 0); --Rs
         Read2 : in std_logic_vector(3 downto 0); --Rt
         WriteD : in std_logic_vector(3 downto 0); --Rd
         DataIn : in std_logic_vector (15 downto 0); --Data to be written into file
         EN : in std_logic; --Enable in
         CLK : in std_logic; --CLK signal
         Out1 : out std_logic_vector(15 downto 0); -- Two outputs of register contents
         Out2 : out std_logic_vector(15 downto 0));
         
end entity;

architecture behavioral of register_file is
type reg_file is array (0 to 15) of std_logic_vector(15 downto 0);
Signal Registers : reg_file := (others => x"0000");
begin

    write_data : Process(clk) is --On rising clock edge, if write enable is true
    begin --                     Write data in to the corresponding register
        if (rising_edge(clk) AND EN = '1') then
            Registers(to_integer(unsigned(WriteD))) <= DataIn;
        end if;
   end process write_data;
   
   read_data : process(read1, read2) is --If inputs change, change read outputs
   begin 
        out1 <= Registers(to_integer(unsigned(Read1)));
        out2 <= Registers(to_integer(unsigned(Read2)));
   end process read_data;
   
end architecture behavioral;