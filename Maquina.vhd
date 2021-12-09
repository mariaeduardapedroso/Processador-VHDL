--importando as bibliotecas 
LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

--Declarando entradas e saidas
entity Maquina is
	port(
	Switch_um1  		   :  IN  BIT;
	Switch_um2  		   :  IN  BIT;
	Switch_um3  		   :  IN  BIT;
	Switch_50_1 	 	   :  IN  BIT;
	Switch_50_2 	 	   :  IN  BIT;
	Switch_50_3 	 	   :  IN  BIT;
	Switch_50_4 	 	   :  IN  BIT;
	Switch_Refri  			:  IN  BIT;
	Switch_Agua	  			:  IN  BIT;
	Reset			  			:  IN  BIT; 
	Letra_1       			:	OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	Letra_2       			:	OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	Letra_3       			:	OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	Num1      			   :	OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	Num2      			   :	OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	Num3      			   :	OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	LedAgua              :  OUT STD_LOGIC;
	LedRefri             :  OUT STD_LOGIC
	);

	end Maquina;
	
	ARCHITECTURE Main of Maquina is
	BEGIN	
		
		PROCESS (Switch_um1, Switch_um2, Switch_um3, Switch_50_1, Switch_50_2, Switch_50_3, Switch_50_4, Switch_Agua, Switch_Refri)
			VARIABLE moedas       : Integer;
			VARIABLE aux          : integer;
			VARIABLE compra       : integer;
			VARIABLE Vswitch_um1  : integer;
			VARIABLE Vswitch_um2  : integer;
			VARIABLE Vswitch_um3  : integer;
			VARIABLE Vswitch_50_1 : integer;
			VARIABLE Vswitch_50_2 : integer;
			VARIABLE Vswitch_50_3 : integer;
			VARIABLE Vswitch_50_4 : integer;
		BEGIN
			
			if (Reset = '1') then
				moedas      :=  0;
				aux         :=  0;
				Vswitch_um1 :=  0;
				Vswitch_um2 :=  0;
				Vswitch_um3 :=  0;
				Vswitch_50_1:=  0;
				Vswitch_50_2:=  0;
				Vswitch_50_3:=  0;
				Vswitch_50_4:=  0;
				Letra_1 <= "11001110"; --R
				Letra_2 <= "10000110"; --E
				Letra_3 <= "10010010"; --S
				num1    <= "10000110"; --E
				num2    <= "11111000"; -- -|
				num3    <= "11001110"; -- |-
			else
			
-------------------------------COLOCAR_MOEDAS-----------------------------------------
			
			if switch_um1 = '1' then
				Vswitch_um1 := 10;
			else 
				Vswitch_um1 := 0;
			end if;
			
			if switch_um2 = '1' then
				Vswitch_um2 := 10;
			else 
				Vswitch_um2 := 0;
			end if;
			
			if switch_um3 = '1' then
				Vswitch_um3 := 10;
			else 
				Vswitch_um3 := 0;
			end if;
			
			if Switch_50_1 = '1' then
				Vswitch_50_1 := 5;
			else 
				Vswitch_50_1 := 0;
			end if;
				
			if Switch_50_2 = '1' then
				Vswitch_50_2 := 5;
			else 
				Vswitch_50_2 := 0;
			end if;
				
			if Switch_50_3 = '1' then
				Vswitch_50_3 := 5;
			else 
				Vswitch_50_3 := 0;
			end if;
				
			if Switch_50_4 = '1' then
				Vswitch_50_4 := 5;
			else 
				Vswitch_50_4 := 0;
			end if;
						
moedas := Vswitch_um1 + Vswitch_um2 + Vswitch_um3 + Vswitch_50_1 + Vswitch_50_2 +Vswitch_50_3 +Vswitch_50_4;	
			
--------------------------------------ESTADOS-----------------------------------------			
			
			if (moedas < 15 and Switch_Agua = '0' and Switch_Refri= '0' ) then --1 estado
				Letra_1  <= "10001110"; -- f 
				Letra_2  <= "10001000"; -- a
				Letra_3  <= "11000111"; -- l
				LedAgua  <= '0';
				LedRefri <= '0';
				
			elsif (moedas = 15 and Switch_Agua = '0' and Switch_Refri= '0') then --2 estado
				Letra_1  <= "00001000"; -- a. 
				Letra_2  <= "11111111"; -- 
				Letra_3  <= "11111111"; -- 
				LedAgua  <= '1';
				LedRefri <= '0';
				
			elsif (moedas >=20 and Switch_Agua = '0' and Switch_Refri= '0') then --3 estado
				Letra_1  <= "00001000"; -- a. 
				Letra_2  <= "10000110"; -- e
				Letra_3  <= "01001110"; -- r.
				LedAgua  <= '1';
				LedRefri <= '1';
			else
				moedas := moedas;
			end if;
			
-------------------------------------COMPRAR--------------------------------------------			
			
			if (moedas >= 15 and Switch_Agua = '1' and Switch_Refri = '0') then  
				Letra_1  <= "01000110"; -- c. 
				Letra_2  <= "10001000"; -- a
				Letra_3  <= "11111111"; -- 
				LedAgua  <= '0';
				LedRefri <= '0';
			elsif (moedas >= 20 and Switch_Refri = '1' and Switch_Agua = '0') then
				Letra_1  <= "01000110"; -- c. 
				Letra_2  <= "11001110"; -- r
				Letra_3  <= "11111111"; -- 
				LedAgua  <= '0';
				LedRefri <= '0';
			end if;	
				
			
---------------------------------LED NUMEROS-------------------------------------------		
                                
			num1 <= "11111111"; -- 
			aux := moedas;
			 if aux < 10 then                       --unidade
					num2 <= "01000000"; -- 0 
			 elsif aux >= 10 and aux < 20 then
					num2 <= "01111001"; -- 1
					aux:= moedas - 10;
			elsif aux >= 20 and aux < 30 then
					num2 <= "00100100"; -- 2
					aux:= moedas - 20;
			elsif aux >= 30 and aux < 40 then
					num2 <= "00110000"; -- 3
					aux:= moedas - 30;
			elsif aux >= 40 and aux < 50 then
					num2 <= "00011001"; -- 4
					aux:= moedas - 40;
			elsif aux >= 50 and aux < 60 then
					num2 <= "00010010"; -- 5
					aux:= moedas - 50;
			end if; 
				
				case aux is                         --centavos
					when  0 =>
						num3 <= "11000000"; -- 0
					when 5 =>
						num3 <= "10010010"; -- 5
					when others =>
					
				end case;
		

	end if;
		
		end PROCESS;	
	end main;
	
	
	
--0 = 11000000
--1 = 11111001
--2 = 10100100
--3 = 10110000
--4 = 10011001
--5 = 10010010
--6 = 10000010
--7 = 11111000
--8 = 10000000
--9 = 10011000 

--A = 10001000
--E = 10000110
--R = 11001110
--F = 10001110
--L = 11000111
	
-- Hex0 == Numero3
-- Hex1 == numero2
-- Hex2 == numero1
-- Hex3 == Letra 3
-- Hex4 == Letra 2
-- Hex5 == Letra 1
	
	
