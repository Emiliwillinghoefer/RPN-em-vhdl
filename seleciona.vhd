library IEEE;
use IEEE.std_logic_1164.all;


entity seleciona is
port(entrada: in std_logic_vector(25 downto 0);
		saida: out std_logic);
end entity;

architecture sana of seleciona is

begin 

	saida<=entrada(16);
end architecture ;