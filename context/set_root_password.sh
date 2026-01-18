#!/bin/bash

if [ -n "$ROOT_PASSWORD_HASH" ]; then
    usermod -p "$ROOT_PASSWORD_HASH" root
fi
