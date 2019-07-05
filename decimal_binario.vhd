library IEEE;
use IEEE.std_logic_1164.all;


entity dec_to_bin is

	port (
    	dec3, dec2, dec1, dec0 : in integer;
        bin1, bin2, bin3, bin4, bin5, bin6, bin7, bin8 : out std_logic
    );

end entity;


architecture arc78 of dec_to_bin is	
	 signal mods : std_logic_vector(7 downto 0);

begin

	process (dec3, dec2, dec1, dec0)
    	 
        variable dec_aux : integer range 0 to 1023;
        variable i : integer;
        
    begin
    
		mods <= "00000000";
		dec_aux := (dec3 * 1000) + (dec2 * 100) + (dec1 * 10) + dec0;
        i := 0;
        
        while (dec_aux >= 2) loop
            
			if (dec_aux mod 2 = 1) then
            	mods(i) <= '1';
            end if;
                        
            i := i + 1;
            dec_aux := dec_aux / 2;
		end loop;
         
        if (dec_aux = 1) then
         	mods(i) <= '1';
        end if;
    
    end process;
	 
	     bin1 <= mods(7);
		  bin2 <= mods(6);
		  bin3 <= mods(5);
		  bin4 <= mods(4);
		  bin5 <= mods(3);
		  bin6 <= mods(2);
		  bin7 <= mods(1);
		  bin8 <= mods(0);

end architecture;