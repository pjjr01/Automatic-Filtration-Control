settings:
alias filter db
alias LED0 d0
alias LED1 d1
s LED0 Mode 1
s LED1 Mode 1
s LED0 On 1
s LED1 On 1
define MinInPress 0 #kpa
define MaxPress 50000 #kpa
define MinTemp 263.15 #in K
define MaxTemp 303.15 #in K


start:
s LED0 Mode 1
s LED1 Mode 1
s LED0 On 1
s LED1 On 1
ls r1 db 0 Quantity
ls r2 db 1 Quantity
div r1 100 r1
div r2 100 r2
s LED0 Setting r1
s LED1 Setting r2

color1:
beq r1 1 blue1
blt r1 0.991 green1
blue1:
s LED0 Color -1
j color2
green1:
blt r1 0.65 yellow1
s LED0 Color 2
j color2
yellow1:
blt r1 0.30 red1
s LED0 Color 5
j color2
red1:
s LED0 Color 4
j color2

color2:
beq r2 1 blue2
blt r2 0.991 green2
blue2:
s LED1 Color -1
j chckrun
green2:
blt r2 0.65 yellow2
s LED1 Color 2
j chckrun
yellow2:
blt r2 0.30 red2
s LED1 Color 5
j chckrun
red2:
s LED1 Color 4
j chckrun

chckrun:
ls r0 db 0 PrefabHash
l r1 db TemperatureInput
l r2 db PressureOutput
bgt r1 MaxTemp stand
blt r1 MinTemp stand
bge r2 MaxPress stand
checktype:
beq r0 1037507240 hydrogen
beq r0 15011598 hydrogen
beq r0 1255156286 hydrogen
beq r0 -1916176068 hydrogen
beq r0 -1067319543 oxygen
beq r0 -721824748 oxygen
beq r0 -1217998945 oxygen
beq r0 -1055451111 oxygen
beq r0 -632657357 nitrogen
beq r0 -1387439451 nitrogen
beq r0 152751131 nitrogen
beq r0 632853248 nitrogen
beq r0 416897318 carbondiox
beq r0 1876847024 carbondiox
beq r0 -185568964 carbondiox
beq r0 1635000764 carbondiox
beq r0 63677771 pollution
beq r0 1959564765 pollution
beq r0 -503738105 pollution
beq r0 1915566057 pollution
beq r0 1824284061 nitrous
beq r0 465267979 nitrous
beq r0 -123934842 nitrous
beq r0 -1247674305 nitrous

hydrogen:
l r0 db RatioVolatilesInput
j chckmol
oxygen:
l r0 db RatioOxygenInput
j chckmol
nitrogen:
l r0 db RatioNitrogenInput
j chckmol
carbondiox:
l r0 db RatioCarbonDioxideInput
j chckmol
pollution:
l r0 db RatioPollutantInput
j chckmol
nitrous:
l r0 db RatioNitrousOxideInput
j chckmol

chckmol:
l r1 db PressureInput
mul r0 r0 r1
sgt r0 r0 MinInPress
beqz r0 stand
s filter Mode 1
j start

stand:
s db Mode 0
j start