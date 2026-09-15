----------------------------------------------------------------------------------
-- Name: Charbel Abou Afech
-- Create Date: 09/14/2026 04:00:09 PM
-- Design Name: LAB 1 - BLINKING LED
-- Module Name: blinking_led - Behavioral
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity blinking_led is
    generic (
        CLK_CYCLES_PER_TOGGLE : integer := 62_500_000
    );
    port (
        sys_clk  : in  std_logic;
        rst      : in  std_logic;
        led_en   : in  std_logic;
        led_out  : out std_logic
    );
end entity blinking_led;

architecture Behavioral of blinking_led is
    signal counter   : unsigned(31 downto 0) := (others => '0');
    signal led_out_i : std_logic := '0';

begin

    process (sys_clk)
    begin
        if rising_edge(sys_clk) then
            if (rst = '1') or (led_en = '0') then
                counter   <= (others => '0');
                led_out_i <= '0';
            else
                if counter = to_unsigned(CLK_CYCLES_PER_TOGGLE - 1, counter'length) then
                    counter   <= (others => '0');
                    led_out_i <= not led_out_i;
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;

    led_out <= led_out_i;

end Behavioral;
