library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity tb_blinking_led is
end entity tb_blinking_led;
 
architecture sim of tb_blinking_led is
 
    -- 125 MHz  ->  period = 1 / 125e6 = 8 ns
    constant CLK_PERIOD        : time    := 8 ns;
    constant CYCLES_PER_TOGGLE : integer := 10;
 
    signal sys_clk  : std_logic := '0';
    signal rst      : std_logic := '1';
    signal led_en   : std_logic := '0';
    signal led_out  : std_logic;
 
    signal sim_done : boolean := false;
 
begin
    -- DUT instantiation
    DUT : entity work.blinking_led
        generic map (
            CLK_CYCLES_PER_TOGGLE => CYCLES_PER_TOGGLE
        )
        port map (
            sys_clk => sys_clk,
            rst     => rst,
            led_en  => led_en,
            led_out => led_out
        );
 
    -- Free-running 125 MHz clock
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
 
    -- Stimulus
    test : process
    begin
        report "Test Case 1: Reset Behavior - rst=1, led_en=0";
        rst    <= '1';
        led_en <= '0';
        wait for 5 * CLK_PERIOD;              -- hold reset for 5 clock cycles
 
        report "Test Case 2: Disabled Output - rst=0, led_en=0";
        rst <= '0';
        wait for 5 * CLK_PERIOD;              -- reset released, still disabled
 
        report "Test Case 3: LED Toggling - led_en=1";
        led_en <= '1';
        wait for 45 * CLK_PERIOD;             -- allow several toggle periods
 
        report "Test Case 3 (cont.): Disable mid-blink to force led_out low";
        led_en <= '0';
        wait for 5 * CLK_PERIOD;
 
        report "Re-enable and continue toggling";
        led_en <= '1';
        wait for 30 * CLK_PERIOD;
 
        report "Simulation complete";
        sim_done <= true;
        wait;
    end process test;
 
end architecture sim;