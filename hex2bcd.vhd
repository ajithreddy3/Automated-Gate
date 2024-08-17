library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use work.EE232.all;

entity hex2bcd is
    port ( hex_in  : in  std_logic_vector (7 downto 0) ; --6 DOWNTO 0
           bcd_hun : inout std_logic_vector (3 downto 0) ;
           bcd_ten : inout std_logic_vector (3 downto 0) ;
           bcd_uni : inout std_logic_vector (3 downto 0);
 Y_ONES : out std_logic_vector(6 downto 0);
 Y_TENS : out std_logic_vector(6 downto 0);
 Y_HUNDREDS : out std_logic_vector(6 downto 0));
end hex2bcd ;

architecture arc_hex2bcd of hex2bcd is
SIGNAL F :STD_LOGIC_VECTOR(2 DOWNTO 0);
begin
U0:BCD2SSD PORT MAP (bcd_uni,Y_ONES,F(0));
U1:BCD2SSD PORT MAP (bcd_TEN,Y_TENS,F(1));
U2:BCD2SSD PORT MAP (bcd_hun,Y_HUNDREDS,F(2));

    process ( hex_in )
    variable hex_src : std_logic_vector (4 downto 0) ;
    variable bcd     : std_logic_vector (11 downto 0) ;
begin
bcd             := (others => '0') ;
bcd(2 downto 0) := hex_in(7 downto 5) ;
hex_src         := hex_in(4 downto 0) ;

for i in hex_src'range loop
 if bcd(3 downto 0) > "0100" then
bcd(3 downto 0) := bcd(3 downto 0) + "0011" ;
 end if ;
 if bcd(7 downto 4) > "0100" then
bcd(7 downto 4) := bcd(7 downto 4) + "0011" ;
 end if ;
 -- No roll over for hundred digit, since in 0 .. 2

 bcd := bcd(10 downto 0) & hex_src(hex_src'left) ; -- shift bcd + 1 new entry
 hex_src := hex_src(hex_src'left - 1 downto hex_src'right) & '0' ; -- shift src + pad with 0
end loop ;

bcd_hun <= bcd(11 downto 8) ;
bcd_ten <= bcd(7  downto 4) ;
bcd_uni <= bcd(3  downto 0) ;
end process ;
end arc_hex2bcd;