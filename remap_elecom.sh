#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#remapping back button to middle-click
xinput set-button-map $(xinput | grep "ELECOM ELECOM TrackBall Mouse" | sed -e 's/.*id=\([0-9]\).*/\1/') 1 2 3 4 5 6 7 8 2 10 11 12 13 14 15 16

