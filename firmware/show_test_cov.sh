#!/usr/bin/env bash
rm default.profraw
rm testcov.profdata
make test
llvm-profdata merge -o testcov.profdata default.profraw

if [ $# -eq 0 ]; then
    llvm-cov report -instr-profile=testcov.profdata ./native_tests
else
    llvm-cov show ./native_tests -instr-profile=testcov.profdata "$@"
fi

