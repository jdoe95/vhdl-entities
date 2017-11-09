library ieee;
use ieee.std_logic_1164.all;

-- Denpendency:
-- None.

-- Description:
-- Generate the timing for a VGA monitor
--     Detailed parameters are specified as generics.
--     https://eewiki.net/pages/viewpage.action?pageId=15925278
---------------------------------------------------------------------------
entity VGA_TIMING_GENERATOR is

	generic(
		RES_X : positive := 640;			-- Resolution X
		RES_Y : positive := 480;			-- Resolution Y
		H_FRONT_PORCH: positive := 16;		-- Horizontal front porch
		H_SYNC_PULSE : positive := 96;		-- Horizontal sync pulse
		H_BACK_PORCH : positive := 48;		-- Horizontal back porch
		V_FRONT_PORCH: positive := 10;		-- Vertical front porch
		V_SYNC_PULSE : positive := 2;		-- Vertical sync pulse
		V_BACK_PORCH : positive := 33;		-- Vertical back porch
		H_SYNC_ACT: std_logic := '0';		-- Horizontal sync pulse active level
		V_SYNC_ACT: std_logic := '0';		-- Vertical sync pulse active level
		BLANK_ACT: std_logic := '0'			-- Blanking active level
	);

	port( 
		HSYNC, VSYNC: out std_logic;		-- Horizontal sync and vertical sync output
		BLANK: out std_logic;				-- Blanking output
		COUNTER_X, COUNTER_Y: out natural;	-- X and Y counter
		CLOCK: in std_logic					-- Pixel clock
	);

end entity;
---------------------------------------------------------------------------
architecture VGA_TIMING_GENERATOR_ARC of VGA_TIMING_GENERATOR is
	signal COUNTER_X_BUFFER, COUNTER_Y_BUFFER : natural := 0;
begin

	-- X, Y counter buffer update
	process(CLOCK)
		variable COUNTER_X_TEMP, COUNTER_Y_TEMP : natural := 0;
	begin
		
		if rising_edge(CLOCK) then
			COUNTER_X_TEMP := COUNTER_X_TEMP + 1;
			
			if COUNTER_X_TEMP = RES_X + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH then
				COUNTER_X_TEMP := 0;
				COUNTER_Y_TEMP := COUNTER_Y_TEMP + 1;
				
				if COUNTER_Y_TEMP = RES_Y + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH then
					COUNTER_Y_TEMP := 0;
				end if;
				
			end if;
			
		end if;
		
		COUNTER_X_BUFFER <= COUNTER_X_TEMP;
		COUNTER_Y_BUFFER <= COUNTER_Y_TEMP;
		
	end process;
	
	-- X, Y counter update
	COUNTER_X <= COUNTER_X_BUFFER;
	COUNTER_Y <= COUNTER_Y_BUFFER;
	
	-- HSYNC, VSYNC update
	HSYNC <= H_SYNC_ACT when (COUNTER_X_BUFFER >= RES_X + H_FRONT_PORCH) 
								and (COUNTER_X_BUFFER < RES_X + H_FRONT_PORCH + H_SYNC_PULSE) else
			 not H_SYNC_ACT;
			 
	VSYNC <= V_SYNC_ACT when (COUNTER_Y_BUFFER >= RES_Y + V_FRONT_PORCH)
								and (COUNTER_Y_BUFFER < RES_Y + V_FRONT_PORCH + V_SYNC_PULSE) else
			 not V_SYNC_ACT;
	
	-- Blanking
	BLANK <= not BLANK_ACT when (COUNTER_X_BUFFER < RES_X) and (COUNTER_Y_BUFFER < RES_Y) else
			 BLANK_ACT;
	
end architecture;



