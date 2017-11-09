library ieee;
use ieee.std_logic_1164.all;

-- Dependency:
-- SSD_DECODER.vhd

-- Recommended Runtime:
-- 4800 ns

---------------------------------------------------------------------------
entity TB_SSD_DECODER is
end entity;

---------------------------------------------------------------------------
architecture TB_SSD_DECODER_ARC of TB_SSD_DECODER is

	-- signals
	signal CODE: std_logic_vector(3 downto 0) := (others =>'0');
	signal POINT, SHUTDOWN, TEST: std_logic := '0';
	signal SEGMENT: std_logic_vector(7 downto 0);
	
	-- constants
	constant PERIOD: time := 200 ns;

begin
	UUT: entity work.SSD_DECODER(COMMON_ANODE)
		port map( 
			CODE => CODE,
			POINT => POINT, 
			SHUTDOWN => SHUTDOWN,
			TEST => TEST,
			SEGMENT => SEGMENT
		);
	
	process
	begin
		
		-- test test
		TEST <= '1';
		SHUTDOWN <= '1';
		wait for PERIOD;
		
		-- test shutdown
		TEST <= '0';
		SHUTDOWN <= '1';
		wait for PERIOD;
		
		-- test segments
		TEST <= '0';
		SHUTDOWN <= '0';
		POINT <= '0';
		
		CODE <= "0000";
		wait for PERIOD;
		
		CODE <= "0001";
		wait for PERIOD;
		
		CODE <= "0010";
		wait for PERIOD;
		
		CODE <= "0011";
		wait for PERIOD;
		
		CODE <= "0100";
		wait for PERIOD;
		
		CODE <= "0101";
		wait for PERIOD;
		
		CODE <= "0110";
		wait for PERIOD;
		
		CODE <= "0111";
		wait for PERIOD;
		
		CODE <= "1000";
		wait for PERIOD;
		
		CODE <= "1001";
		wait for PERIOD;
		
		CODE <= "1010";
		wait for PERIOD;
		
		-- test decimal point
		TEST <= '0';
		SHUTDOWN <= '0';
		POINT <= '1';
		
		CODE <= "0000";
		wait for PERIOD;
		
		CODE <= "0001";
		wait for PERIOD;
		
		CODE <= "0010";
		wait for PERIOD;
		
		CODE <= "0011";
		wait for PERIOD;
		
		CODE <= "0100";
		wait for PERIOD;
		
		CODE <= "0101";
		wait for PERIOD;
		
		CODE <= "0110";
		wait for PERIOD;
		
		CODE <= "0111";
		wait for PERIOD;
		
		CODE <= "1000";
		wait for PERIOD;
		
		CODE <= "1001";
		wait for PERIOD;
		
		CODE <= "1010";
		wait for PERIOD;
		
		
	end process;
	
end architecture;
