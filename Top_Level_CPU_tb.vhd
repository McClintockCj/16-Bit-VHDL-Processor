library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CPU_tb is
end entity;

architecture sim of CPU_tb is
    signal clk          : std_logic := '0';
    signal PC_Debug     : std_logic_vector(4 downto 0);
    signal Inst_Debug   : std_logic_vector(15 downto 0);
    signal Result_Debug : std_logic_vector(15 downto 0);
    signal WData_Debug  : std_logic_vector(15 downto 0);
    signal RegWr_Debug  : std_logic;
    signal MemWr_Debug  : std_logic;

    signal sim_done     : boolean := false;
    constant CLK_PERIOD : time := 10 ns;
begin

    UUT : entity work.CPU(structural)
        port map (
            clk          => clk,
            PC_Debug     => PC_Debug,
            Inst_Debug   => Inst_Debug,
            Result_Debug => Result_Debug,
            WData_Debug  => WData_Debug,
            RegWr_Debug  => RegWr_Debug,
            MemWr_Debug  => MemWr_Debug
        );

    -- System clock that stops when simulation is finished
    clk_process : process
    begin
        while not sim_done loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Verification processes below
    test_proc : process
    begin


                --VERIFY SETUP INSTRUCTIONS BELOW


        -- PC 0: li $r0, 0x40; $r0 = 0x0040
        wait until rising_edge(clk);
        assert PC_Debug = "00000" and WData_Debug = x"0040" and RegWr_Debug = '1'
            report "FAIL at PC 0" severity error;

        -- PC 1: li $r1, 0x10; $r1 = 0x0010
        wait until rising_edge(clk);
        assert PC_Debug = "00001" and WData_Debug = x"0010" and RegWr_Debug = '1'
            report "FAIL at PC 1" severity error;

        -- PC 2: Slli $r1, $r1, 8; $r1 = 0x1000
        wait until rising_edge(clk);
        assert PC_Debug = "00010" and WData_Debug = x"1000" and RegWr_Debug = '1'
            report "FAIL at PC 2" severity error;

        -- PC 3: li $r2 0x10; $r2 = 0x0010
        wait until rising_edge(clk);
        assert PC_Debug = "00011" and WData_Debug = x"0010" and RegWr_Debug = '1'
            report "FAIL at PC 3" severity error;

        -- PC 4: or $r1, $r1, $r2; $r1 = 0x1010
        wait until rising_edge(clk);
        assert PC_Debug = "00100" and WData_Debug = x"1010" and RegWr_Debug = '1'
            report "FAIL at PC 4" severity error;

        -- PC 5: li $r2, 0xF $r2 = 0x000F
        wait until rising_edge(clk);
        assert PC_Debug = "00101" and WData_Debug = x"000F" and RegWr_Debug = '1'
            report "FAIL at PC 5" severity error;

        -- PC 6: li $r3, 0xF0; $r3 = 0x00F0
        wait until rising_edge(clk);
        assert PC_Debug = "00110" and WData_Debug = x"00F0" and RegWr_Debug = '1'
            report "FAIL at PC 6" severity error;

        -- PC 7: Addi $r4, $r4, 0; $r4 = 0x0000
        wait until rising_edge(clk);
        assert PC_Debug = "00111" and WData_Debug = x"0000" and RegWr_Debug = '1'
            report "FAIL at PC 7" severity error;

        -- PC 8: Li $r5, 0x10; $r5 = 0x0010
        wait until rising_edge(clk);
        assert PC_Debug = "01000" and WData_Debug = x"0010" and RegWr_Debug = '1'
            report "FAIL at PC 8" severity error;

        -- PC 9: Addi $r6, $r6, 5; $r6 = 0x0005
        wait until rising_edge(clk);
        assert PC_Debug = "01001" and WData_Debug = x"0005" and RegWr_Debug = '1'
            report "FAIL at PC 9" severity error;


                --LOOP ITERATION 1 VERIFIED BELOW


        -- PC 10: Loop: BZ $r6, done; if $r6 = 0 branch else continue.
        --                            $r6 = 5, so do not branch
        wait until rising_edge(clk);
        assert PC_Debug = "01010"
            report "FAIL: Expected PC 10" severity error;

        -- PC 11: Li $r7, 1; $r7 = 1
        wait until rising_edge(clk);
        assert PC_Debug = "01011" and WData_Debug = x"0001"
            report "FAIL at PC 11" severity error;

        -- PC 12: Sub $r6, $r6, $r7; $r6 = $r6 - 1 = 4
        wait until rising_edge(clk);
        assert PC_Debug = "01100" and WData_Debug = x"0004"
            report "FAIL at PC 12" severity error;

        -- PC 13: Lw $r4, 0($r5); $r4 = mem[$r5] => $r4 = mem[16] = 0x0200
        wait until rising_edge(clk);
        assert PC_Debug = "01101" and WData_Debug = x"0200"
            report "FAIL at PC 13" severity error;

        -- PC 14: Li $r8, 0x10
        wait until rising_edge(clk);
        assert PC_Debug = "01110" and WData_Debug = x"0010"
            report "FAIL at PC 14" severity error;

        -- PC 15: Slli $r8, $r8, 4; $r8 = 0x100
        wait until rising_edge(clk);
        assert PC_Debug = "01111" and WData_Debug = x"0100"
            report "FAIL at PC 15" severity error;

        -- PC 16: slt $r7, $r8, $r4; $r4 > 0x100, so $r7 = 0x0001
        wait until rising_edge(clk);
        assert PC_Debug = "10000" and WData_Debug = x"0001"
            report "FAIL at PC 16" severity error;

        -- PC 17: BNZ $r7,  true;  if $r7 /= 0x0000 branch to true (PC 23)
        --                         $r7 = 0x0001, so PC branches to PC 23
        wait until rising_edge(clk);
        assert PC_Debug = "10001"
            report "FAIL at PC 17" severity error;

        -- PC 23: True: slri $r0, $r0, 3; $r0 = $r0 / 8
        wait until rising_edge(clk);
        assert PC_Debug = "10111" and WData_Debug = x"0008"
            report "FAIL at PC 23" severity error;

        -- PC 24: Or $r1, $r1, $r0; $r1 = $r1 | $r0
        wait until rising_edge(clk);
        assert PC_Debug = "11000" and WData_Debug = x"1018"
            report "FAIL at PC 24" severity error;

        -- PC 25: Li $r7, 0xFF;
        wait until rising_edge(clk);
        assert PC_Debug = "11001" and WData_Debug = x"00FF"
            report "FAIL at PC 25" severity error;

        -- PC 26: Slli $r7, $r7, 8; $r7 = 0xFF00
        wait until rising_edge(clk);
        assert PC_Debug = "11010" and WData_Debug = x"FF00"
            report "FAIL at PC 26" severity error;

        -- PC 27: Sw $r7, 0($r5); mem[$r5] = $r7
        wait until rising_edge(clk);
        assert PC_Debug = "11011" and Result_Debug = x"0010" and MemWr_Debug = '1'
            report "FAIL at PC 27" severity error;

        -- PC 28: endif: addi $r5, $r5, 2; $r5 = $r5 + 2
        wait until rising_edge(clk);
        assert PC_Debug = "11100" and WData_Debug = x"0012"
            report "FAIL at PC 28" severity error;

        -- PC 29: J loop; jump back to PC 10
        wait until rising_edge(clk);
        assert PC_Debug = "11101"
            report "FAIL at PC 29" severity error;
            
            
                --LOOP ITERATION 2 VERIFIED BELOW
            
            
        -- PC 10: Loop: BZ $r6, done; if $r6 = 0 branch else continue.
        --                            $r6 = 4, so do not branch
        wait until rising_edge(clk);
        assert PC_Debug = "01010"
            report "FAIL Iter 2 at PC 10" severity error;

        -- PC 11: Li $r7, 1
        wait until rising_edge(clk);
        assert PC_Debug = "01011" and WData_Debug = x"0001"
            report "FAIL Iter 2 at PC 11" severity error;

        -- PC 12: Sub $r6, $r6, $r7; $r6 = 3
        wait until rising_edge(clk);
        assert PC_Debug = "01100" and WData_Debug = x"0003"
            report "FAIL Iter 2 at PC 12" severity error;

        -- PC 13: Lw $r4, 0($r5); $r4 = mem[$r5] => $r4 = mem[18] = 0x0050
        wait until rising_edge(clk);
        assert PC_Debug = "01101" and WData_Debug = x"0050"
            report "FAIL Iter 2 at PC 13" severity error;

        -- PC 14: Li $r8, 0x10
        wait until rising_edge(clk);
        assert PC_Debug = "01110" and WData_Debug = x"0010"
            report "FAIL Iter 2 at PC 14" severity error;

        -- PC 15: Slli $r8, $r8, 4; $r8 = 0x100
        wait until rising_edge(clk);
        assert PC_Debug = "01111" and WData_Debug = x"0100"
            report "FAIL Iter 2 at PC 15" severity error;

        -- PC 16: slt $r7, $r8, $r4; $r4 (0x0100) < $r8 (0x0050), so $r7 = 0x0000
        wait until rising_edge(clk);
        assert PC_Debug = "10000" and WData_Debug = x"0000"
            report "FAIL Iter 2 at PC 16" severity error;

        -- PC 17: BNZ $r7,  true;  if $r7 /= 0x0000 branch to true (PC 23)
        --                         $r7 = 0x0000, so PC does not branch
        wait until rising_edge(clk);
        assert PC_Debug = "10001"
            report "FAIL Iter 2 at PC 17" severity error;

        -- PC 18: Slli $r2, $r2, 2; $r2 = $r2 * 4 => 0x000F << 2 = 0x003C
        wait until rising_edge(clk);
        assert PC_Debug = "10010" and WData_Debug = x"003C"
            report "FAIL at PC 18" severity error;

        -- PC 19: Xor $r3, $r3, $r2; $r3 = $r3 XOR $r2 => 0x00F0 xor 0x003C = 0x00CC
        wait until rising_edge(clk);
        assert PC_Debug = "10011" and WData_Debug = x"00CC"
            report "FAIL at PC 19" severity error;

        -- PC 20: Li $r7, 0xFF; $r7 = 0xff 
        wait until rising_edge(clk);
        assert PC_Debug = "10100" and WData_Debug = x"00FF"
            report "FAIL at PC 20" severity error;

        -- PC 21: Sw $r7, 0($r5); mem[$r5] = $r7 => mem[18] = 0x00FF
        wait until rising_edge(clk);
        assert PC_Debug = "10101" and Result_Debug = x"0012" and MemWr_Debug = '1'
            report "FAIL at PC 21" severity error;

        -- PC 22: J endif; Jumps to PC 28
        wait until rising_edge(clk);
        assert PC_Debug = "10110"
            report "FAIL at PC 22" severity error;

        -- PC 28: endif: addi $r5, $r5, 2; $r5 = $r5 + 2
        --                                 $r5 = 0x0012 + 2 = 0x0014
        wait until rising_edge(clk);
        assert PC_Debug = "11100" and WData_Debug = x"0014"
            report "FAIL at PC 28" severity error;

        -- PC 29: J loop; jump back to PC 10
        wait until rising_edge(clk);
        assert PC_Debug = "11101"
            report "FAIL Iter 2 at PC 29" severity error;
            
            
                --RUN ITERATIONS 3-5 (All processes verified above)


        for cycle in 1 to 120 loop
            wait until rising_edge(clk);
            if PC_Debug = "11110" then
                report "Success: All assertions passed" severity note;
                sim_done <= true;
                wait;
            end if;
        end loop;

        assert false
            report "Failure: CPU did not reach Done" severity failure;
        sim_done <= true;
        wait;
    end process;

end architecture;