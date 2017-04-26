#!/bin/sh

while true
do
  date +%s
  curl test-container.104.155.22.244.xip.io --connect-timeout 1.5 -m 1.5
done
