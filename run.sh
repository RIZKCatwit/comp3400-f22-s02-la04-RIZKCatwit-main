#!/bin/sh

command="$1"

help() {
    echo "USAGE:"
    echo "  $0 <COMMANDS>"
    echo ""
    echo "  COMMANDS:"
    echo "    build\tBuild code"
    echo "    testa\tRun tests for Part A"
    echo "    testb\tRun tests for Part B"
    echo "    clean\tClear out old files"
    echo "    help\tPrint this help message"
}
build() {
    mkdir -p build
    cd build
    cmake ..
    make -j
    cd -
}
run_tests_a() {
    ./extern/bats/bin/bats tests/parta.bats
}
run_tests_b() {
    ./extern/bats/bin/bats tests/partb.bats
}
clean() {
    rm -rf build
}



if [ "$command" = "help" ]
then
    help
elif [ "$command" = "build" ]
then
    build
elif [ "$command" = "testa" ]
then
    build
    run_tests_a
elif [ "$command" = "testb" ]
then
    build
    run_tests_b
elif [ "$command" = "clean" ]
then
    rm -rf build
else
    help
fi


