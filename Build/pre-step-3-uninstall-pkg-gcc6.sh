#!/bin/bash
#

# packages to uninstall for gcc6 on LEDE 17.01

# fails on gcc 6.x and gcc 7.x
./scripts/feeds uninstall bonniexx # some stdlib macros was updated and incompatible now
./scripts/feeds uninstall gcc #native toolchain for run on target platform, using gcc 5.4 - failing to build with gcc 6.x cross-toolchain
./scripts/feeds uninstall haveged #Error: operand value out of range for instruction
./scripts/feeds uninstall linknx  # error: 'suncalc::std::abs' has not been declared
