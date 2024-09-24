#!/bin/bash -x

wait=$(../usr/local/bin/cfg_parser.py iprestore.cfg init wait)
device=$(../usr/local/bin/cfg_parser.py iprestore.cfg init device)
echo $wait
echo $device
