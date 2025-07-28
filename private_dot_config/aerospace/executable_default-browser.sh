#!/usr/bin/env bash

# The only MBP I use is for work, so only return Chrome if I'm on one.
if system_profiler SPHardwareDataType | grep -q "MacBook Pro"; then
  echo "/Applications/Google Chrome.app"
else
  echo "/Applications/Brave Browser.app"
fi
