#!/bin/bash

export WINEPATH="${LD_LIBRARY_PATH//:/;}$WINEPATH"

wine "$@"
