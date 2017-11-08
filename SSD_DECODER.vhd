library ieee;
use ieee.std_logic_1164.all;

-- Dependency:
-- None.

-- Description:
-- Output corresponding display pattern to SEGMENT based on CODE input.
--     When POINT is active, the decimal point will light up on the display.
--     When SHUTDOWN is active, the display will turn off regardless of the 
--         status of CODE and POINT.
--     When TEST is active, all the segments on the display as well as the
--         decimal point will light up regardless of the status of CODE,
--         SHUTDOWN and POINT.
--     SEGMENT(7 downto 0) order: DP G F E D C B A
---------------------------------------------------------------------------
entity SSD_DECODER is 
	port( 
		CODE : in std_logic_vector(3 downto 0);
		POINT, SHUTDOWN, TEST: in std_logic := '0';
		SEGMENT: out std_logic_vector(7 downto 0)
	);
end entity;
---------------------------------------------------------------------------
architecture COMMON_ANODE of SSD_DECODER is
begin

	process( CODE, POINT, SHUTDOWN, TEST )
	begin
		
		-- test mode
		if TEST = '1' then
			SEGMENT <= "00000000";
		
		-- shutdown mode
		elsif SHUTDOWN = '1' then 
			SEGMENT <= "11111111";
		
		-- normal operation
		else
			-- the decimal point
			if POINT = '1' then
				SEGMENT(7) <= '0';
			else 
				SEGMENT(7) <= '1';
			end if;
			
			-- the segments
			case CODE is
				when "0000" => SEGMENT(6 downto 0) <= "1000000"; -- '0'
				when "0001" => SEGMENT(6 downto 0) <= "1111001"; -- '1'
				when "0010" => SEGMENT(6 downto 0) <= "0100100"; -- '2'
				when "0011" => SEGMENT(6 downto 0) <= "0110000"; -- '3'
				when "0100" => SEGMENT(6 downto 0) <= "0011001"; -- '4'
				when "0101" => SEGMENT(6 downto 0) <= "0010010"; -- '5'
				when "0110" => SEGMENT(6 downto 0) <= "0000010"; -- '6'
				when "0111" => SEGMENT(6 downto 0) <= "1111000"; -- '7'
				when "1000" => SEGMENT(6 downto 0) <= "0000000"; -- '8'
				when "1001" => SEGMENT(6 downto 0) <= "0010000"; -- '9'
				when "1010" => SEGMENT(6 downto 0) <= "0111111"; -- '-' (dash)
				when others => SEGMENT(6 downto 0) <= "UUUUUUU";
			end case;
		end if;
		
	end process;
		
end architecture;

---------------------------------------------------------------------------
architecture COMMON_CATHODE of SSD_DECODER is
begin

	process( CODE, POINT, SHUTDOWN, TEST )
	begin
		
		-- test mode
		if TEST = '1' then
			SEGMENT <= "11111111";
		
		-- shutdown mode
		elsif SHUTDOWN = '1' then 
			SEGMENT <= "00000000";
		
		-- normal operation
		else
			-- the decimal point
			if POINT = '1' then
				SEGMENT(7) <= '1';
			else 
				SEGMENT(7) <= '0';
			end if;
			
			-- the segments
			case CODE is
				when "0000" => SEGMENT(6 downto 0) <= "0111111"; -- '0'
				when "0001" => SEGMENT(6 downto 0) <= "0000110"; -- '1'
				when "0010" => SEGMENT(6 downto 0) <= "1011011"; -- '2'
				when "0011" => SEGMENT(6 downto 0) <= "1001111"; -- '3'
				when "0100" => SEGMENT(6 downto 0) <= "1100110"; -- '4'
				when "0101" => SEGMENT(6 downto 0) <= "1101101"; -- '5'
				when "0110" => SEGMENT(6 downto 0) <= "1111101"; -- '6'
				when "0111" => SEGMENT(6 downto 0) <= "0000111"; -- '7'
				when "1000" => SEGMENT(6 downto 0) <= "1111111"; -- '8'
				when "1001" => SEGMENT(6 downto 0) <= "1101111"; -- '9'
				when "1010" => SEGMENT(6 downto 0) <= "1000000"; -- '-' (dash)
				when others => SEGMENT(6 downto 0) <= "UUUUUUU";
			end case;
		end if;
		
	end process;
		
end architecture;
