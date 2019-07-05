library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all; 

entity pilha is
  Port ( 
			CLK: in std_logic;
			SUB: in std_logic;
			DATA_IN : in std_logic_vector(7 downto 0);
			POP : in std_logic;
			PUSH : in std_logic;
			DIV : in std_logic;
			MULT : in std_logic;
			SOMA : in std_logic;
			DATA_OUT : out std_logic_vector(7 downto 0));
end entity;

architecture principal of pilha is
	type DATA_ARRAY is array (integer range <>) of std_logic_vector(0 to 7);
	type tipo_estado is(A,B,C,D,E,F,G,H);
	signal DATA: DATA_ARRAY (0 to 7);
	SIGNAL estado : tipo_estado;
	
BEGIN
	PROCESS (CLK, estado)
	variable PTR: integer range -1 to 8;
	variable AUX: INTEGER;
		BEGIN
			IF SOMA = '0' and SUB = '0' THEN -- estado inicial
				estado <= A;
				PTR:= 0;
				DATA <=(others =>(others => '0'));
				DATA_OUT <=(others => '0');
				
			ELSIF (CLK'EVENT and CLK ='1') THEN -- ciclo de estados
				CASE estado IS
							
					WHEN A => -- INTERMEDIARIO
						IF PUSH = '1' THEN 
							estado <= B;
						ELSIF POP = '1' THEN 
							estado <= C;
						ELSIF DIV = '0' AND MULT = '0' THEN 
							estado <= H;
						ELSIF SOMA = '0' THEN 
							estado <= E;							
						ELSIF DIV = '0' THEN 
							estado <= F;
						ELSIF MULT = '0' THEN 
							estado <= G;
						ELSIF SUB = '0' THEN 
							estado <= H;
						else estado<=A;
						END IF;

					WHEN B => -- Estado de Push
						IF PTR /= 7 THEN
							DATA(PTR) <= DATA_IN;
							PTR := (PTR+1);
							estado <= D;
						ELSE estado <= A;
						END IF;
						
					WHEN C => -- Estado de Pop
						IF PTR /= 0 THEN
							PTR := (PTR-1);
							estado <= D;
						ELSIF PTR = 0 THEN 
							DATA(PTR) <= (others => '0');
							estado <= A;
						ELSE estado <= A;
						END IF;
						
					WHEN D => --Estado de espera	
						IF PUSH = '1' THEN	
							estado <= D;
						ELSIF POP = '1' THEN
							estado <= D;
						ELSIF SOMA = '0' THEN
							estado <= D;
						ELSIF DIV = '0' THEN
							estado <= D;
						ELSIF MULT = '0' THEN
							estado <= D;
						ELSIF SUB = '0' THEN
							estado <= D;
						ELSIF PUSH = '0' AND POP = '0' AND DIV = '1' AND MULT = '1' AND SOMA = '1' AND SUB = '1' THEN 
							estado <= A;
						ELSE 
							estado <= A;
						END IF;
					
					
					WHEN E => --SOMA
						IF PTR > 1 THEN 
							AUX :=  (to_integer(signed(DATA(PTR-1)))) + (to_integer(signed(DATA(PTR-2))));
							DATA(PTR-2) <= std_logic_vector(to_unsigned(AUX,DATA'length));
							PTR := (PTR-1);
							AUX := 0;
							estado <= D;
						ELSE 
							estado <= A;
						end if;						
						
								
					WHEN F =>--DIVISÃO
						IF PTR > 1 THEN 
							AUX := (to_integer(unsigned(DATA(PTR-2)))) / (to_integer(unsigned(DATA(PTR-1))));
							DATA(PTR-2) <= std_logic_vector(to_unsigned(AUX,DATA'length));
							PTR := (PTR-1);
							AUX := 0;
							estado <= D;
						ELSE 
							estado <= A;
						end if;
						
					WHEN G =>--MULTIPLICAÇÃO
						IF PTR > 1 THEN 
							AUX := (to_integer(signed(DATA(PTR-1)))) * (to_integer(signed(DATA(PTR-2))));
							DATA(PTR-2) <= std_logic_vector(to_unsigned(AUX,DATA'length));
							PTR := (PTR-1);
							AUX := 0;
							estado <= D;
						ELSE 
							estado <= A;
						end if;
						
					WHEN H =>--SUBTRAÇÃO
						IF PTR > 1 THEN						
							AUX :=  (to_integer(signed(DATA(PTR-2)))) - (to_integer(signed(DATA(PTR-1))));
							DATA(PTR-2) <= std_logic_vector(to_unsigned(AUX,DATA'length));
							PTR := (PTR-1);
							AUX := 0;
							estado <= D;
						ELSE 
							estado <= A;
						end if;
					WHEN OTHERS =>
						estado <= A;
				END CASE;
			END IF;
			DATA_OUT <= DATA(PTR-1);
		END PROCESS;
end architecture;