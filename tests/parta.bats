setup() {
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    load "$DIR/../extern/test_helper/bats-support/load"
    load "$DIR/../extern/test_helper/bats-assert/load"

    PATH="$DIR/../build/src:$PATH"
}

## Helper function that compares program output with the contents
# of a file. If the two differ, return non-negative exit
compare() {
    output="$1"
    expected_file="$2"
    command -v "delta" > /dev/null
    if [ "$?" -eq 0 ]
    then
        DELTA_PAGER=cat delta -s <(echo "$output") "$expected_file"
    else
        diff -y <(echo "$output") "$expected_file"
    fi
}

## If you run parta with no arguments, print an error message and exit
# with status 1
#
@test "PartA" {
    run parta
    compare "$output" "tests/parta_noargs_output.txt"
    assert [ "$?" -eq 0 ]
    assert [ "$status" -eq 1 ]
}

## If you run parta with no arguments, print an error message and exit
# with status 1
#
@test "PartA fox" {
    run parta fox
    compare "$output" "tests/parta_fox_output.txt"
    assert [ "$?" -eq 0 ]
    assert [ "$status" -eq 0 ]
}


## If you run parta with no arguments, print an error message and exit
# with status 1
#
@test "PartA deer" {
    run parta fox
    compare "$output" "tests/parta_fox_output.txt"
    assert [ "$?" -eq 0 ]
    assert [ "$status" -eq 0 ]
}


