#!/bin/bash

ps -ef | grep measure.py | grep -v grep | awk '{print $2}' | xargs sudo kill
