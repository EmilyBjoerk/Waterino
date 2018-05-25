#!/usr/bin/env bash
rm default.profraw
rm testcov.profdata
make test
llvm-profdata merge -o testcov.profdata default.profraw
llvm-cov show ./native_tests -instr-profile=testcov.profdata "$@"
