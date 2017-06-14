# Clitic
Templates and tests for Unix command line tools in different programming languages

## Templates

Clitic aims to be a collection of templates for Unix command line tools 
written in different programming languages.

The idea is to provide templates that

- run without arguments and output `Hello World`
- run with one or several positional arguments and output them `stdout` each on 
  a new line
- run with the `--version` or `-V` argument and output `foo 0.1.0`
- run with the `--help` or `-h` argument and begin output with 
  `usage: foo [-h] [-V] [input [input ...]]`
- can take input from stdin, e.g. in a pipeline

Currently, only one template is available:

- Python

## Tests

Clitic also defines tests for such templates using 
[bats](https://github.com/sstephenson/bats).

See `clitic.bats` for details about the tests.

To run the tests, run `./clitic.sh`.
To add your own template to the test add an entry to the array in `clitic.sh`. 
If you e.g. like to test a template written in C, add:
`array[C]='./foo'`

## Pull requests welcome

I'd be happy about useful templates that pass the tests, as well as refinements
to the tests themselves. I'm no Unix wizard, there are probably a lot of 
sensible tests I haven't thought of.
    
## Dependencies

### For running the tests:
- [bash](https://www.gnu.org/software/bash/) >= 0.4.0
- [bats](https://github.com/sstephenson/bats) = 0.4.0

### Python
- argparse

## Name

[Something that can't stand on its own](http://www.thefreedictionary.com/clitic).