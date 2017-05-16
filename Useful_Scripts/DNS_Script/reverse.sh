#!/bin/bash

for ip in $(seq 1 255);do
	host 38.100.193.$ip | grep "megacorp" | cut -d " " -f1,5
done
