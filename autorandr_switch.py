#!/usr/bin/env python3

import sys
from autorandr import main

x = sys.stdin.readlines()
profiles = next((i,z.split()[0]) for i, z in enumerate(x) if 'current' in z)
next_profile = x[profiles[0] + 1 % len(x)].rstrip()
main(["--load", next_profile])
