library ieee;
use ieee.std_logic_1164.all;

-- Dependency
-- VGA_TIMING_GENERATOR.vhd

-- Recommended Runtime
-- 20 ms

---------------------------------------------------------------------------
entity TB_VGA_TIMING_GENERATOR is
end entity;

---------------------------------------------------------------------------
architecture TB_VGA_TIMING_GENERATOR_ARC of TB_VGA_TIMING_GENERATOR is

	-- signal definitions
	signal HSYNC, VSYNC, BLANK, CLOCK : std_logic;
	signal COUNTER_X, COUNTER_Y: natural;
	
begin

	-- unit under test
	UUT: entity work.VGA_TIMING_GENERATOR
		port map(
			HSYNC => HSYNC,
			VSYNC => VSYNC,
			BLANK => BLANK,
			CLOCK => CLOCK,
			COUNTER_X => COUNTER_X,
			COUNTER_Y => COUNTER_Y
		);
	
	-- pixel clock generation
	CLOCK_GENERATION: process
	begin
		
		CLOCK <= '0';
		wait for 40 ns;
		
		CLOCK <= '1';
		wait for 40 ns;
		
	end process;
	
end architecture;
