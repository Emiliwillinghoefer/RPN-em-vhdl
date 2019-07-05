library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity bin2bcd_12bit is
    Port (
			 sw : in std_logic_vector(7 downto 0);
			 
			 ones0 : out std_logic;
			 ones1 : out std_logic;
			 ones2 : out std_logic;
			 ones3 : out std_logic;
			 
			 tens0 : out std_logic;
			 tens1 : out std_logic;
			 tens2 : out std_logic;
			 tens3 : out std_logic;
			 
			 hundreds0 : out std_logic;
			 hundreds1 : out std_logic;
			 hundreds2 : out std_logic;
			 hundreds3 : out std_logic;
			 
			 thousands0 : out std_logic;
			 thousands1 : out std_logic;
			 thousands2 : out std_logic;
			 thousands3 : out std_logic);
end bin2bcd_12bit;

architecture Behavioral of bin2bcd_12bit is
begin
  bcd1: process(sw(0),sw(1),sw(2),sw(3),sw(4),sw(5),sw(6),sw(7),sw(8),sw(9))

	variable binIN: std_logic_vector(11 downto 0);
   variable bcd : UNSIGNED (15 downto 0) := (others => '0');
  begin
    bcd := (others => '0');
	 	binIN(0):=sw(0);
		binIN(1):=sw(1);
		binIN(2):=sw(2);
		binIN(3):=sw(3);
		binIN(4):=sw(4);
		binIN(5):=sw(5);
		binIN(6):=sw(6);
		binIN(7):=sw(7);
		binIN(8):= '0';
		binIN(9):= '0';
		binIN(10):= '0';
		binIN(11):= '0';
	 
	 
    for i in 0 to 11 loop
    
      if bcd(3 downto 0) > 4 then 
        bcd(3 downto 0) := bcd(3 downto 0) + 3;
      end if;
      
      if bcd(7 downto 4) > 4 then 
        bcd(7 downto 4) := bcd(7 downto 4) + 3;
      end if;
    
      if bcd(11 downto 8) > 4 then  
        bcd(11 downto 8) := bcd(11 downto 8) + 3;
      end if;

      bcd := bcd(14 downto 0) & binIN(11);
    
      binIN := binIN(10 downto 0) & '0';
    
    end loop;
 
    ones0 <= bcd(0);
	 ones1 <= bcd(1);
	 ones2 <= bcd(2);
	 ones3 <= bcd(3);
	 
	 tens0 <= bcd(4);
	 tens1 <= bcd(5);
	 tens2 <= bcd(6);
	 tens3 <= bcd(7);
	 
	 hundreds0 <= bcd(8);
	 hundreds1 <= bcd(9);
	 hundreds2 <= bcd(10);
	 hundreds3 <= bcd(11);
	 
	 thousands0 <= bcd(12);
	 thousands1 <= bcd(13);
	 thousands2 <= bcd(14);
	 thousands3 <= bcd(15);
  
  end process bcd1;            
  
end Behavioral;