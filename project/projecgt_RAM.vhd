----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:21:53 10/28/2018 
-- Design Name: 
-- Module Name:    projecgt_RAM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity projecgt_RAM is
	port (clk_100M : in STD_LOGIC ;
			DRDY     : in STD_LOGIC  := '1';
			CS       : in STD_LOGIC := '1';
			Din      : inout STD_LOGIC_VECTOR (7 downto 0) ;
			RD_RW    : in STD_LOGIC := '1';
			adc1_input_data_int_word2 : in STD_LOGIC_VECTOR (7 downto 0);
			adc1_input_data_int_word1 : in STD_LOGIC_VECTOR (15 downto 0));
			





end projecgt_RAM;

architecture Behavioral of projecgt_RAM is

	type	data_states	is	
		(st_8bit, nd_8bit , rd_8bit);


	signal clk_1ns : std_logic := '0'; -- counting every 1 ns
	signal i : integer range 0 to 1000 := 0;
	signal data_state : data_states := st_8bit;
	


begin





	
	process (clk_100M) 
		variable clk_ctr : integer range 0 to 1000000000;
	begin
	 if (rising_edge (clk_100M)) then 
		  clk_ctr := clk_ctr +1;
		  if(clk_ctr > 500000000) then
				clk_ctr :=0;
				clk_1ns<= not clk_1ns;
		end if;
	  end if;
	 end process;
	 
	 
	 process(clk_1ns , DRDY)
		
	 variable ctr_1ns : integer range 0 to 20 := 0;
		
	 begin
		if (rising_edge(clk_1ns) and DRDY = '1') then 
			ctr_1ns := ctr_1ns + 1;
			if ( ctr_1ns = 5) then
				data_state <= st_8bit;
			elsif ( ctr_1ns = 10) then
				data_state <= nd_8bit;
			elsif ( ctr_1ns = 15 ) then 
				data_state <= rd_8bit;
			elsif ( ctr_1ns = 20 ) then 
				ctr_1ns := 0;
		end if;
	 
	 end process;
	 
	 
--	 process (clk_1ns) is 
--	 
--		variable ctr_1ns : integer range + to 50;
--		
--		begin
--			if ( DRDY = '0') then
--				if (rising_edge(clk_1ns)) then
--					ctr_1ns :=ctr_1ns + 1;
--					
	
	process (data_state)
	begin
		case data_state is
			when st_8bit => 
				addr <= i;
				Din <= adc1_input_data_int_word1(15 downto 8);
				i <= i + 1;
			when nd_8bit =>
				addr <= i ;
				Din <= adc1_input_data_int_word1(7 downto 0);
				i <= i +1 ;
			when rd_8bit =>
				addr <= i ;
				Din <= adc1_input_data_int_word1(7 downto 0);
				if (i > 1000) then 
					i <= 0;
				else 
					i <= i + 1;
				end if;
				
			
			
			end case;
	end process;

			
			
	 
	 
		




end Behavioral;

