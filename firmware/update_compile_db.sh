#!/usr/bin/env bash
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
rc -J compile_commands.json
