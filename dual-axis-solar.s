# Aliases
alias daySen d0
alias writeVer d1
alias writeHor d2

alias angle r0
alias isActive r1
alias isDay r2

Start:
# Check for sun
l isDay d0 Activate
s daySen Mode 1
l angle daySen SolarAngle
blt isDay 1 Reset
move isActive 0

# Vertical
l angle daySen SolarAngle
sub angle 75 angle
div angle angle 1.5
s db Setting angle
s writeVer On 1
yield
s writeVer On 0
yield

# Horizontal
s daySen Mode 2
l angle daySen SolarAngle
mul angle angle -1
s db Setting angle
s writeHor On 1
yield
s writeHor On 0
yield
j Start

# Sunset Reset
Reset:
yield
yield
bnez isActive Start
s db Setting 0
s writeVer On 1
yield
s writeVer On 0
yield
s db Setting -90
s writeHor On 1
yield
s writeHor On 0
yield
move isActive 1
j Start
