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
    [ "${lines[0]}" = "usage: foo [-h] [-V] [input [input ...]]" ] || [ "${lines[1]}" = "Usage:" ]
}

@test "with -h" {
    run $command -h
    [ "$status"  -eq 0 ]
    [ "${lines[0]}" = "usage: foo [-h] [-V] [input [input ...]]" ] || [ "${lines[1]}" = "Usage:" ]
}