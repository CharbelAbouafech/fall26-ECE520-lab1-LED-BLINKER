----------------------------------------------------------------------------------
-- Name: Charbel Abou Afech
-- Create Date: 09/14/2026 04:40:24 PM
-- Design Name: lab_rgb_led
-- Module Name: rgb_led_top - Behavioral
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
 
entity rgb_led_top is
    generic (
        CLK_CYCLES_PER_TOGGLE : integer := 62_500_000  -- 0.5 s @ 125 MHz
    );
    port (
        sys_clk  : in  std_logic;                      -- 125 MHz system clock
        rst      : in  std_logic;                       -- active-high synchronous reset
        sw       : in  std_logic_vector(2 downto 0);     -- SW2-SW0 color select
        rgb_out  : out std_logic_vector(2 downto 0)      -- [0]=Red [1]=Green [2]=Blue
    );
end entity rgb_led_top;
 
architecture rtl of rgb_led_top is
 
    -- Exactly one switch active => valid color selection => enable the blinker.
    -- Any other combination (all off, or 2+ on) => disabled => LED off.
    signal color_valid : std_logic;
    signal blink_pulse  : std_logic;
 
begin
 
    color_valid <= '1' when (sw = "001") or (sw = "010") or (sw = "100") else '0';
 
    u_blinkingled : entity work.blinking_led
        generic map (
            CLK_CYCLES_PER_TOGGLE => CLK_CYCLES_PER_TOGGLE
        )
        port map (
            sys_clk => sys_clk,
            rst     => rst,
            led_en  => color_valid,
            led_out => blink_pulse
        );
    process (sw, blink_pulse)
    begin
        rgb_out <= (others => '0');
        case sw is
            when "001" => rgb_out(0) <= blink_pulse;  -- Red
            when "010" => rgb_out(1) <= blink_pulse;  -- Green
            when "100" => rgb_out(2) <= blink_pulse;  -- Blue
            when others => rgb_out <= (others => '0'); -- off
        end case;
    end process;
 
end architecture rtl;
