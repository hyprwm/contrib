#!/usr/bin/env -S bats --print-output-on-failure

# It's probably impossible to have 100% coverage due to the nature of grimblast.
# But it's good to test what we can.
# bats tests are TAP compliant, so these can potentially be added to CI pipelines (though these particular tests require interaction).
#
# Pre-requisites:
#   bats
#   bats-assert
#   bats-support
#   bats-file
#   pngcheck
#   satty
#   gimp
#   all the dependencies of grimblast
#
#
# The comments preceding each test are bats tags. These allow you to run specific tests.
#
# Examples assuming you're in the grimblast directory:
#
# Run all tests:
#   ./test/test.bats
#
# Run only the arguments tests:
#   bats --print-output-on-failure --filter-tags arguments test/test.bats
#
# Run arguments and environment, and exclude pretest:
#   bats --print-output-on-failure --filter-tags arguments --filter-tags environment --filter-tags \!pretest test/test.bats

# set $BATS_LIB_PATH only if not set already, default to /usr/lib/bats
setup_file() {
    : "${BATS_LIB_PATH:='/usr/lib/bats'}"
    PATH="${BATS_TEST_DIRNAME}/..:$PATH"
    bats_require_minimum_version 1.5.0
}

# shellcheck disable=SC2155,SC2329
setup() {
    bats_load_library 'bats-support'
    bats_load_library 'bats-assert'
    bats_load_library 'bats-file'
    TEST_DIR="$(temp_make)"
    TEST_EDITOR="satty --filename"

    # Extract the outfile from the output
    # Tests will necessarily need to have DEFAULT_TARGET_DIR="$TEST_DIR"
    extract_outfile_from_output() {
        grep -Eo "$TEST_DIR/.+\.(png|ppm|jpeg)" <<<"$1"
    }
}

teardown() {
    temp_del "$TEST_DIR"
}

# bats test_tags=pretest
@test "There is pngcheck" {
    command -v pngcheck
}

# bats test_tags=basic
@test "Are required tools installed" {
    grimblast check
}

# bats test_tags=basic
@test "Can run grimblast" {
    grimblast usage
}

# bats test_tags=environment
@test "Can set DEFAULT_TARGET_DIR and screenshot active" {
    DEFAULT_TARGET_DIR="$TEST_DIR" run --separate-stderr grimblast save active
    assert_success
    outfile="$(extract_outfile_from_output "$output")"
    assert_file_exist "$outfile"
    pngcheck -q "$outfile"
}

# bats test_tags=environment
@test "Can set DEFAULT_TMP_DIR and edit screen" {
    DEFAULT_TMP_EDITOR_DIR="$TEST_DIR" run --separate-stderr grimblast edit screen
    assert_success
    outfile="$(extract_outfile_from_output "$output")"
    assert_file_exist "$outfile"
    pngcheck -q "$outfile"
}

# bats test_tags=environment
@test "Can set DEFAULT_TMP_DIR, GRIMBLAST_EDITOR and edit screen" {
    DEFAULT_TMP_EDITOR_DIR="$TEST_DIR" GRIMBLAST_EDITOR="$TEST_EDITOR" run --separate-stderr grimblast edit screen
    assert_success
    outfile="$(extract_outfile_from_output "$output")"
    assert_file_exist "$outfile"
    pngcheck -q "$outfile"
}

# bats test_tags=environment
@test "Can set DEFAULT_TARGET_DIR, DATE_FORMAT and screenshot output" {
    DEFAULT_TARGET_DIR="$TEST_DIR" DATE_FORMAT="%F" run --separate-stderr grimblast save output
    assert_success
    assert_output --regexp "[0-9]{4}(-[0-9]{2}){2}"
    outfile="$(extract_outfile_from_output "$output")"
    assert_file_exist "$outfile"
    pngcheck -q "$outfile"
}

# bats test_tags=environment
@test "Can set SLURP_ARGS and screenshot area" {
    DEFAULT_TARGET_DIR="$TEST_DIR" SLURP_ARGS='-b 00ff0080 -c 00ff00 -w 4' run --separate-stderr grimblast save area
    assert_success
    outfile="$(extract_outfile_from_output "$output")"
    assert_file_exist "$outfile"
    pngcheck -q "$outfile"
}

# bats test_tags=arguments
@test "Can screenshot area with freeze and notify at the end" {
    DEFAULT_TARGET_DIR="$TEST_DIR" run --separate-stderr grimblast save area --notify --freeze
    assert_success
    outfile="$(extract_outfile_from_output "$output")"
    assert_file_exist "$outfile"
    pngcheck -q "$outfile"
}

# bats test_tags=arguments
@test "Can screenshot area, to a file, with freeze and notify at the end" {
    run --separate-stderr grimblast save area "$TEST_DIR/test.png" --notify --freeze
    assert_success
    assert_output --partial "$TEST_DIR/test.png"
    assert_file_exist "$TEST_DIR/test.png"
    pngcheck -q "$TEST_DIR/test.png"
}

# bats test_tags=arguments
@test "Can screenshot area, to a file, with options on both sides" {
    run --separate-stderr grimblast -e 8000 --openparentdir save area "$TEST_DIR/test.png" --notify --freeze
    assert_success
    outfile="$(extract_outfile_from_output "$output")"
    assert_file_exist "$outfile"
    pngcheck -q "$outfile"
    # 5 seconds is enough to click on the notification's button to see the file
    sleep 5
}

# bats test_tags=arguments
@test "Can screenshot, with short options and scale value" {
    DEFAULT_TARGET_DIR="$TEST_DIR" run --separate-stderr grimblast -cns 0.5 save screen
    assert_success
    outfile="$(extract_outfile_from_output "$output")"
    assert_file_exist "$outfile"
    pngcheck -q "$outfile"
}

# bats test_tags=arguments
@test "Can screenshot, with long, short combined order alternative way to pass value to wait" {
    run --separate-stderr grimblast -cns 1.75 save screen "$TEST_DIR/test.png" --wait=2
    assert_success
    outfile="$(extract_outfile_from_output "$output")"
    assert_file_exist "$outfile"
    pngcheck -q "$outfile"
}

# bats test_tags=filetype
@test "Can save screenshot in PPM format" {
    DEFAULT_TARGET_DIR="$TEST_DIR" run --separate-stderr grimblast --filetype ppm save active
    assert_success
    assert_output --regexp "$TEST_DIR/.+\.ppm$"
    outfile="$(extract_outfile_from_output "$output")"
    assert_file_exist "$outfile"
    # Validate PPM format using file command
    run file "$outfile"
    assert_output --regexp "Netpbm"
}

# bats test_tags=filetype
@test "Can save screenshot in JPEG format" {
    DEFAULT_TARGET_DIR="$TEST_DIR" run --separate-stderr grimblast --filetype jpeg save active
    assert_success
    assert_output --regexp "$TEST_DIR/.+\.jpeg$"
    outfile="$(extract_outfile_from_output "$output")"
    assert_file_exist "$outfile"
    # Validate JPEG format using file command
    run file "$outfile"
    assert_output --regexp "JPEG image data"
}

# bats test_tags=filetype
@test "Can save screenshot in PPM format with short option" {
    DEFAULT_TARGET_DIR="$TEST_DIR" run --separate-stderr grimblast -t ppm save screen
    assert_success
    assert_output --regexp "$TEST_DIR/.+\.ppm$"
    outfile="$(extract_outfile_from_output "$output")"
    assert_file_exist "$outfile"
    # Validate PPM format
    run file "$outfile"
    assert_output --regexp "Netpbm"
}

# bats test_tags=filetype
@test "Can save screenshot in JPEG format with short option" {
    DEFAULT_TARGET_DIR="$TEST_DIR" run --separate-stderr grimblast -t jpeg save screen
    assert_success
    assert_output --regexp "$TEST_DIR/.+\.jpeg$"
    outfile="$(extract_outfile_from_output "$output")"
    assert_file_exist "$outfile"
    # Validate JPEG format
    run file "$outfile"
    assert_output --regexp "JPEG image data"
}

# bats test_tags=filetype
@test "Copy action rejects non-PNG formats" {
    run grimblast --filetype ppm copy active
    assert_failure
    assert_output --partial "Clipboard operations only support PNG format"
}

# bats test_tags=filetype
@test "Copysave action rejects non-PNG formats" {
    run grimblast --filetype ppm copysave active
    assert_failure
    assert_output --partial "Clipboard operations only support PNG format"
}
