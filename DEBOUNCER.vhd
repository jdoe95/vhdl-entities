library ieee;
use ieee.std_logic_1164.all;

-- Dependency 
-- None.

-- Description:
-- Debounce a bouncing button
--     BUTTON is the bouncing input, DEBOUNCED is the debounced output
--     CLOCK and DEBOUNCE_CYCLES define the stable timeout
---------------------------------------------------------------------------
entity DEBOUNCER is 
	generic( DEBOUNCE_CYCLES: positive := 10 );
	port( BUTTON, CLOCK: in std_logic;
			DEBOUNCED: out std_logic);
end entity;
---------------------------------------------------------------------------
architecture DEBOUNDER_ARC of DEBOUNCER is
begin

	process( BUTTON, CLOCK )
		variable COUNTER : integer := 0;
		variable OLD_BUTTON: std_logic := '0';
	begin
	
		if OLD_BUTTON /= BUTTON then
			OLD_BUTTON := BUTTON;
			COUNTER := 0;
			
		else
			
			if rising_edge(CLOCK) then
				COUNTER := COUNTER + 1;
				
				if COUNTER > DEBOUNCE_CYCLES then
					DEBOUNCED <= BUTTON;
				end if;
				
			end if;
		end if;
		
	end process;
	
end architecture;
