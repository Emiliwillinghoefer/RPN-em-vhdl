library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all; 
entity divisor is 
port(
		c_in : in std_logic_vector(7 downto 0);
		
		s0,s1,s2,s3,s4,s5,s6,s7 : out std_logic
		);
    
end entity;

architecture divide of divisor is	 
		signal constante: integer;
		signal recebe: integer;
		signal s: integer;
		signal result: std_logic_vector(7 downto 0);
	begin
	
	 ---define qual vai ser o valor constante que passa dividindo 
	 constante<=10;
   
	 s<= to_integer(signed(c_in));
		
    recebe<= s/constante;

  
		result <= std_logic_vector(to_signed(recebe,result'length));

		s0 <= result(0);
		s1 <= result(1);
		s2 <= result(2);
		s3 <= result(3);
		s4 <= result(4);
		s5 <= result(5);
		s6 <= result(6);
		s7 <= result(7);
		
	
end architecture;