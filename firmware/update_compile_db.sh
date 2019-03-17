#!/usr/bin/env bash
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 src/
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 test/
rc --clear
rc -J src/compile_commands.json
rc -J test/compile_commands.json
