#!/usr/bin/env sh
llvm-profdata-7 merge -o testcov.profdata default.profraw
llvm-cov-7 show ./unit-tests -instr-profile=testcov.profdata "$1"
