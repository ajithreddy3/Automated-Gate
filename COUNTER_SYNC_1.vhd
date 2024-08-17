library IEEE ;

use IEEE.std_logic_1164.all;

use work.EE232.all;


entity COUNTER_SYNC_1 is -- Entity declaration

port(CLK : in std_logic; -- Clock input of the counter

UP_DN : in std_logic; -- Count up if UP_DN is high, down if low

LDN : in std_logic; -- Load D to the counter if LDN is low

E : in std_logic; -- Count if E is high, retain otherwise

D : in std_logic_vector(3 downto 0); -- Count to load when LDN is low

Q : inout std_logic_vector(3 downto 0); -- Output state of the counter

Reset : in std_logic);

end COUNTER_SYNC_1;


architecture STRUCTURE of COUNTER_SYNC_1 is

signal C,QN,R: std_logic_vector(3 downto 0);

signal Z : std_logic_vector(15 downto 0 );

signal H : std_logic_vector (13 downto 0);

signal CLK_OUT : std_logic ;

signal RSTN_UP : std_logic ;

signal RSTN_DOWN : std_logic;

signal UP_DNN : std_logic;

signal RSTN_OUT,RSTN : std_logic;


begin

				C0 : CLK_DVD port map (CLK ,'1' , CLK_OUT);

				-- this is the case of what to reset the values to when the RSTN signal is executed

				R(1) <= '0';

				R(2) <= '0';

				R0 : MUX_2X1 port map ('1','0',UP_DN,R(0));

				R1 : MUX_2X1 port map ('1','0',UP_DN,R(3));


				-- modification of the RSTN signal

				-- formatiion of RSTN_UP

				A0 : OR_2 port map (Q(1),Q(2),H(0));

				A1 : OR_2 port map (H(0),Q(0),H(1));

				A2 : AND_2 port map (Q(3),H(1),H(2));

				A4 : NOT_1 port map (H(2),H(3));

				--A3 : AND_2 port map (H(3),UP_DN,RSTN_UP);

				-- formation of RSTN down signal

				A5 : NOT_1 port map (Q(0),H(4));

				A6 : NOT_1 port map (Q(1),H(5));

				A7 : NOT_1 port map (Q(2),H(6));

				A8 : NOT_1 port map (Q(3),H(7));

				A9 : AND_2 port map (H(4),H(5),H(8));

				A10 : AND_2 port map (H(6),H(7),H(9));

				A11 : AND_2 port map (H(8),H(9),H(10));

				A13 : AND_2 port map (H(0),Q(3),H(11));

				A19 : OR_2 port map (H(11),H(10),H(12));

				A14 : NOT_1 port map (H(12),H(13));

				A15 : NOT_1 port map (UP_DN,UP_DNN);

				--A16 : AND_2 port map (UP_DNN,H(13),RSTN_DOWN);


				-- formation of the net RSTN signal

				A20 : MUX_2X1 port map (H(13),H(3),UP_DN,RSTN_UP);

				--A17 : AND_2 port map (RSTN_DOWN,RSTN_UP,H(14));

				A18 : AND_2 port map (RSTN_UP,RSTN,RSTN_OUT);


				-- will do the clk divide later on when needed
				 
					U0 : XOR_2 port map (E,Q(0),Z(0));

					U1 : MUX_2X1 port map (D(0),z(0),LDN,Z(1));

					U2 : MUX_2X1 port map (R(0),Z(1),RSTN_OUT,Z(2));

					U3 : D_FF port map (Z(2),CLK_OUT,'1','1',Q(0),QN(0));

					U4 : MUX_2X1 port map (QN(0),Q(0),UP_DN,Z(3));

					U5 : AND_2 port map (z(3),E,C(0));

					-- done with the first part of the circuit

					U6 : XOR_2 port map (C(0),Q(1),Z(4));

					U7 : MUX_2X1 port map (D(1),z(4),LDN,Z(5));

					U8 : MUX_2X1 port map (R(1),Z(5),RSTN_OUT,Z(6));

					U9 : D_FF port map (Z(6),CLK_OUT,'1','1',Q(1),QN(1));

					U10 : MUX_2X1 port map (QN(1),Q(1),UP_DN,Z(7));

					U11 : AND_2 port map (z(7),C(0),C(1));

					-- done with the second part of the circuit

					U12 : XOR_2 port map (C(1),Q(2),Z(8));

					U13 : MUX_2X1 port map (D(2),z(8),LDN,Z(9));

					U14 : MUX_2X1 port map (R(2),Z(9),RSTN_OUT,Z(10));

					U15 : D_FF port map (Z(10),CLK_OUT,'1','1',Q(2),QN(2));

					U16 : MUX_2X1 port map (QN(2),Q(2),UP_DN,Z(11));

					U17 : AND_2 port map (z(11),C(1),C(2));

					-- done with the third part of the circuit

					U18 : XOR_2 port map (C(2),Q(3),Z(12));

					U19 : MUX_2X1 port map (D(3),z(12),LDN,Z(13));

					U20 : MUX_2X1 port map (R(3),Z(13),RSTN_OUT,Z(14));

					U21 : D_FF port map (Z(14),CLK_OUT,'1','1',Q(3),QN(3));

					U22 : MUX_2X1 port map (QN(3),Q(3),UP_DN,Z(15));

					U23 : AND_2 port map (z(15),C(2),C(3));





end STRUCTURE;


