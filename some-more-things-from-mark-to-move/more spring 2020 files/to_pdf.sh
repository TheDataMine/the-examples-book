#!/bin/bash
source /etc/profile.d/modules.sh
module purge -f -q
module -q load anaconda
module -q load r/3.6.1
jupyter nbconvert $@ --to PDF --output-dir $PWD
