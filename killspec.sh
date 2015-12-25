#!/bin/bash
ps aux | grep run_base | grep -v grep | awk '{print $2}' | sudo xargs kill

sleep 5

