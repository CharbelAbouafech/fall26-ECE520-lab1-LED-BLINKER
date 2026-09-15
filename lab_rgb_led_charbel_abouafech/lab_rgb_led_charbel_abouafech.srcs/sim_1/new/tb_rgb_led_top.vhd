----------------------------------------------------------------------------------
-- Name: Charbel Abou Afech
-- Create Date: 09/14/2026 04:56:52 PM
-- Design Name: testbench for rgb_led_top
-- Module Name: tb_rgb_led_top - Behavioral 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity tb_rgb_led_top is
end entity tb_rgb_led_top;
 
architecture sim of tb_rgb_led_top is
 
    -- 125 MHz -> period = 1 / 125e6 = 8 ns
    constant CLK_PERIOD        : time    := 8 ns;
    constant CYCLES_PER_TOGGLE : integer := 10;
 
    signal sys_clk  : std_logic := '0';
    signal rst      : std_logic := '1';
    signal sw       : std_logic_vector(2 downto 0) := "000";
    signal rgb_out  : std_logic_vector(2 downto 0);
 
    signal sim_done : boolean := false;
 
begin
    DUT : entity work.rgb_led_top
        generic map (
            CLK_CYCLES_PER_TOGGLE => CYCLES_PER_TOGGLE
        )
        port map (
            sys_clk => sys_clk,
            rst     => rst,
            sw      => sw,
            rgb_out => rgb_out
        );

    clk_gen : process
    begin
        while not sim_done loop
            sys_clk <= '0';
            wait for CLK_PERIOD / 2;
            sys_clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process clk_gen;
 
    test : process
    begin
        report "Test case 1: Reset Behavior - rst=1, sw=000";
        rst <= '1';
        sw  <= "000";
        wait for 5 * CLK_PERIOD;
 
        report "Test case 2: Red selected - sw=001";
        rst <= '0';
        sw  <= "001";
        wait for 25 * CLK_PERIOD;
 
        report "Test case 3: Green selected - sw=010";
        sw <= "010";
        wait for 25 * CLK_PERIOD;
 
        report "Test case 4: Blue selected - sw=100";
        sw <= "100";
        wait for 25 * CLK_PERIOD;
 
        report "Test case 5: Multiple switches active - sw=011 (LED must be off)";
        sw <= "011";
        wait for 15 * CLK_PERIOD;
 
        report "Test case 6: No switches active - sw=000 (LED must be off)";
        sw <= "000";
        wait for 10 * CLK_PERIOD;
 
        report "Test case 7: All switches active - sw=111 (LED must be off)";
        sw <= "111";
        wait for 10 * CLK_PERIOD;
 
        report "Test case 8: Direct color-to-color switch - Red then immediately Blue";
        sw <= "001";
        wait for 15 * CLK_PERIOD;
        sw <= "100";
        wait for 15 * CLK_PERIOD;
 
        report "Simulation complete";
        sim_done <= true;
        wait;
    end process test;
    
end architecture sim;
 