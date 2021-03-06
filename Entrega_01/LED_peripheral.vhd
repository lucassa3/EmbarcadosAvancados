library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity LED_peripheral is
	generic (
		counter_limit : integer range 0 to 25000000 := 10000000
	);
	
	port( 
		clk 			:   in  std_logic;             -- clock.clk
		enable 		:   in std_logic;
		switches    :   in std_logic_vector(3 downto 0);
		led_out     :   out std_logic_vector(5 downto 0)
	);
end entity;

architecture bhv of LED_peripheral is

-- signal
signal blink : std_logic := '0';

begin

	process(clk,switches) 
		variable sw0, sw1, sw2, sw3 : integer := 0;
      variable counter : integer range 0 to 25000000 := 0;
      begin
		  if (switches(0) = '1') then sw0 := 1; else sw0 := 0; end if;
		  if (switches(1) = '1') then sw1 := 1; else sw1 := 0; end if;
		  if (switches(2) = '1') then sw2 := 1; else sw2 := 0; end if;
		  if (switches(3) = '1') then sw3 := 1; else sw3 := 0; end if;

        if (rising_edge(clk) and enable='0') then
                  if (counter < counter_limit/(1+sw0+sw1+sw2+sw3)) then
                      counter := counter + 1;
                  else
							blink <= not blink;
                     counter := 0;
                  end if;
        end if;
  end process;

  led_out(0) <= blink;
  led_out(1) <= blink;
  led_out(2) <= blink;
  led_out(3) <= blink;
  led_out(4) <= blink;
  led_out(5) <= blink;


end architecture;
