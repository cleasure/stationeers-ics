#Devices
alias gasSensor d0 #Room Gas Sensor
alias supplyVent d1 #Room Supply Vent
alias returnVent d2 #Room Return Vent

#Registers
alias o2Ratio r0 #Oxygen Ratio
alias polRatio r1 #Pollution Ratio
alias press r2 #Room Pressure in Kpa
alias temp r3 #Room Temperature in K
alias polHigh r4 #Pollutant Ratio is high
alias pressHigh r5 #Pressure is high
alias o2Low r6 #Oxygen is low
alias o2Pol r7 #Oxygen low or polutant high
alias returnVentOn r8

#Initialize
s supplyVent Lock 1
s supplyVent Mode 0
s returnVent Lock 1
s returnVent Mode 1
j start

start:
s supplyVent On 1
s returnVent On 0
j run

run:
l o2Ratio gasSensor RatioOxygen
l polRatio gasSensor RatioPollutant
l press gasSensor Pressure
slt o2Low o2Ratio 0.2 #Oxygen Ratio Setpoint
sge polHigh polRatio 0.001 #Pollutant Setpoint
sgt pressHigh press 110 #High Pressure Setpoint
xor o2Pol o2Low polHigh
xor returnVentOn o2Pol pressHigh
s returnVent On returnVentOn
j run
