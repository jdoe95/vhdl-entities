library ieee;
use ieee.std_logic_1164.all;

-- Dependency:
-- None.

-- Description:
-- Divide input clock by number of rising edge.
--     Number of rising edges is specified as a generic parameter.
---------------------------------------------------------------------------
entity CLOCK_DIVIDER is
	generic(
		MAX_COUNTER: positive := 1
	);
	
	port(
		CLOCK_IN: in std_logic;
		CLOCK_OUT: out std_logic
	);
end entity;
---------------------------------------------------------------------------
architecture CLOCK_DIVIDER_ARC of CLOCK_DIVIDER is
begin

	process( CLOCK_IN )
		variable COUNTER: natural := 0;
		variable CLOCK_OUT_TEMP: std_logic := '0';
	begin
		
		if rising_edge(CLOCK_IN) then
			COUNTER := COUNTER + 1;
			
			if COUNTER = MAX_COUNTER then
				COUNTER := 0;
				
				CLOCK_OUT_TEMP := not CLOCK_OUT_TEMP;
			end if;
			
		end if;
		
		CLOCK_OUT <= CLOCK_OUT_TEMP;
		
	end process;	
	
end architecture;
