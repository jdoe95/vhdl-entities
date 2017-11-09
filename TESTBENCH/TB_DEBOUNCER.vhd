library ieee;
use ieee.std_logic_1164.all;

-- Dependency
-- DEBOUNCER.vhd

-- Recommended Runtime
-- 150 ms

---------------------------------------------------------------------------
entity TB_DEBOUNCER is
end entity;

---------------------------------------------------------------------------
architecture TB_DEBOUNCER_ARC of TB_DEBOUNCER is

	-- signals
	signal CLOCK, DEBOUNCED : std_logic := '0';
	signal BOUNCE : std_logic := '1';
	
begin

	UUT: entity work.DEBOUNCER 
		port map( BUTTON => BOUNCE, DEBOUNCED => DEBOUNCED, CLOCK => CLOCK );

	GEN_CLOCK: process
	begin
		
		CLOCK <= '0';
		wait for 500 us;
		
		CLOCK <= '1';
		wait for 500 us;
	
	end process;
	
	GEN_BOUNCE: process
	begin
		
		-- BOUNCE SEQUENCE
		BOUNCE <= '0';
		wait for 1 ms;
		BOUNCE <= '1';
		wait for 2 ms;
		BOUNCE <= '0';
		wait for 3 ms;
		BOUNCE <= '1';
		wait for 100 us;
		BOUNCE <= '0';
		wait for 1 ms;
		BOUNCE <= '1';
		wait for 3 ms;
		BOUNCE <= '0';
		wait for 2 ms;
		BOUNCE <= '1';
		wait for 100 us;
		BOUNCE <= '0';
		wait for 3 ms;
		BOUNCE <= '1';
		wait for 1 ms;
		BOUNCE <= '0';
		wait for 1 ms;
		BOUNCE <= '1';
		wait for 2 ms;
		BOUNCE <= '0';
		wait for 3 ms;
		BOUNCE <= '1';
		wait for 100 us;
		--END OF BOUNCE SEQUENCE
		
		BOUNCE <= '0';
		wait for 50 ms;
		
		-- BOUNCE SEQUENCE
		BOUNCE <= '0';
		wait for 1 ms;
		BOUNCE <= '1';
		wait for 2 ms;
		BOUNCE <= '0';
		wait for 3 ms;
		BOUNCE <= '1';
		wait for 100 us;
		BOUNCE <= '0';
		wait for 1 ms;
		BOUNCE <= '1';
		wait for 3 ms;
		BOUNCE <= '0';
		wait for 2 ms;
		BOUNCE <= '1';
		wait for 100 us;
		BOUNCE <= '0';
		wait for 3 ms;
		BOUNCE <= '1';
		wait for 1 ms;
		BOUNCE <= '0';
		wait for 1 ms;
		BOUNCE <= '1';
		wait for 2 ms;
		BOUNCE <= '0';
		wait for 3 ms;
		BOUNCE <= '1';
		wait for 100 us;
		--END OF BOUNCE SEQUENCE
		
		BOUNCE <= '1';
		wait for 50 ms;
		
	end process;

end architecture;
