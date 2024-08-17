library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BINARY2BCD is
    Port ( binary_in : in STD_LOGIC_VECTOR(6 downto 0);
           bcd_out : out STD_LOGIC_VECTOR(11 downto 0));
end BINARY2BCD;

architecture Behavioral of BINARY2BCD is
begin
    process (binary_in)
        variable temp : STD_LOGIC_VECTOR(11 downto 0);
    begin
        temp := (others => '0');  -- Initialize temp to all zeros

        for i in 0 to 6 loop
            if temp(11 downto 8) > "0100" then
                temp(11 downto 8) := temp(11 downto 8) + "0011";
            end if;

            if temp(11 downto 8) > "1001" then
                temp(11 downto 8) := temp(11 downto 8) + "0110";
            end if;

            temp := temp(10 downto 0) & '0';  -- Left shift by 1
            temp(0) := binary_in(6 - i);
        end loop;

        bcd_out <= temp;
    end process;
end Behavioral;
