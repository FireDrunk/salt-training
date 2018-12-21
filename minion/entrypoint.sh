#!/bin/bash
set -e

# Log Level
LOG_LEVEL=${LOG_LEVEL:-"error"}

# Run Salt as a Deamon
/usr/bin/salt-minion --log-level=$LOG_LEVEL
