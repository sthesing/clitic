#!/usr/bin/env bats

function setup() {
  command=`cat tmpcmd`
  cd templates
}

@test "without arguments" {
    run $command
    [ "$status" -eq 0 ]
    [ "$output" = "Hello World!" ]
}

@test "only -t" {
    run $command -t
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Hello World!" ]
    [ "${lines[1]}" = "Test flag set." ]
}

@test "only --test" {
    run $command --test
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Hello World!" ]
    [ "${lines[1]}" = "Test flag set." ]
}


@test "two arguments" {
  run $command bar baz
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "bar" ]
  [ "${lines[1]}" = "baz" ]
}

@test "two arguments via stdin" {
  run bash -c "grep b ../tests/test-input.txt | $command"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "bar" ]
  [ "${lines[1]}" = "baz" ]
}

@test "two arguments via stdin with traditional - switch" {
  run bash -c "grep b ../tests/test-input.txt | $command -"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "bar" ]
  [ "${lines[1]}" = "baz" ]
}


@test "piping stdin input to stdout" {
  run bash -c "grep b ../tests/test-input.txt | $command | cat"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "bar" ]
  [ "${lines[1]}" = "baz" ]
}

@test "-t and one positional argument" {
  run $command bar -t
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "bar" ]
  [ "${lines[1]}" = "Test flag set." ]
}

@test "--test and one positional argument" {
  run $command bar -t
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "bar" ]
  [ "${lines[1]}" = "Test flag set." ]
}

@test "one positional argument and -t" {
  run $command bar -t
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "bar" ]
  [ "${lines[1]}" = "Test flag set." ]
}

@test "one positional argument and --test" {
  run $command bar -t
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "bar" ]
  [ "${lines[1]}" = "Test flag set." ]
}


@test "two argument via stdin and -t" {
  run bash -c "grep b ../tests/test-input.txt | $command -t"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "bar" ]
  [ "${lines[1]}" = "baz" ]
  [ "${lines[2]}" = "Test flag set." ]
}

@test "two argument via stdin and --test" {
  run bash -c "grep b ../tests/test-input.txt | $command -t -"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "bar" ]
  [ "${lines[1]}" = "baz" ]
  [ "${lines[2]}" = "Test flag set." ]
}

@test "two argument via stdin ("-") and -t" {
  run bash -c "grep b ../tests/test-input.txt | $command -t -"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "bar" ]
  [ "${lines[1]}" = "baz" ]
  [ "${lines[2]}" = "Test flag set." ]
}

@test "two argument via stdin ("-") and --test" {
  run bash -c "grep b ../tests/test-input.txt | $command -t"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "bar" ]
  [ "${lines[1]}" = "baz" ]
  [ "${lines[2]}" = "Test flag set." ]
}

@test "with --version" {
    run $command --version
    [ "$status" -eq 0 ]
    [ "$output" = "foo 0.1.0" ]
}

@test "with --V" {
    run $command -V
    [ "$status" -eq 0 ]
    [ "$output" = "foo 0.1.0" ]
}

@test "with --help" {
    run $command --help
    [ "$status"  -eq 0 ]
    [[ "${lines[0]}" =~ ^usage ]] || [[ "${lines[1]}" =~ ^Usage ]]
}

@test "with -h" {
    run $command -h
    [ "$status"  -eq 0 ]
    [[ "${lines[0]}" =~ ^usage ]] || [[ "${lines[1]}" =~ ^Usage ]]
}