library ieee;
use ieee.std_logic_1164.all;

-- Dependency:
-- CLOCK_DIVIDER.vhd

-- Recommended Runtime:
-- 2000 ns

---------------------------------------------------------------------------
entity TB_CLOCK_DIVIDER is
end entity;

---------------------------------------------------------------------------
architecture TB_CLOCK_DIVIDER_ARC of TB_CLOCK_DIVIDER is
	
	-- unit under test
	component CLOCK_DIVIDER is
		generic(
			MAX_COUNTER: positive := 1
		);
		
		port(
			CLOCK_IN: in std_logic;
			CLOCK_OUT: out std_logic
		);
	end component;
	
	-- signals
	signal CLOCK_IN, CLOCK_OUT: std_logic := '0';
	
	-- constants
	constant HALF_PERIOD: time := 100 ns;
	
begin
	
	UUT: component CLOCK_DIVIDER
		generic map(
			MAX_COUNTER => 2
		)
		
		port map(
			CLOCK_IN => CLOCK_IN,
			CLOCK_OUT => CLOCK_OUT
		);

	-- input clock generation
	CLOCK_GEN: process
	begin
		
		CLOCK_IN <= '0';
		wait for HALF_PERIOD;
		
		CLOCK_IN <= '1';
		wait for HALF_PERIOD;
	end process;

end architecture;
