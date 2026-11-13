library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_funct is
    port (ALUctr    : in std_logic_vector(3 downto 0);
          in1      : in std_logic_vector(15 downto 0);
          in2      : in std_logic_vector(15 downto 0);
          Zero      : out std_logic;
          Result    : out std_logic_vector(15 downto 0)
    );
end alu_funct;

architecture behavioral of alu_funct is

    signal Result_sig : std_logic_vector(15 downto 0);
        
begin    
            
    
    process(ALUctr, in1, in2) is
        variable shamt : integer;
    begin

        shamt := to_integer(unsigned(in2));
        
        case ALUctr is
            when "0000" =>
                Result_sig <= std_logic_vector(unsigned(in1) + unsigned(in2));
                
            when "0001" =>
                Result_sig <= std_logic_vector(unsigned(in1) - unsigned(in2));
                
            when "0010" =>
                Result_sig <= in1 and in2;
                
            when "0011" =>
                Result_sig <= in1 or in2;
                
            when "0100" =>
                Result_sig <= in1 xor in2;
                
            when "0101" =>
                Result_sig <= std_logic_vector(shift_left(unsigned(in1), shamt));
                
            when "0110" =>
                Result_sig <= std_logic_vector(shift_right(unsigned(in1), shamt));
            
            when "0111" =>
                if (unsigned(in1) < unsigned(in2)) then
                    Result_sig <= x"0001";
                else 
                    Result_sig <= x"0000";
                end if;
                
            when "1000" => --Additional function for checking 0 for branch
                Result_sig <= in1;
          
            when others =>
                Result_sig <= (others => '0');
        end case;

    end process;
                    
    Zero <= '1' when (Result_sig = x"0000") else '0';
    Result <= Result_sig;

end architecture behavioral;
