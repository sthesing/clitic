#!/usr/bin/env bats

function setup() {
  command=`cat tmpcmd`
}

@test "invoking without arguments" {
    run $command
    [ "$status" -eq 0 ]
    [ "$output" = "Hello World!" ]
}

@test "invoking with two arguments" {
  run $command bar baz
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "bar" ]
  [ "${lines[1]}" = "baz" ]
}

@test "invoking with two arguments via stdin" {
  run bash -c "grep b test-input.txt | $command"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "bar" ]
  [ "${lines[1]}" = "baz" ]
}

@test "invoking with --version" {
    run $command --version
    [ "$status" -eq 0 ]
    [ "$output" = "foo 0.1.0" ]
}

@test "invoking with --V" {
    run $command -V
    [ "$status" -eq 0 ]
    [ "$output" = "foo 0.1.0" ]
}

@test "invoking with --help" {
    run $command --help
    [ "$status"  -eq 0 ]
    [ "${lines[0]}" = "usage: foo [-h] [-V] [input [input ...]]" ]
}

@test "invoking with -h" {
    run $command -h
    [ "$status"  -eq 0 ]
    [ "${lines[0]}" = "usage: foo [-h] [-V] [input [input ...]]" ]
}