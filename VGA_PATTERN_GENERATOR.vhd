library ieee;
use ieee.std_logic_1164.all;

-- Dependency:
-- None.

-- Description:
-- Generate a pattern on the VGA screen. The RGB value will be generated
--     based on COUNTER_X, COUNTER_Y, and BLANK.
--     A Yellow Rectangle will be displayed on a blue background.
--     Detailed parameters are specified as generics.
---------------------------------------------------------------------------
entity VGA_PATTERN_GENERATOR is
	generic(
		BLANK_ACT: std_logic := '0';	-- BLANK signal active level
		COLOR_DEPTH: positive := 8;		-- Width of R, G, and B bus
		RECT_X_LEN: natural := 320;		-- X length of the rectangle
		RECT_Y_LEN: natural := 240		-- Y length of the rectangle
	);
	
	port(
		COUNTER_X, COUNTER_Y: in natural := 0;
		BLANK: in std_logic;
		R, G, B: out std_logic_vector(COLOR_DEPTH-1 downto 0)
	);
end entity;
---------------------------------------------------------------------------
architecture VGA_PATTERN_GENERATOR_ARC of VGA_PATTERN_GENERATOR is
begin

	process( COUNTER_X, COUNTER_Y, BLANK )
	begin
		
		if BLANK = BLANK_ACT then
			R <= (others => '0');
			G <= (others => '0');
			B <= (others => '0');
			
		elsif (COUNTER_X < RECT_X_LEN) and (COUNTER_Y < RECT_Y_LEN) then
			R <= (others => '1');
			G <= (others => '1');
			B <= (others => '0');
			
		else
			R <= (others => '0');
			G <= (others => '0');
			B <= (others => '1');
		
		end if;
		
	end process;
	
end architecture;
