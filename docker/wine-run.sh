#!/bin/bash

export WINEPATH="${LD_LIBRARY_PATH//:/;}$WINEPATH"

echo "$WINEPATH" > /tmp/xx

wine "$@"
