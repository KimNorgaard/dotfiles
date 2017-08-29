#!/usr/bin/env python3
import subprocess
import re

acpi = subprocess.check_output('acpi', shell=True).strip().decode('utf-8')
if acpi is '':
    exit(0)

is_charging = re.search('Charging', acpi)
percentages = []
for percentage in re.findall(',\s(\d+)%', acpi):
    percentages.append(percentage)

output = ' '
output += ' / '.join(percentages)

print(output)
if is_charging:
    color = '#90a959'
    print()
    print(color)
elif int(percentages[-1]) <= 25:
    color = '#ac4142'
    print()
    print(color)
