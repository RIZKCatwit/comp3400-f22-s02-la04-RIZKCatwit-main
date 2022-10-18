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

## If you run partb with no arguments, print an error message and exit
# with status 1
#
@test "PartA" {
    run partb
    compare "$output" "tests/partb_noarg.txt"
    assert [ "$?" -eq 0 ]
    assert [ "$status" -eq 1 ]
}

## If you run partb with a single argument (lines) exit
# with status 0
#
@test "PartA file1 lines" {
    run partb "tests/file1.txt" lines
    compare "$output" "tests/partb_file1_lines_output.txt"
    assert [ "$?" -eq 0 ]
    assert [ "$status" -eq 0 ]
}

## If you run partb with a single argument (words) exit
# with status 0
#
@test "PartA file1 words" {
    run partb "tests/file1.txt" words
    compare "$output" "tests/partb_file1_words_output.txt"
    assert [ "$?" -eq 0 ]
    assert [ "$status" -eq 0 ]
}
## If you run partb with a single argument (words) exit
# with status 0
#
@test "PartA file2 words" {
    run partb "tests/file2.txt" words
    compare "$output" "tests/partb_file2_words_output.txt"
    assert [ "$?" -eq 0 ]
    assert [ "$status" -eq 0 ]
}

## If you run partb with a single argument (lines) exit
# with status 0
#
@test "PartA file2 lines" {
    run partb "tests/file2.txt" lines
    compare "$output" "tests/partb_file2_lines_output.txt"
    assert [ "$?" -eq 0 ]
    assert [ "$status" -eq 0 ]
}

