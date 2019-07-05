library IEEE;
use IEEE.std_logic_1164.all;

entity bcd_2_7segment is
    port (
			 sw0 : in std_logic;
			 sw1 : in std_logic;
			 sw2 : in std_logic;
			 sw3 : in std_logic;
			 ss0 : out std_logic;
			 ss1 : out std_logic;
			 ss2 : out std_logic;
			 ss3 : out std_logic;
			 ss4 : out std_logic;
			 ss5 : out std_logic;
			 ss6 : out std_logic);
end bcd_2_7segment;

architecture comportamento of bcd_2_7segment is
	signal bcd      : std_logic_vector(3 downto 0);
	signal segments : std_logic_vector(6 downto 0) := (others => '0');
begin
	bcd(0)<= sw0;
	bcd(1)<= sw1;
	bcd(2)<= sw2;
	bcd(3)<= sw3;
	with bcd select
		segments <= "1111110" when "0000", 
						"0110000" when "0001", 
						"1101101" when "0010", 
						"1111001" when "0011", 
						"0110011" when "0100", 
						"1011011" when "0101", 
						"1011111" when "0110", 
						"1110000" when "0111", 	
						"1111111" when "1000", 
						"1111011" when "1001", 
						"1110111" when "1010", 
						"0011111" when "1011", 
						"1001111" when "1100", 
						"0111101" when "1101", 
						"1001111" when "1110",
						"1011111" when others;
		ss0 <= not(segments(0));
		ss1 <= not(segments(1));
		ss2 <= not(segments(2));
		ss3 <= not(segments(3));
		ss4 <= not(segments(4));
		ss5 <= not(segments(5));
		ss6 <= not(segments(6));	
end architecture;