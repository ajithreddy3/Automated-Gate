library IEEE;
use IEEE.std_logic_1164.all;
use work.EE232.all;
-- use work.EE232.all; -- You may need to include this if EE232 is your own library

entity MINIAUTOMATEDGATE_1 is
  port (
    CLK   : in std_logic;      -- Clock input of the counter
    OP    : inout std_logic;      -- Input signal
    RSTN  : in std_logic;      -- Reset input (active-low)
    Q     : inout std_logic_vector(3 downto 0);  -- Downcounter output
    O     : inout std_logic;
	 Y : out std_logic_vector(6 downto 0);
	 F : out std_logic;
	 Y2 : out std_logic_vector(6 downto 0);
	 F2 : out std_logic;
	 LDN_s : in std_logic);    -- Output state of the counter
 
end MINIAUTOMATEDGATE_1;

architecture structure of MINIAUTOMATEDGATE_1 is
  signal Q1 : std_logic_vector(3 downto 0);
  SIGNAL D,C ,RESET: STD_LOGIC;
begin
U1 : NOT_1 port map(O,D);
U2 : AND_2 port map(D,OP,C);
	  U0 : TWO_DIGIT port map(CLK,'0','1',C,"0000",Q1,Y,F,Y2,F2,'1');

  PROCESS (OP, RSTN, Q1)
  BEGIN
    if (OP = '1') then
		Q <= Q1;
      if RSTN = '1' then  -- Check for an active-low reset
        O <= '1';  -- Reset the counter value
      else
			if Q1 = "0000" then
          O <= '1';
			else
          O <= '0';
        end if;
      end if;
    else
      O <= '0';
		Q <="0000";--if input is no
    end if;
  END PROCESS;
end structure;