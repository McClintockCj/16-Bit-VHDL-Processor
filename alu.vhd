library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_funct is
    port (ALUctr    : in std_logic_vector(2 downto 0);
          BusA      : in std_logic_vector(15 downto 0);
          BusB      : in std_logic_vector(15 downto 0);
          Zero      : out std_logic;
          Result    : out std_logic_vector(15 downto 0)
    );
end alu_funct;

architecture behavioral of alu_funct is

    signal Result_sig : std_logic_vector(15 downto 0);
        
begin    
            
    
    process(ALUctr, BusA, BusB) is
        variable shamt : integer range 0 to 3;
    begin

        shamt := to_integer(unsigned(BusB(3 downto 0)));
        
        case ALUctr is
            when "000" =>
                Result_sig <= std_logic_vector(unsigned(BusA) + unsigned(BusB));
                
            when "001" | "111" =>
                Result_sig <= std_logic_vector(unsigned(BusA) - unsigned(BusB));
                
            when "010" =>
                Result_sig <= BusA and BusB;
                
            when "011" =>
                Result_sig <= BusA or BusB;
                
            when "100" =>
                Result_sig <= BusA xor BusB;
                
            when "101" =>
                Result_sig <= std_logic_vector(shift_left(unsigned(BusA), shamt));
                
            when "110" =>
                Result_sig <= std_logic_vector(shift_right(unsigned(BusA), shamt));
                
            when others =>
                Result_sig <= (others => '0');
        end case;

    end process;
                    
    Zero <= '1' when (Result_sig = x"0000") else '0';
    Result <= Result_sig;

end architecture behavioral;
