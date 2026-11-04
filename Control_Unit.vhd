Library IEEE;
use IEEE.std_logic_1164.ALL;

Entity Control_Unit is
    port(OpCode : in std_logic_vector(3 downto 0); --Create control signals out with opcode in
         WrSrc : out std_logic;
         ALUCtr : out std_logic;
         MemToReg : out std_logic;
         RegWr : out std_logic;
         MemRead : out std_logic;
         MemWr : out std_logic;
         BZ : out std_logic;
         BNZ : out std_logic;
         LiSig : out std_logic;
         Branch : out std_logic;
         PCCtr : out std_logic;
         ALUOp : out std_logic_vector(2 downto 0));
end entity;

architecture Behavioral of Control_Unit is
begin

    Control : process(OpCode) is
    begin
        LiSig <= '0';
        case opcode is 
            when "0000" => --ADD
                WrSrc <= '0';
                ALUCtr <= '0';
                MemToReg <= '1';
                RegWr <= '1';
                MemRead <= '0';
                MemWr <= '0';
                Branch <= '0';
                PCCtr <= '0';
                ALUOp <= "000";
            when "0001" => --SUB
                WrSrc <= '0';
                ALUCtr <= '0';
                MemToReg <= '1';
                RegWr <= '1';
                MemRead <= '0';
                MemWr <= '0';
                Branch <= '0';
                PCCtr <= '0';
                ALUOp <= "001";
            when "0010" => --AND
                WrSrc <= '0';
                ALUCtr <= '0';
                MemToReg <= '1';
                RegWr <= '1';
                MemRead <= '0';
                MemWr <= '0';
                Branch <= '0';
                PCCtr <= '0';
                ALUOp <= "010";
            when "0011" => --OR
                WrSrc <= '0';
                ALUCtr <= '0';
                MemToReg <= '1';
                RegWr <= '1';
                MemRead <= '0';
                MemWr <= '0';
                Branch <= '0';
                PCCtr <= '0';
                ALUOp <= "011";
            when "0100" => --ADDI
                WrSrc <= '1';
                ALUCtr <= '1';
                MemToReg <= '1';
                RegWr <= '1';
                MemRead <= '0';
                MemWr <= '0';
                Branch <= '0';
                PCCtr <= '0';
                ALUOp <= "000";
            when "0101" => --XOR
                WrSrc <= '0';
                ALUCtr <= '0';
                MemToReg <= '1';
                RegWr <= '1';
                MemRead <= '0';
                MemWr <= '0';
                Branch <= '0';
                PCCtr <= '0';
                ALUOp <= "100";
            when "0110" => --SLT
                WrSrc <= '0';
                ALUCtr <= '0';
                MemToReg <= '1';
                RegWr <= '1';
                MemRead <= '0';
                MemWr <= '0';
                Branch <= '0';
                PCCtr <= '0';
                ALUOp <= "111";
            when "0111" => --SLTI
                WrSrc <= '1';
                ALUCtr <= '1';
                MemToReg <= '1';
                RegWr <= '1';
                MemRead <= '0';
                MemWr <= '0';
                Branch <= '0';
                PCCtr <= '0';
                ALUOp <= "111";
            when "1000" => --SLLI
                WrSrc <= '1';
                ALUCtr <= '1';
                MemToReg <= '1';
                RegWr <= '1';
                MemRead <= '0';
                MemWr <= '0';
                Branch <= '0';
                PCCtr <= '0';
                ALUOp <= "101";
            when "1001" => --SLRI
                WrSrc <= '1';
                ALUCtr <= '1';
                MemToReg <= '1';
                RegWr <= '1';
                MemRead <= '0';
                MemWr <= '0';
                Branch <= '0';
                PCCtr <= '0';
                ALUOp <= "110";
            when "1010" => --LW
                WrSrc <= '1';
                ALUCtr <= '1';
                MemToReg <= '0';
                RegWr <= '1';
                MemRead <= '1';
                MemWr <= '0';
                Branch <= '0';
                PCCtr <= '0';
                ALUOp <= "000";
            when "1011" => --LI has its own signal for a specific multiplex
                WrSrc <= '1'; --from Bus to Writedata 
                ALUCtr <= '1';
                MemToReg <= '0';
                RegWr <= '1';
                MemRead <= '1';
                MemWr <= '0';
                Branch <= '0';
                PCCtr <= '0';
                LiSig <= '1';
                ALUOp <= "000";
            when "1100" => --SW
                WrSrc <= '0';
                ALUCtr <= '1';
                MemToReg <= '0';
                RegWr <= '0';
                MemRead <= '0';
                MemWr <= '1';
                Branch <= '0';
                PCCtr <= '0';
                ALUOp <= "000";
            when "1101" => --BZ 
                WrSrc <= '0';
                ALUCtr <= '1';
                BZ <= '1';
                BNZ <= '0';
                MemToReg <= '0';
                RegWr <= '0';
                MemRead <= '0';
                MemWr <= '0';
                Branch <= '0';
                PCCtr <= '0';
                ALUOp <= "000";
            when "1110" => --BNZ 
                WrSrc <= '0';
                BNZ <= '1';
                BZ <= '0';
                ALUCtr <= '1';
                MemToReg <= '0';
                RegWr <= '0';
                MemRead <= '0';
                MemWr <= '0';
                Branch <= '0';
                PCCtr <= '0';
                ALUOp <= "000";
            when "1111" => --J 
                WrSrc <= '0';
                ALUCtr <= '1';
                MemToReg <= '0';
                RegWr <= '0';
                MemRead <= '0';
                MemWr <= '0';
                Branch <= '0';
                PCCtr <= '1';
                ALUOp <= "000";
                
       end case;
                
    end process Control;

end architecture behavioral;