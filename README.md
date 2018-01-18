# Clitic

Clitic aims to be a collection of templates for Unix command line tools 
written in different programming languages. A template should be a 
starting point to write program that behaves like one would expect a 
Unix command line tool to behave.

It also provides a test suite to test just that behaviour.

## Templates

Currently, templates for the following languages (and argument parsing suites)
are available:

- Python (using argparse)
- Python (using docopt)
- Rust (using docopt)

## Tests

Roughly spoken, the tests check if the templates behave like this:

- run without arguments and output `Hello World`
- run with one or several positional arguments and output them `stdout` each on 
  a new line
- run with one or several positional arguments taken from stdin (using the 
  traditional "-" switch or without using it) and output each on a new line 
- run with the `--version` or `-V` argument and output `foo 0.1.0`
- run with the `--help` or `-h` argument and begin output with 
  `usage` or `Usage`
- send output to `stdout` without causing a broken pipe

See `clitic.bats` for details about the tests.

### Running the tests

To run all the tests:
`make test-all`

To test a particular template, e.g. the Rust template:
`make rust`

Refer to the makefile to see the valid targets for the makefile.

## Pull requests welcome

I'd be happy about useful templates that pass the tests, as well as refinements
to the tests themselves. I'm no Unix wizard, there are probably a lot of 
sensible tests I haven't thought of.
    
## Dependencies

### For running the tests:
- [bash](https://www.gnu.org/software/bash/) >= 0.4.0
- [bats](https://github.com/sstephenson/bats) = 0.4.0
- make

### Python
- argparse
- docopt

### Rust
- cargo

## Name

In linguistics, a Clitic is 
[something that can't stand on its own](http://www.thefreedictionary.com/clitic),
but takes it's meaning from the rest. Like the "'em" in "Beat'em up!". The
same is true for these templates. They'll only mean something if someone uses 
them to actually writes cli tools.