#!/usr/bin/env bash
rm default.profraw
rm testcov.profdata
make test
llvm-profdata-7 merge -o testcov.profdata default.profraw

if [ $# -eq 0 ]; then
    llvm-cov-7 report -instr-profile=testcov.profdata ./unit-tests
else
    llvm-cov-7 show ./unit-tests -instr-profile=testcov.profdata "$@"
fi

